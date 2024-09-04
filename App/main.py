#    This is source code of the IMC-Training App which is intended for IMC training.
#    Copyright (C) 2024  Tobias Schnieders
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
#    You can contact the developer via imctrainingapp.g8199@slmails.com


import kivy
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.utils import platform
import random
import os.path
import json

from kivy.lang import Builder
from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.factory import Factory
from kivy.base import EventLoop


class Popup1(Factory.Popup):
    popupanswer = False
    def on_dismiss(self):
        if self.popupanswer == True:
            App.get_running_app().root.get_screen("imctraining").saveoldexercise = True
            App.get_running_app().root.get_screen("imctraining").nextimcexercisechooser()

class Popup2(Factory.Popup):
    pass

class MainWindow(Screen):
    pass


class StatisticWindow(Screen):
    pass

class LicenceReadmeWindow(Screen):
    def switchacceptchange(self):
        self.continuebutton.disabled = not self.switchaccept.active
    def continuebuttonpress(self):
        trainingdata['einstellungen']['eula_agreed'] = "Yes"
        trainingdata_aktualisieren(self)
        App.get_running_app().root.current = "main"

class IMCTrainingWindow(Screen):
    saveoldexercise = False
    aktuelleimcaufgabe = [0,0,0]
    def solvedandnextimcexercisechooser(self):
        Popup1instance = Factory.Popup1()
        Popup1instance.popuptext.text = "Soll " + self.currentimcexercise.text + " als gelöst markiert werden?" if trainingdata['einstellungen']['language'] == "Deutsch" else "Mark " + self.currentimcexercise.text + " as solved?"
        Popup1instance.title = "Sicher?" if trainingdata['einstellungen']['language'] == "Deutsch" else "Sure?"
        Popup1instance.nobutton.text = "Nein" if trainingdata['einstellungen']['language'] == "Deutsch" else "No"
        Popup1instance.yesbutton.text = "Ja" if trainingdata['einstellungen']['language'] == "Deutsch" else "Yes"
        Popup1instance.open()
    def nextimcexercisechooser(self):
        if self.saveoldexercise:
            self.saveoldexercise = False
            trainingdata['imc'][self.aktuelleimcaufgabe[0]][str(self.aktuelleimcaufgabe[1])][(self.aktuelleimcaufgabe[2]-1)] = "s"
            trainingdata_aktualisieren(self)
        if trainingdata['einstellungen']['onlynewimcexercises'] == False:
            self.aktuelleimcaufgabe[0] = random.choice(list(trainingdata['imc'].keys()))
            self.aktuelleimcaufgabe[1] = random.randint(1,2)
            self.aktuelleimcaufgabe[2] = random.randint(1,trainingdata['imc'][self.aktuelleimcaufgabe[0]]['numberofproblemsperday']) # Achtung! [0] ist str, [1] und [2] int
            self.currentimcexercise.text = self.aktuelleimcaufgabe[0] + " / " + str(self.aktuelleimcaufgabe[1]) if trainingdata['einstellungen']['hideexercisenumber'] else self.aktuelleimcaufgabe[0] + " / " + str(self.aktuelleimcaufgabe[1]) + " / " + str(self.aktuelleimcaufgabe[2])
            if os.path.isfile('./images/'+str(self.aktuelleimcaufgabe[0])+'/'+str(self.aktuelleimcaufgabe[1])+'/'+str(self.aktuelleimcaufgabe[2])+'.jpg'):
                self.imcimage.source = './images/'+str(self.aktuelleimcaufgabe[0])+'/'+str(self.aktuelleimcaufgabe[1])+'/'+str(self.aktuelleimcaufgabe[2])+'.jpg'
            else:
                self.imcimage.source = './images/nottexed.jpg'
            self.solvedandnextexercise.disabled = False
            trainingdata['numberofrandom'] += 1
            trainingdata_aktualisieren(self)
        else:
            if imcproblemeungeloest > 0:
                x = random.randint(1,imcproblemeungeloest)
                for jahr in trainingdata['imc']:
                        for tag in trainingdata['imc'][jahr]:
                            if tag == "1" or tag == "2":
                                for j in range(len(trainingdata['imc'][jahr][tag])):
                                    if trainingdata['imc'][jahr][tag][j] == "u":
                                        if x > 1:
                                            x -= 1
                                        elif x == 1:
                                            self.aktuelleimcaufgabe[0] = jahr
                                            self.aktuelleimcaufgabe[1] = tag
                                            self.aktuelleimcaufgabe[2] = j+1
                                            x -= 1
                self.currentimcexercise.text = self.aktuelleimcaufgabe[0] + " / " + str(self.aktuelleimcaufgabe[1]) if trainingdata['einstellungen']['hideexercisenumber'] else self.aktuelleimcaufgabe[0] + " / " + str(self.aktuelleimcaufgabe[1]) + " / " + str(self.aktuelleimcaufgabe[2])
                if os.path.isfile('./images/'+str(self.aktuelleimcaufgabe[0])+'/'+str(self.aktuelleimcaufgabe[1])+'/'+str(self.aktuelleimcaufgabe[2])+'.jpg'):
                    self.imcimage.source = './images/'+str(self.aktuelleimcaufgabe[0])+'/'+str(self.aktuelleimcaufgabe[1])+'/'+str(self.aktuelleimcaufgabe[2])+'.jpg'
                else:
                    self.imcimage.source = './images/nottexed.jpg'
                self.solvedandnextexercise.disabled = False
                trainingdata['numberofrandom'] += 1
                trainingdata_aktualisieren(self)
            else:
                self.currentimcexercise.text = "Alles gelöst!" if trainingdata['einstellungen']['language'] == "Deutsch" else "All solved!"
                self.solvedandnextexercise.disabled = True
                self.imcimage.source = './images/empty.jpg'

