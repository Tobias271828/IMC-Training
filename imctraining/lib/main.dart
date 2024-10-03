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
        ],//Nach jedem Veraendern oder Hinzufuegen von Uebersetzungen und nach jedem Hinzufuegen einer neuen Sprache den Befehl flutter pub get ausfuehren
        // debugShowCheckedModeBanner: false,
        home: const Homepage(),
        theme: lightMode,
        darkTheme: darkMode,
      ),
    );
  }
}