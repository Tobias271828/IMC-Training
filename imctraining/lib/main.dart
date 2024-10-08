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
import 'package:imctraining/pages/homepage.dart';
import 'package:imctraining/providers/current_exercise_provider.dart';
import 'package:imctraining/providers/fullscreen_provider.dart';
import 'package:imctraining/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart'; //Fuer Portrait-Modus
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized(); //neu
  SystemChrome.setPreferredOrientations([ //neu
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);//.then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FullscreenProvider(),),
        ChangeNotifierProvider(create: (context) => CurrentExerciseProvider(),),
      ],
      child: MaterialApp(
        /*localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],*/
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const [
          Locale('en'),
          Locale('de'),
          Locale('nl'),
          Locale('sv'),
          Locale('es'),
          Locale('ru'),
        ],//Nach jedem Veraendern oder Hinzufuegen von Uebersetzungen und nach jedem Hinzufuegen einer neuen Sprache den Befehl flutter gen-l10n und danach flutter pub get ausfuehren
        // debugShowCheckedModeBanner: false,
        home: const Homepage(),
        theme: lightMode,
        darkTheme: darkMode,
      ),
    );
  }
}