class IMCShowWindow(Screen):
    def jahrspin(self):
        self.showexercise.text = ""
        if self.showjahr.text != "" and self.showtag.text != "":
            if trainingdata['imc'][self.showjahr.text]['numberofproblemsperday'] == 4:
                self.showexercise.values = "1","2","3","4"
            elif trainingdata['imc'][self.showjahr.text]['numberofproblemsperday'] == 5:
                self.showexercise.values = "1","2","3","4","5"
            elif trainingdata['imc'][self.showjahr.text]['numberofproblemsperday'] == 6:
                self.showexercise.values = "1","2","3","4","5","6"
    def tagspin(self):
        self.jahrspin()
    def exercisespin(self):
        if self.showexercise.text != "":
            if os.path.isfile('./images/'+self.showjahr.text+'/'+self.showtag.text+'/'+self.showexercise.text+'.jpg'):
                self.showimage.source = './images/'+self.showjahr.text+'/'+self.showtag.text+'/'+self.showexercise.text+'.jpg'
            else:
                self.showimage.source = './images/nottexed.jpg'

class MikeRandomExerciseWindow(Screen):
    numberofexercisesinkapitel = {1:60,2:28,3:42,4:45,5:89,6:50,7:54,8:48,9:31,10:55,11:31,12:76}
    def exercise_chooser(self):
        kapitel = random.randint(1,12)
        aufgabe = random.randint(1,self.numberofexercisesinkapitel[kapitel])
        self.exercise_label.text = str(kapitel)+' / '+str(aufgabe)
        trainingdata['numberofrandom'] += 1
        trainingdata_aktualisieren(self)
    def exercise_chooser_c8(self):
        self.exercise_label.text = trainingdata['einstellungen']['miketrainingtopic'] + ' / ' + str(random.randint(1,self.numberofexercisesinkapitel[int(trainingdata['einstellungen']['miketrainingtopic'])]))
        trainingdata['numberofrandom'] += 1
        trainingdata_aktualisieren(self)

