import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FullscreenProvider extends ChangeNotifier{
  bool fullscreenturnedon = false;

  void applyfullscreen() async {
    if (fullscreenturnedon){
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [],);
    }
    else{
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values,);
    }
  }

  Future<void> ladeeinstellungen() async {
    final prefs = await SharedPreferences.getInstance();
    fullscreenturnedon = prefs.getBool('vollbildmodus') ?? false;
  }
  
  Future<void> wechselevollbildmodus() async {
    fullscreenturnedon = !fullscreenturnedon;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('vollbildmodus', fullscreenturnedon);
    applyfullscreen();
  }
  
  Future<void> initialisieren() async {
    await ladeeinstellungen();
    applyfullscreen();
  }
}