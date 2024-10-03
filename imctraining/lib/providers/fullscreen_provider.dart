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