class EinstellungsWindow(Screen):
    def changeswitchonlynewimcexersices(self):
        trainingdata['einstellungen']['onlynewimcexercises'] = self.switchonlynewimcexersices.active
        trainingdata_aktualisieren(self)
    def changeswitchusemikestraining(self):
        trainingdata['einstellungen']['usemikestraining'] = self.switchusemikestraining.active
        trainingdata_aktualisieren(self)
    def changeswitchhideexercisenumber(self):
        trainingdata['einstellungen']['hideexercisenumber'] = self.switchhideexercisenumber.active
        trainingdata_aktualisieren(self)
    def changemikespinner(self):
        trainingdata['einstellungen']['miketrainingtopic'] = self.miketrainingtopicspin.text
        trainingdata_aktualisieren(self)
    def changelanguagespinner(self):
        trainingdata['einstellungen']['language'] = self.languagespin.text
        trainingdata_aktualisieren(self)
    def showreadmeandlicence(self):
        Popup2instance = Factory.Popup2()
        Popup2instance.open()

class StatusimcproblemeWindow(Screen):
    def changejahrspinner(self):
        if self.statustag.text != "":
            self.changetagspinner()
    def changetagspinner(self):
        if self.statusjahr.text != "":
            self.labeltextid.text = "Folgende Probleme der IMC " + self.statusjahr.text + ",\nTag " + self.statustag.text + ", sind als gelöst markiert:" if trainingdata['einstellungen']['language'] == "Deutsch" else "Problems of IMC " + self.statusjahr.text + " / " + self.statustag.text + "\nMarked as solved are:"
            self.gridaufgabe1.opacity = 1
            self.gridaufgabe2.opacity = 1
            self.gridaufgabe3.opacity = 1
            self.gridaufgabe4.opacity = 1
            self.aufgabe1.disabled = False
            self.aufgabe2.disabled = False
            self.aufgabe3.disabled = False
            self.aufgabe4.disabled = False
            self.aufgabe1.active = True if trainingdata['imc'][self.statusjahr.text][self.statustag.text][0] == "s" else False
            self.aufgabe2.active = True if trainingdata['imc'][self.statusjahr.text][self.statustag.text][1] == "s" else False
            self.aufgabe3.active = True if trainingdata['imc'][self.statusjahr.text][self.statustag.text][2] == "s" else False
            self.aufgabe4.active = True if trainingdata['imc'][self.statusjahr.text][self.statustag.text][3] == "s" else False
            if trainingdata['imc'][self.statusjahr.text]['numberofproblemsperday'] == 4:
                self.gridaufgabe5.opacity = 0
                self.gridaufgabe6.opacity = 0
                self.aufgabe5.disabled = True
                self.aufgabe6.disabled = True
                self.aufgabe5.active = False
                self.aufgabe6.active = False
            elif trainingdata['imc'][self.statusjahr.text]['numberofproblemsperday'] == 5:
                self.gridaufgabe5.opacity = 1
                self.gridaufgabe6.opacity = 0
                self.aufgabe5.disabled = False
                self.aufgabe6.disabled = True
                self.aufgabe5.active = True if trainingdata['imc'][self.statusjahr.text][self.statustag.text][4] == "s" else False
                self.aufgabe6.active = False
            else:
                self.gridaufgabe5.opacity = 1
                self.gridaufgabe6.opacity = 1
                self.aufgabe5.disabled = False
                self.aufgabe6.disabled = False
                self.aufgabe5.active = True if trainingdata['imc'][self.statusjahr.text][self.statustag.text][4] == "s" else False
                self.aufgabe6.active = True if trainingdata['imc'][self.statusjahr.text][self.statustag.text][5] == "s" else False
    def changeaufgabe1(self):
        trainingdata['imc'][self.statusjahr.text][self.statustag.text][0] = "s" if self.aufgabe1.active else "u"
        trainingdata_aktualisieren(self)
    def changeaufgabe2(self):
        trainingdata['imc'][self.statusjahr.text][self.statustag.text][1] = "s" if self.aufgabe2.active else "u"
        trainingdata_aktualisieren(self)
    def changeaufgabe3(self):
        trainingdata['imc'][self.statusjahr.text][self.statustag.text][2] = "s" if self.aufgabe3.active else "u"
        trainingdata_aktualisieren(self)
    def changeaufgabe4(self):
        trainingdata['imc'][self.statusjahr.text][self.statustag.text][3] = "s" if self.aufgabe4.active else "u"
        trainingdata_aktualisieren(self)
    def changeaufgabe5(self):
        trainingdata['imc'][self.statusjahr.text][self.statustag.text][4] = "s" if self.aufgabe5.active else "u"
        trainingdata_aktualisieren(self)
    def changeaufgabe6(self):
        trainingdata['imc'][self.statusjahr.text][self.statustag.text][5] = "s" if self.aufgabe6.active else "u"
        trainingdata_aktualisieren(self)

