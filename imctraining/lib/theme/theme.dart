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

