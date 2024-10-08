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

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.green,),//ColorScheme.light(),
  scaffoldBackgroundColor: Colors.white,
  //bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedItemColor: Colors.green,),
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.red,brightness: Brightness.dark),//ColorScheme.dark(),
  scaffoldBackgroundColor: Colors.black,
  //bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedItemColor: Colors.red,),
);