class WindowManager(ScreenManager):
    pass

kv = Builder.load_file("kv.kv")
#kivy.require('2.0.0') ##??? 1.9.1

storage_path = '.'
android_speicher_DEBUG = False # True, iff the proper secure android space is used
if platform == 'android':
    from android import mActivity
    context = mActivity.getApplicationContext()
    result =  context.getExternalFilesDir(None)
    if result:
        storage_path =  str(result.toString())
        android_speicher_DEBUG = True
    else:
        storage_path = app_storage_path()

def trainingdata_aktualisieren(self):
    with open(storage_path+'/imc-training-data.json','w') as jsonfile:
        json.dump(trainingdata, jsonfile)
    App.get_running_app().root.get_screen("main").mikestrainingstarteronmainwindow.disabled = not trainingdata['einstellungen']['usemikestraining']
    App.get_running_app().root.get_screen("main").mikestrainingstarteronmainwindow.opacity = 1 if trainingdata['einstellungen']['usemikestraining'] else 0
    App.get_running_app().root.get_screen("main").mikestrainingstarteronmainwindow.size_hint_y = 1 if trainingdata['einstellungen']['usemikestraining'] else 0
    App.get_running_app().root.get_screen("mikerandom").zusatzknopf.text = "Neue Aufgabe aus Kapitel " + trainingdata['einstellungen']['miketrainingtopic'] if trainingdata['einstellungen']['language'] == "Deutsch" else "New exercise from chapter " + trainingdata['einstellungen']['miketrainingtopic']
    App.get_running_app().root.get_screen("einstellungen").languagespin.text = trainingdata['einstellungen']['language']
    App.get_running_app().root.get_screen("einstellungen").switchonlynewimcexersices.active = trainingdata['einstellungen']['onlynewimcexercises']
    App.get_running_app().root.get_screen("einstellungen").switchusemikestraining.active = trainingdata['einstellungen']['usemikestraining']
    App.get_running_app().root.get_screen("einstellungen").switchhideexercisenumber.active = trainingdata['einstellungen']['hideexercisenumber']
    App.get_running_app().root.get_screen("einstellungen").randomcounterlabel.text = "Zufallsgenerator bisher " +str(trainingdata['numberofrandom'])+"-mal genutzt" if trainingdata['einstellungen']['language'] == "Deutsch" else "Randomizer used " +str(trainingdata['numberofrandom'])+" times"
    App.get_running_app().root.get_screen("einstellungen").importantinformationbutton.text = "Wichtige Informationen" if trainingdata['einstellungen']['language'] == "Deutsch" else "Important information"
    App.get_running_app().root.get_screen("einstellungen").miketrainingtopicspin.text = trainingdata['einstellungen']['miketrainingtopic']
    App.get_running_app().root.get_screen("einstellungen").miketrainingtopicspin.disabled = not App.get_running_app().root.get_screen("einstellungen").switchusemikestraining.active
    App.get_running_app().root.get_screen("einstellungen").miketrainingtopicspin.opacity = 1 if App.get_running_app().root.get_screen("einstellungen").switchusemikestraining.active else 0.6
    App.get_running_app().root.get_screen("einstellungen").miketrainingtopicspinlabel.opacity = 1 if App.get_running_app().root.get_screen("einstellungen").switchusemikestraining.active else 0.3
    selfvonstatusimcprobleme = App.get_running_app().root.get_screen("statusimcprobleme")
    if selfvonstatusimcprobleme.statusjahr.text != "" and selfvonstatusimcprobleme.statustag.text != "":
        selfvonstatusimcprobleme.aufgabe1.active = True if trainingdata['imc'][selfvonstatusimcprobleme.statusjahr.text][selfvonstatusimcprobleme.statustag.text][0] == "s" else False
        selfvonstatusimcprobleme.aufgabe2.active = True if trainingdata['imc'][selfvonstatusimcprobleme.statusjahr.text][selfvonstatusimcprobleme.statustag.text][1] == "s" else False
        selfvonstatusimcprobleme.aufgabe3.active = True if trainingdata['imc'][selfvonstatusimcprobleme.statusjahr.text][selfvonstatusimcprobleme.statustag.text][2] == "s" else False
        selfvonstatusimcprobleme.aufgabe4.active = True if trainingdata['imc'][selfvonstatusimcprobleme.statusjahr.text][selfvonstatusimcprobleme.statustag.text][3] == "s" else False
        if trainingdata['imc'][selfvonstatusimcprobleme.statusjahr.text]['numberofproblemsperday'] == 4:
            selfvonstatusimcprobleme.aufgabe5.active = False
            selfvonstatusimcprobleme.aufgabe6.active = False
        elif trainingdata['imc'][selfvonstatusimcprobleme.statusjahr.text]['numberofproblemsperday'] == 5:
            selfvonstatusimcprobleme.aufgabe5.active = True if trainingdata['imc'][selfvonstatusimcprobleme.statusjahr.text][selfvonstatusimcprobleme.statustag.text][4] == "s" else False
            selfvonstatusimcprobleme.aufgabe6.active = False
        else:
            selfvonstatusimcprobleme.gridaufgabe5.opacity = 1
            selfvonstatusimcprobleme.gridaufgabe6.opacity = 1
            selfvonstatusimcprobleme.aufgabe5.disabled = False
            selfvonstatusimcprobleme.aufgabe6.disabled = False
            selfvonstatusimcprobleme.aufgabe5.active = True if trainingdata['imc'][selfvonstatusimcprobleme.statusjahr.text][selfvonstatusimcprobleme.statustag.text][4] == "s" else False
            selfvonstatusimcprobleme.aufgabe6.active = True if trainingdata['imc'][selfvonstatusimcprobleme.statusjahr.text][selfvonstatusimcprobleme.statustag.text][5] == "s" else False
    #Zaehle Probleme insgesamt
    global imcproblemegesamt
    global imcproblemeungeloest
    imcproblemegesamt = 0
    imcproblemeungeloest = 0
    for jahr in trainingdata['imc']:
        for tag in trainingdata['imc'][jahr]:
            if tag == "1" or tag == "2":
                for i in trainingdata['imc'][jahr][tag]:
                    if i == "u":
                        imcproblemeungeloest += 1
        imcproblemegesamt += 2*int(trainingdata['imc'][jahr]['numberofproblemsperday'])
    # App.get_running_app().root.get_screen("einstellungen").imcstatistik.text = "Bisher "+str(imcproblemegesamt-imcproblemeungeloest)+" von "+str(imcproblemegesamt)+" IMC-Aufgaben gelöst (" + str(round(100*(imcproblemegesamt-imcproblemeungeloest)/imcproblemegesamt,2))+"%)" if trainingdata['einstellungen']['language'] == "Deutsch" else "Solved "+str(imcproblemegesamt-imcproblemeungeloest)+" out of "+str(imcproblemegesamt)+" IMC problems (" + str(round(100*(imcproblemegesamt-imcproblemeungeloest)/imcproblemegesamt,2))+"%)" Das war die kleine Statistik in den Einstellungen
    App.get_running_app().root.get_screen("statisticwindow").statisticlabel1.text = "Bisher "+str(imcproblemegesamt-imcproblemeungeloest)+" von "+str(imcproblemegesamt)+" IMC-Aufgaben gelöst (" + str(round(100*(imcproblemegesamt-imcproblemeungeloest)/imcproblemegesamt,2))+"%)" if trainingdata['einstellungen']['language'] == "Deutsch" else "Solved "+str(imcproblemegesamt-imcproblemeungeloest)+" out of "+str(imcproblemegesamt)+" IMC problems (" + str(round(100*(imcproblemegesamt-imcproblemeungeloest)/imcproblemegesamt,2))+"%)"
    #Sprache anpassen
    App.get_running_app().root.get_screen("main").imctrainingstartbutton.text = "IMC-Training" if trainingdata['einstellungen']['language'] == "Deutsch" else "IMC Training"
    App.get_running_app().root.get_screen("main").imcproblemstartbutton.text = "IMC-Probleme" if trainingdata['einstellungen']['language'] == "Deutsch" else "IMC Problems"
    App.get_running_app().root.get_screen("main").mikestrainingstarteronmainwindow.text = "Mike's Training" if trainingdata['einstellungen']['language'] == "Deutsch" else "Mike's Training"
    App.get_running_app().root.get_screen("main").statisticstartbutton.text = "Statistik" if trainingdata['einstellungen']['language'] == "Deutsch" else "Statistics"
    App.get_running_app().root.get_screen("main").settingsstartbutton.text = "Einstellungen" if trainingdata['einstellungen']['language'] == "Deutsch" else "Settings"
    App.get_running_app().root.get_screen("imctraining").textnextexercise.text = "Nächste IMC-Aufgabe:" if trainingdata['einstellungen']['language'] == "Deutsch" else "Next IMC problem:"
    App.get_running_app().root.get_screen("imctraining").solvedandnextexercise.text = "Aufgabe gelöst, neue Aufgabe" if trainingdata['einstellungen']['language'] == "Deutsch" else "Problem solved, new problem"
    App.get_running_app().root.get_screen("imctraining").onlynewexercise.text = "Neue Aufgabe" if trainingdata['einstellungen']['language'] == "Deutsch" else "New problem"
    App.get_running_app().root.get_screen("imcshow").jahrtext.text = "Jahr" if trainingdata['einstellungen']['language'] == "Deutsch" else "Year"
    App.get_running_app().root.get_screen("imcshow").tagtext.text = "Tag" if trainingdata['einstellungen']['language'] == "Deutsch" else "Day"
    App.get_running_app().root.get_screen("imcshow").aufgabetext.text = "Aufgabe" if trainingdata['einstellungen']['language'] == "Deutsch" else "Problem"
    App.get_running_app().root.get_screen("mikerandom").mikerandomnewexercisetext.text = "Nächste Aufgabe:" if trainingdata['einstellungen']['language'] == "Deutsch" else "Next exercise:"
    App.get_running_app().root.get_screen("mikerandom").mikerandomnewexercise.text = "Neue Aufgabe" if trainingdata['einstellungen']['language'] == "Deutsch" else "New exercise"
    App.get_running_app().root.get_screen("einstellungen").usealsomikestrainingtext.text = "Nutze auch Mike's Training" if trainingdata['einstellungen']['language'] == "Deutsch" else "Also use Mike's training"
    App.get_running_app().root.get_screen("einstellungen").miketrainingtopicspinlabel.text = "Thema in Mike's Training" if trainingdata['einstellungen']['language'] == "Deutsch" else "Chapter of Mike's training"
    App.get_running_app().root.get_screen("einstellungen").zeigenurungeloestetext.text = "Zeige nur ungelöste IMC-Aufgaben" if trainingdata['einstellungen']['language'] == "Deutsch" else "Show only unsolved IMC problems"
    App.get_running_app().root.get_screen("einstellungen").verbergeaufgabennummerntext.text = "Verberge IMC-Aufgabennummern" if trainingdata['einstellungen']['language'] == "Deutsch" else "Hide IMC problem numbers"
    App.get_running_app().root.get_screen("einstellungen").seestatusofimcproblemsbutton.text = "Status der IMC-Probleme einsehen/ändern" if trainingdata['einstellungen']['language'] == "Deutsch" else "View/change status of IMC problems"
    App.get_running_app().root.get_screen("einstellungen").seestatusofimcproblemsbutton.text = "Status der IMC-Probleme einsehen/ändern" if trainingdata['einstellungen']['language'] == "Deutsch" else "View/change status of IMC problems"
    App.get_running_app().root.get_screen("statusimcprobleme").chooseyeartext.text = "Wähle Jahr" if trainingdata['einstellungen']['language'] == "Deutsch" else "Year"
    App.get_running_app().root.get_screen("statusimcprobleme").choosedaytext.text = "Wähle Tag" if trainingdata['einstellungen']['language'] == "Deutsch" else "Day"
    App.get_running_app().root.get_screen("statusimcprobleme").exercise1text.text = "Aufgabe 1" if trainingdata['einstellungen']['language'] == "Deutsch" else "Problem 1"
    App.get_running_app().root.get_screen("statusimcprobleme").exercise2text.text = "Aufgabe 2" if trainingdata['einstellungen']['language'] == "Deutsch" else "Problem 2"
    App.get_running_app().root.get_screen("statusimcprobleme").exercise3text.text = "Aufgabe 3" if trainingdata['einstellungen']['language'] == "Deutsch" else "Problem 3"
    App.get_running_app().root.get_screen("statusimcprobleme").exercise4text.text = "Aufgabe 4" if trainingdata['einstellungen']['language'] == "Deutsch" else "Problem 4"
    App.get_running_app().root.get_screen("statusimcprobleme").exercise5text.text = "Aufgabe 5" if trainingdata['einstellungen']['language'] == "Deutsch" else "Problem 5"
    App.get_running_app().root.get_screen("statusimcprobleme").exercise6text.text = "Aufgabe 6" if trainingdata['einstellungen']['language'] == "Deutsch" else "Problem 6"
    
    
    



    



