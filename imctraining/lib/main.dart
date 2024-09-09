import 'package:flutter/material.dart';
import 'package:imctraining/pages/homepage.dart';
import 'package:imctraining/providers/current_exercise_provider.dart';
import 'package:imctraining/providers/fullscreen_provider.dart';
import 'package:imctraining/theme/theme.dart';
import 'package:provider/provider.dart';


void main() {
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
        // debugShowCheckedModeBanner: false,
        home: const Homepage(),
        theme: lightMode,
        darkTheme: darkMode,
      ),
    );
  }
}