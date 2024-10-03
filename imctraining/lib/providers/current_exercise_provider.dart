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
  //bool eulaakzeptiert = false;
  
  

  Future<void> ladeeinstellungen() async {
    final prefs = await SharedPreferences.getInstance();
    imcaufgabendata = prefs.getStringList('imcaufgabendata') ?? ['uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuuu','uuuu','uuuu','uuuu','uuuu','uuuu','uuuu','uuuuu','uuuuu','uuuuu','uuuuu'];
    jahr = prefs.getInt('aktuelleaufgabejahr') ?? 0;
    tag = prefs.getInt('aktuelleaufgabetag') ?? 0;
    aufgabe = prefs.getInt('aktuelleaufgabeaufgabe') ?? 0;
    zeigeaufgaben1 = prefs.getBool('zeigeaufgaben1') ?? true;
    zeigeaufgaben2 = prefs.getBool('zeigeaufgaben2') ?? false;
    zeigeaufgaben3 = prefs.getBool('zeigeaufgaben3') ?? false;
    zeigeaufgaben4 = prefs.getBool('zeigeaufgaben4') ?? false;
    zeigeaufgaben5 = prefs.getBool('zeigeaufgaben5') ?? false;
    zeigeaufgaben6 = prefs.getBool('zeigeaufgaben6') ?? false;
    zeigeaufgabennummern = prefs.getBool('zeigeaufgabennummern') ?? true;
    

    if (jahr != 0 && tag != 0 && aufgabe != 0){
      aufgabenichtleer = true;
      linkaktuellesaufgabenbildohneendung = 'images/$jahr/$tag/$aufgabe';
    }
    else{
      linkaktuellesaufgabenbildohneendung = 'images/empty';
    }
  }

  /*Future<void> ladeeulaakzeptiert() async {
    final prefs = await SharedPreferences.getInstance();
    eulaakzeptiert = prefs.getBool('eula') ?? false;
  }

  Future<void> akzeptiereeula() async {
    final prefs = await SharedPreferences.getInstance();
    eulaakzeptiert = true;
    prefs.setBool('eula', eulaakzeptiert);
  }*/


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
  }

  Future<void> neuezufaelligeaufgabe() async {
    int returnwert = 0;
    int anzahlungeloesteraufgaben = 0;
    if(zeigeaufgaben1 || zeigeaufgaben2 || zeigeaufgaben3 || zeigeaufgaben4 || zeigeaufgaben5 || zeigeaufgaben6){
      //neue Aufgabe
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
    //await ladeeulaakzeptiert();
  }
}