class MyMainApp(App):
    def on_start(self):
        EventLoop.window.bind(on_keyboard=self.hook_keyboard)
        self.root.get_screen("statusimcprobleme").statusjahr.values = list(trainingdata['imc'].keys())
        self.root.get_screen("imcshow").showjahr.values = list(trainingdata['imc'].keys())
        trainingdata_aktualisieren(self)
        if trainingdata['einstellungen']['eula_agreed'] != "Yes":
            self.root.current = "licencereadme"
    def hook_keyboard(self, window, key, *largs):
        if key == 27:
            print("Zurück")
            if self.root.current == "statusimcprobleme":
                self.root.current = "einstellungen"
            elif self.root.current == "licencereadme":
                pass
            else:
                self.root.current = "main"
            self.root.transition.direction = "right"
            return True
    def build(self):
        return kv


# Erstelle und repariere trainingsdata
if not os.path.isfile(storage_path+'/imc-training-data.json'):
    trainingdata = {}
    with open(storage_path+'/imc-training-data.json','w') as jsonfile:
        json.dump(trainingdata, jsonfile)
else:
    with open(storage_path+'/imc-training-data.json','r') as jsonfile:
        trainingdata = json.load(jsonfile)
if 'imc' not in trainingdata:
    trainingdata['imc'] = {}
