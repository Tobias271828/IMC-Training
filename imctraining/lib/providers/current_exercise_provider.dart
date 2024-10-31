//    This is source code of the IMC-Training App which is intended for IMC training.
//    Copyright (C) 2024  Tobias Schnieders
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.
//
//    You can contact the developer via imctrainingapp.g8199@slmails.com



import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CurrentExerciseProvider extends ChangeNotifier{
  int jahr = 0;
  int tag = 0;
  int aufgabe = 0;
  bool aufgabenichtleer = false;
  String linkaktuellesaufgabenbildohneendung = 'images/empty';
  List<String> imcaufgabendata = [];
  String aktuellertagstring = '';
  String tmpsubstring = '';
  bool zeigeaufgaben1 = false;
  bool zeigeaufgaben2 = false;
  bool zeigeaufgaben3 = false;
  bool zeigeaufgaben4 = false;
  bool zeigeaufgaben5 = false;
  bool zeigeaufgaben6 = false;
  int aufgaben1geloest = 0;
  int aufgaben2geloest = 0;
  int aufgaben3geloest = 0;
  int aufgaben4geloest = 0;
  int aufgaben5geloest = 0;
  int aufgaben6geloest = 0;
  int aufgaben1gesamt = 0;
  int aufgaben2gesamt = 0;
  int aufgaben3gesamt = 0;
  int aufgaben4gesamt = 0;
  int aufgaben5gesamt = 0;
  int aufgaben6gesamt = 0;
  bool zeigeaufgabennummern = true;
  bool trainierenurspeziellesthema = false;
  String trainingsthema = 'n';

  
  //Aufgabenzuordnung zu Themengebieten: TBA
  static const aufgabenthemen = [
    [ // 1994
      ['l','r','nk','l','r','r'], // Tag 1
      ['r','r','r','l','g','r'] // Tag 2
    ],
    [ // 1995
      ['l','r','r','r','l','r'], // Tag 1
      ['l','r','cp','r','r','r'] // Tag 2
    ],
    [ // 1996
      ['l','r','l','r','r','g'], // Tag 1
      ['r','nkr','a','g','r','r'] // Tag 2
    ],
    [ // 1997
      ['r','r','l','r','g','nk'], // Tag 1
      ['r','l','r','l','ka','r'] // Tag 2
    ],
    [ // 1998
      ['l','ak','arp','r','rp','r'], // Tag 1
      ['l','rp','a','k','g','r'] // Tag 2
    ],
    [ // 1999
      ['l','r','r','r','k','r'], // Tag 1
      ['a','k','r','r','a','nc'] // Tag 2
    ],
    [ // 2000
      ['r','acp','l','r','a','r'], // Tag 1
      ['g','r','cp','pg','r','l'] // Tag 2
    ],
    [ // 2001
      ['kl','a','r','np','l','r'], // Tag 1
      ['p','r','g','l','r','r'] // Tag 2
    ],
    [ // 2002
      ['g','r','k','r','r','l'], // Tag 1
      ['l','k','r','g','l','r'] // Tag 2
    ],
    [ // 2003
      ['r','na','l','n','r','cp'], // Tag 1
      ['l','r','rg','k','r','r'] // Tag 2
    ],
    [ // 2004
      ['k','p','r','g','kr','c'], // Tag 1
      ['l','r','g','l','r','l'] // Tag 2
    ],
    [ // 2005
      ['l','k','r','nkp','r','a'], // Tag 1
      ['rp','rp','l','r','r','n'] // Tag 2
    ],
    [ // 2006
      ['r','n','l','np','r','r'], // Tag 1
      ['k','r','r','g','n','l'] // Tag 2
    ],
    [ // 2007
      ['np','l','lp','a','n','cp'], // Tag 1
      ['r','n','r','l','l','rp'] // Tag 2
    ],
    [ // 2008
      ['r','lrp','n','k','a','k'], // Tag 1
      ['p','g','k','np','nl','lg'] // Tag 2
    ],
    [ // 2009
      ['r','l','k','cp','g'], // Tag 1
      ['g','r','l','n','l'] // Tag 2
    ],
    [ // 2010
      ['r','r','r','n','n'], // Tag 1
      ['r','r','a','l','r'] // Tag 2
    ],
    [ // 2011
      ['r','l','np','k','l'], // Tag 1
      ['r','k','r','np','g'] // Tag 2
    ],
    [ // 2012
      ['k','l','a','r','nap'], // Tag 1
      ['p','r','n','k','a'] // Tag 2
    ],
    [ // 2013
      ['l','r','k','r','nc'], // Tag 1
      ['c','n','g','n','k'] // Tag 2
    ],
    [ // 2014
      ['l','r','p','n','g'], // Tag 1
      ['k','l','r','g','k'] // Tag 2
    ],
    [ // 2015
      ['l','k','n','n','g'], // Tag 1
      ['r','r','k','l','np'] // Tag 2
    ],
    [ // 2016
      ['r','l','r','k','nk'], // Tag 1
      ['r','r','n','k','l'] // Tag 2
    ],
    [ // 2017
      ['l','r','n','k','p'], // Tag 1
      ['r','p','l','r','g'] // Tag 2
    ],
    [ // 2018
      ['r','a','l','r','g'], // Tag 1
      ['lg','r','k','p','n'] // Tag 2
    ],
    [ // 2019
      ['r','nkl','r','r','l'], // Tag 1
      ['r','n','k','l','g'] // Tag 2
    ],
    [ // 2020
      ['k','l','g','rp'], // Tag 1
      ['r','n','a','kr'] // Tag 2
    ],
    [ // 2021
      ['l','k','r','r'], // Tag 1
      ['l','na','c','g'] // Tag 2
    ],
    [ // 2022
      ['r','l','nk','k'], // Tag 1
      ['k','n','l','g'] // Tag 2
    ],
    [ // 2023
      ['r','l','p','n','k'], // Tag 1
      ['kl','r','k','g','n'] // Tag 2
    ],
    [ // 2024
      ['c','r','l','k','g'], // Tag 1
      ['a','l','r','k','n'] // Tag 2
    ]
  ];

  
  

  Future<void> ladeeinstellungen() async {
    final prefs = await SharedPreferences.getInstance();
    imcaufgabendata = prefs.getStringList('imcaufgabendata') ?? ['uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuu','uuuu','uuuu','uuuu','uuuu','uuuu','uuuuu','uuuuu','uuuuu','uuuuu'];
    jahr = prefs.getInt('aktuelleaufgabejahr') ?? 2024;
    tag = prefs.getInt('aktuelleaufgabetag') ?? 1;
    aufgabe = prefs.getInt('aktuelleaufgabeaufgabe') ?? 1;
    zeigeaufgaben1 = prefs.getBool('zeigeaufgaben1') ?? true;
    zeigeaufgaben2 = prefs.getBool('zeigeaufgaben2') ?? false;
    zeigeaufgaben3 = prefs.getBool('zeigeaufgaben3') ?? false;
    zeigeaufgaben4 = prefs.getBool('zeigeaufgaben4') ?? false;
    zeigeaufgaben5 = prefs.getBool('zeigeaufgaben5') ?? false;
    zeigeaufgaben6 = prefs.getBool('zeigeaufgaben6') ?? false;
    zeigeaufgabennummern = prefs.getBool('zeigeaufgabennummern') ?? true;
    trainierenurspeziellesthema = prefs.getBool('trainierenurspeziellesthema') ?? false;
    trainingsthema = prefs.getString('trainingsthema') ?? 'n';
    
    if (jahr != 0 && tag != 0 && aufgabe != 0){
      aufgabenichtleer = true;
      linkaktuellesaufgabenbildohneendung = 'images/$jahr/$tag/$aufgabe';
    }
    else{
      linkaktuellesaufgabenbildohneendung = 'images/empty';
    }
  }



  Future<void> berechnestatistiken() async{
    aufgaben1geloest = 0;
    aufgaben2geloest = 0;
    aufgaben3geloest = 0;
    aufgaben4geloest = 0;
    aufgaben5geloest = 0;
    aufgaben6geloest = 0;
    aufgaben1gesamt = 0;
    aufgaben2gesamt = 0;
    aufgaben3gesamt = 0;
    aufgaben4gesamt = 0;
    aufgaben5gesamt = 0;
    aufgaben6gesamt = 0;
    for(int i = 0; i< (imcaufgabendata.length); i++){
        if(imcaufgabendata[i].substring(0,1) == 's'){aufgaben1geloest++;}aufgaben1gesamt++;
        if(imcaufgabendata[i].substring(1,2) == 's'){aufgaben2geloest++;}aufgaben2gesamt++;
        if(imcaufgabendata[i].substring(2,3) == 's'){aufgaben3geloest++;}aufgaben3gesamt++;
        if(imcaufgabendata[i].substring(3,4) == 's'){aufgaben4geloest++;}aufgaben4gesamt++;
        if (imcaufgabendata[i].length >= 5){if(imcaufgabendata[i].substring(4,5)=='s'){aufgaben5geloest++;}aufgaben5gesamt++;}
        if (imcaufgabendata[i].length == 6){if(imcaufgabendata[i].substring(5,6)=='s'){aufgaben6geloest++;}aufgaben6gesamt++;}
      }
  }

  Future<void> wechselezeigeaufgabennummern() async{
    zeigeaufgabennummern = !zeigeaufgabennummern;
    notifyListeners();
    speichereeinstellungen();
  }

  Future<void> wechseletrainierenurspeziellesthema() async{
    trainierenurspeziellesthema = !trainierenurspeziellesthema;
    notifyListeners();
    speichereeinstellungen();
  }
  
  Future<void> wechseletrainingsthema(String thema) async{
    trainingsthema = thema;
    notifyListeners();
    speichereeinstellungen();
  }

  Future<void> aenderezeigeaufgabenbestimmertnummer(int aufgabennummer) async {
    switch (aufgabennummer) {
      case 1: zeigeaufgaben1 = !zeigeaufgaben1;
      case 2: zeigeaufgaben2 = !zeigeaufgaben2;
      case 3: zeigeaufgaben3 = !zeigeaufgaben3;
      case 4: zeigeaufgaben4 = !zeigeaufgaben4;
      case 5: zeigeaufgaben5 = !zeigeaufgaben5;
      case 6: zeigeaufgaben6 = !zeigeaufgaben6;
    }
    notifyListeners();
    speichereeinstellungen();
  }

  Future<void> speichereeinstellungen() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('aktuelleaufgabejahr', jahr);
    prefs.setInt('aktuelleaufgabetag', tag);
    prefs.setInt('aktuelleaufgabeaufgabe', aufgabe);
    prefs.setStringList('imcaufgabendata', imcaufgabendata);
    prefs.setBool('zeigeaufgaben1', zeigeaufgaben1);
    prefs.setBool('zeigeaufgaben2', zeigeaufgaben2);
    prefs.setBool('zeigeaufgaben3', zeigeaufgaben3);
    prefs.setBool('zeigeaufgaben4', zeigeaufgaben4);
    prefs.setBool('zeigeaufgaben5', zeigeaufgaben5);
    prefs.setBool('zeigeaufgaben6', zeigeaufgaben6);
    prefs.setBool('zeigeaufgabennummern', zeigeaufgabennummern);
    prefs.setBool('trainierenurspeziellesthema', trainierenurspeziellesthema);
    prefs.setString('trainingsthema', trainingsthema);
  }

  Future<void> neuezufaelligeaufgabe() async {
    int returnwert = 0;
    int anzahlungeloesteraufgaben = 0;
    if(zeigeaufgaben1 || zeigeaufgaben2 || zeigeaufgaben3 || zeigeaufgaben4 || zeigeaufgaben5 || zeigeaufgaben6){
      //neue Aufgabe
      if( ! trainierenurspeziellesthema){
        // Trainiere alle Aufgaben
        jahr = 0;
        tag = 0;
        aufgabe = 0;
        for(int i = 0; i< (imcaufgabendata.length); i++){
          if (zeigeaufgaben1 && imcaufgabendata[i].substring(0,1) == 'u'){anzahlungeloesteraufgaben++;}
          if (zeigeaufgaben2 && imcaufgabendata[i].substring(1,2) == 'u'){anzahlungeloesteraufgaben++;}
          if (zeigeaufgaben3 && imcaufgabendata[i].substring(2,3) == 'u'){anzahlungeloesteraufgaben++;}
          if (zeigeaufgaben4 && imcaufgabendata[i].substring(3,4) == 'u'){anzahlungeloesteraufgaben++;}
          if (zeigeaufgaben5 && imcaufgabendata[i].length >= 5){if(imcaufgabendata[i].substring(4,5)=='u'){anzahlungeloesteraufgaben++;}}
          if (zeigeaufgaben6 && imcaufgabendata[i].length == 6){if(imcaufgabendata[i].substring(5,6)=='u'){anzahlungeloesteraufgaben++;}}
        }
        if(anzahlungeloesteraufgaben>0){
          int randomnumber = Random().nextInt(anzahlungeloesteraufgaben);
          for(int i = 0; i< (imcaufgabendata.length); i++){
            if (zeigeaufgaben1 && imcaufgabendata[i].substring(0,1) == 'u'){if(0 == randomnumber){jahr = i ~/ 2 + 1994;tag = i%2 +1;aufgabe =1;break;}else{randomnumber--;}}
            if (zeigeaufgaben2 && imcaufgabendata[i].substring(1,2) == 'u'){if(0 == randomnumber){jahr = i ~/ 2 + 1994;tag = i%2 +1;aufgabe =2;break;}else{randomnumber--;}}
            if (zeigeaufgaben3 && imcaufgabendata[i].substring(2,3) == 'u'){if(0 == randomnumber){jahr = i ~/ 2 + 1994;tag = i%2 +1;aufgabe =3;break;}else{randomnumber--;}}
            if (zeigeaufgaben4 && imcaufgabendata[i].substring(3,4) == 'u'){if(0 == randomnumber){jahr = i ~/ 2 + 1994;tag = i%2 +1;aufgabe =4;break;}else{randomnumber--;}}
            if (zeigeaufgaben5 && imcaufgabendata[i].length >= 5){if(imcaufgabendata[i].substring(4,5)=='u'){if(0 == randomnumber){jahr = i ~/ 2 + 1994;tag = i%2 +1;aufgabe =5;break;}else{randomnumber--;}}}
            if (zeigeaufgaben6 && imcaufgabendata[i].length == 6){if(imcaufgabendata[i].substring(5,6)=='u'){if(0 == randomnumber){jahr = i ~/ 2 + 1994;tag = i%2 +1;aufgabe =6;break;}else{randomnumber--;}}}
          }
        }
        else{
          //Keine Aufgabe mehr verfügbar
          returnwert = 2;
        }
      }
      else{
        // Trainiere nur ein spezielles Thema
        jahr = 0;
        tag = 0;
        aufgabe = 0;
        for(int i = 0; i< (imcaufgabendata.length); i++){
          if (zeigeaufgaben1 && imcaufgabendata[i].substring(0,1) == 'u'){if (aufgabenthemen[ i ~/ 2 ][i%2][0].contains(trainingsthema)){anzahlungeloesteraufgaben++;}}
          if (zeigeaufgaben2 && imcaufgabendata[i].substring(1,2) == 'u'){if (aufgabenthemen[ i ~/ 2 ][i%2][1].contains(trainingsthema)){anzahlungeloesteraufgaben++;}}
          if (zeigeaufgaben3 && imcaufgabendata[i].substring(2,3) == 'u'){if (aufgabenthemen[ i ~/ 2 ][i%2][2].contains(trainingsthema)){anzahlungeloesteraufgaben++;}}
          if (zeigeaufgaben4 && imcaufgabendata[i].substring(3,4) == 'u'){if (aufgabenthemen[ i ~/ 2 ][i%2][3].contains(trainingsthema)){anzahlungeloesteraufgaben++;}}
          if (zeigeaufgaben5 && imcaufgabendata[i].length >= 5){if(imcaufgabendata[i].substring(4,5)=='u'){if (aufgabenthemen[ i ~/ 2 ][i%2][4].contains(trainingsthema)){anzahlungeloesteraufgaben++;}}}
          if (zeigeaufgaben6 && imcaufgabendata[i].length == 6){if(imcaufgabendata[i].substring(5,6)=='u'){if (aufgabenthemen[ i ~/ 2 ][i%2][5].contains(trainingsthema)){anzahlungeloesteraufgaben++;}}}
        }
        if(anzahlungeloesteraufgaben>0){
          int randomnumber = Random().nextInt(anzahlungeloesteraufgaben);
          for(int i = 0; i< (imcaufgabendata.length); i++){
            if (zeigeaufgaben1 && imcaufgabendata[i].substring(0,1) == 'u' && aufgabenthemen[ i ~/ 2 ][i%2][0].contains(trainingsthema)){if(0 == randomnumber){jahr = i ~/ 2 + 1994;tag = i%2 +1;aufgabe =1;break;}else{randomnumber--;}}
            if (zeigeaufgaben2 && imcaufgabendata[i].substring(1,2) == 'u' && aufgabenthemen[ i ~/ 2 ][i%2][1].contains(trainingsthema)){if(0 == randomnumber){jahr = i ~/ 2 + 1994;tag = i%2 +1;aufgabe =2;break;}else{randomnumber--;}}
            if (zeigeaufgaben3 && imcaufgabendata[i].substring(2,3) == 'u' && aufgabenthemen[ i ~/ 2 ][i%2][2].contains(trainingsthema)){if(0 == randomnumber){jahr = i ~/ 2 + 1994;tag = i%2 +1;aufgabe =3;break;}else{randomnumber--;}}
            if (zeigeaufgaben4 && imcaufgabendata[i].substring(3,4) == 'u' && aufgabenthemen[ i ~/ 2 ][i%2][3].contains(trainingsthema)){if(0 == randomnumber){jahr = i ~/ 2 + 1994;tag = i%2 +1;aufgabe =4;break;}else{randomnumber--;}}
            if (zeigeaufgaben5 && imcaufgabendata[i].length >= 5){if(imcaufgabendata[i].substring(4,5)=='u' && aufgabenthemen[ i ~/ 2 ][i%2][4].contains(trainingsthema)){if(0 == randomnumber){jahr = i ~/ 2 + 1994;tag = i%2 +1;aufgabe =5;break;}else{randomnumber--;}}}
            if (zeigeaufgaben6 && imcaufgabendata[i].length == 6){if(imcaufgabendata[i].substring(5,6)=='u' && aufgabenthemen[ i ~/ 2 ][i%2][5].contains(trainingsthema)){if(0 == randomnumber){jahr = i ~/ 2 + 1994;tag = i%2 +1;aufgabe =6;break;}else{randomnumber--;}}}
          }
        }
        else{
          //Keine Aufgabe mehr verfügbar
          returnwert = 2;
        }
      }
    }
    else{
      //Keine neue Aufgabe - keine Aufgabensorte ausgewählt - Returnwert = 1
      returnwert = 1;
    }
    if (returnwert == 0){
      linkaktuellesaufgabenbildohneendung = 'images/$jahr/$tag/$aufgabe';
      aufgabenichtleer = true;
    }
    else{
      linkaktuellesaufgabenbildohneendung = 'images/empty';
      aufgabenichtleer = false;
      jahr = 0;
      tag = 0;
      aufgabe = 0;
    }
    berechnestatistiken();
    notifyListeners();
    speichereeinstellungen();
  }

  Future<void> markiereaktuelleaufgabealsgeloestundneueaufgabe() async {
    if (jahr != 0 && tag != 0 && aufgabe != 0){
      aktuellertagstring = imcaufgabendata[(jahr-1994)*2+tag-1];
      if (aufgabe == 1){
        aktuellertagstring = 's${aktuellertagstring.substring(1)}';
      }
      else{
        aktuellertagstring = '${aktuellertagstring.substring(0,aufgabe-1)}s${aktuellertagstring.substring(aufgabe)}';
      }
      imcaufgabendata[(jahr-1994)*2+tag-1] = aktuellertagstring;
    }
    neuezufaelligeaufgabe();
  }

  Future<void> aenderemarkierungeineraufgabe(int jahrderaufgabe, int tagderaufgabe, int aufgabennummerderaufgabe, bool aufgabejetztgeloest) async {
    tmpsubstring = aufgabejetztgeloest ? 's' : 'u';
    aktuellertagstring = imcaufgabendata[(jahrderaufgabe-1994)*2+tagderaufgabe-1];
    if (aufgabennummerderaufgabe == 1){
      aktuellertagstring = tmpsubstring + aktuellertagstring.substring(1);
    }
    else{
      aktuellertagstring = aktuellertagstring.substring(0,aufgabennummerderaufgabe-1) + tmpsubstring + aktuellertagstring.substring(aufgabennummerderaufgabe);
    }
    imcaufgabendata[(jahrderaufgabe-1994)*2+tagderaufgabe-1] = aktuellertagstring;
    berechnestatistiken();
    notifyListeners();
    speichereeinstellungen();
  }

  Future<void> initialisieren() async{
    await ladeeinstellungen();
    berechnestatistiken();
    notifyListeners();
  }
}