if '1994' not in trainingdata['imc']:
    trainingdata['imc']['1994'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '1995' not in trainingdata['imc']:
    trainingdata['imc']['1995'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '1996' not in trainingdata['imc']:
    trainingdata['imc']['1996'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '1997' not in trainingdata['imc']:
    trainingdata['imc']['1997'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '1998' not in trainingdata['imc']:
    trainingdata['imc']['1998'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '1999' not in trainingdata['imc']:
    trainingdata['imc']['1999'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '2000' not in trainingdata['imc']:
    trainingdata['imc']['2000'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '2001' not in trainingdata['imc']:
    trainingdata['imc']['2001'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '2002' not in trainingdata['imc']:
    trainingdata['imc']['2002'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '2003' not in trainingdata['imc']:
    trainingdata['imc']['2003'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '2004' not in trainingdata['imc']:
    trainingdata['imc']['2004'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '2005' not in trainingdata['imc']:
    trainingdata['imc']['2005'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '2006' not in trainingdata['imc']:
    trainingdata['imc']['2006'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '2007' not in trainingdata['imc']:
    trainingdata['imc']['2007'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '2008' not in trainingdata['imc']:
    trainingdata['imc']['2008'] = {'1':['u','u','u','u','u','u'],'2':['u','u','u','u','u','u'],'numberofproblemsperday':6}
if '2009' not in trainingdata['imc']:
    trainingdata['imc']['2009'] = {'1':['u','u','u','u','u'],'2':['u','u','u','u','u'],'numberofproblemsperday':5}
if '2010' not in trainingdata['imc']:
    trainingdata['imc']['2010'] = {'1':['u','u','u','u','u'],'2':['u','u','u','u','u'],'numberofproblemsperday':5}
if '2011' not in trainingdata['imc']:
    trainingdata['imc']['2011'] = {'1':['u','u','u','u','u'],'2':['u','u','u','u','u'],'numberofproblemsperday':5}
if '2012' not in trainingdata['imc']:
    trainingdata['imc']['2012'] = {'1':['u','u','u','u','u'],'2':['u','u','u','u','u'],'numberofproblemsperday':5}
if '2013' not in trainingdata['imc']:
    trainingdata['imc']['2013'] = {'1':['u','u','u','u','u'],'2':['u','u','u','u','u'],'numberofproblemsperday':5}
if '2014' not in trainingdata['imc']:
    trainingdata['imc']['2014'] = {'1':['u','u','u','u','u'],'2':['u','u','u','u','u'],'numberofproblemsperday':5}
if '2015' not in trainingdata['imc']:
    trainingdata['imc']['2015'] = {'1':['u','u','u','u','u'],'2':['u','u','u','u','u'],'numberofproblemsperday':5}
if '2016' not in trainingdata['imc']:
    trainingdata['imc']['2016'] = {'1':['u','u','u','u','u'],'2':['u','u','u','u','u'],'numberofproblemsperday':5}
if '2017' not in trainingdata['imc']:
    trainingdata['imc']['2017'] = {'1':['u','u','u','u','u'],'2':['u','u','u','u','u'],'numberofproblemsperday':5}
if '2018' not in trainingdata['imc']:
    trainingdata['imc']['2018'] = {'1':['u','u','u','u','u'],'2':['u','u','u','u','u'],'numberofproblemsperday':5}
if '2019' not in trainingdata['imc']:
    trainingdata['imc']['2019'] = {'1':['u','u','u','u','u'],'2':['u','u','u','u','u'],'numberofproblemsperday':5}
if '2020' not in trainingdata['imc']:
    trainingdata['imc']['2020'] = {'1':['u','u','u','u'],'2':['u','u','u','u'],'numberofproblemsperday':4}
if '2021' not in trainingdata['imc']:
    trainingdata['imc']['2021'] = {'1':['u','u','u','u'],'2':['u','u','u','u'],'numberofproblemsperday':4}
if '2022' not in trainingdata['imc']:
    trainingdata['imc']['2022'] = {'1':['u','u','u','u'],'2':['u','u','u','u'],'numberofproblemsperday':4}
if '2023' not in trainingdata['imc']:
    trainingdata['imc']['2023'] = {'1':['u','u','u','u','u'],'2':['u','u','u','u','u'],'numberofproblemsperday':5}
if '2024' not in trainingdata['imc']:
    trainingdata['imc']['2024'] = {'1':['u','u','u','u','u'],'2':['u','u','u','u','u'],'numberofproblemsperday':5}
if 'numberofrandom' not in trainingdata:
    trainingdata['numberofrandom'] = 0
if 'einstellungen' not in trainingdata:
    trainingdata['einstellungen'] = {}
if 'onlynewimcexercises' not in trainingdata['einstellungen']:
    trainingdata['einstellungen']['onlynewimcexercises'] = True
if 'usemikestraining' not in trainingdata['einstellungen']:
    trainingdata['einstellungen']['usemikestraining'] = False
if 'miketrainingtopic' not in trainingdata['einstellungen']:
    trainingdata['einstellungen']['miketrainingtopic'] = "1"
if 'hideexercisenumber' not in trainingdata['einstellungen']:
    trainingdata['einstellungen']['hideexercisenumber'] = False
if 'language' not in trainingdata['einstellungen']:
    trainingdata['einstellungen']['language'] = "English"
if 'eula_agreed' not in trainingdata['einstellungen']:
    trainingdata['einstellungen']['eula_agreed'] = "No"


#Letzte Übermittlung
popupanswer = None


if __name__ == "__main__":
    MyMainApp().run()

