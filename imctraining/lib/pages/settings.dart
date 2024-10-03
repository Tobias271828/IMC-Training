import 'package:flutter/material.dart';
import 'package:imctraining/providers/current_exercise_provider.dart';
import 'package:imctraining/providers/fullscreen_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(50),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.fullscreen),//const Text("Vollbild"),
              Switch(
                value: context.watch<FullscreenProvider>().fullscreenturnedon,
                onChanged:  (bool value){
                  context.read<FullscreenProvider>().wechselevollbildmodus();
                }, 
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.showproblemnumbers),
              Switch(
                value: context.watch<CurrentExerciseProvider>().zeigeaufgabennummern,
                onChanged: (bool value){context.read<CurrentExerciseProvider>().wechselezeigeaufgabennummern();}
              )
            ],
          ),
          Container(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${AppLocalizations.of(context)!.showproblems} 1 (${(100*context.watch<CurrentExerciseProvider>().aufgaben1geloest / context.watch<CurrentExerciseProvider>().aufgaben1gesamt).round()}% ${AppLocalizations.of(context)!.solved})"),
              Checkbox(value: context.watch<CurrentExerciseProvider>().zeigeaufgaben1, onChanged: (value){context.read<CurrentExerciseProvider>().aenderezeigeaufgabenbestimmertnummer(1);},)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${AppLocalizations.of(context)!.showproblems} 2 (${(100*context.watch<CurrentExerciseProvider>().aufgaben2geloest / context.watch<CurrentExerciseProvider>().aufgaben2gesamt).round()}% ${AppLocalizations.of(context)!.solved})"),
              Checkbox(value: context.watch<CurrentExerciseProvider>().zeigeaufgaben2, onChanged: (value){context.read<CurrentExerciseProvider>().aenderezeigeaufgabenbestimmertnummer(2);},)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${AppLocalizations.of(context)!.showproblems} 3 (${(100*context.watch<CurrentExerciseProvider>().aufgaben3geloest / context.watch<CurrentExerciseProvider>().aufgaben3gesamt).round()}% ${AppLocalizations.of(context)!.solved})"),
              Checkbox(value: context.watch<CurrentExerciseProvider>().zeigeaufgaben3, onChanged: (value){context.read<CurrentExerciseProvider>().aenderezeigeaufgabenbestimmertnummer(3);},)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${AppLocalizations.of(context)!.showproblems} 4 (${(100*context.watch<CurrentExerciseProvider>().aufgaben4geloest / context.watch<CurrentExerciseProvider>().aufgaben4gesamt).round()}% ${AppLocalizations.of(context)!.solved})"),
              Checkbox(value: context.watch<CurrentExerciseProvider>().zeigeaufgaben4, onChanged: (value){context.read<CurrentExerciseProvider>().aenderezeigeaufgabenbestimmertnummer(4);},)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${AppLocalizations.of(context)!.showproblems} 5 (${(100*context.watch<CurrentExerciseProvider>().aufgaben5geloest / context.watch<CurrentExerciseProvider>().aufgaben5gesamt).round()}% ${AppLocalizations.of(context)!.solved})"),
              Checkbox(value: context.watch<CurrentExerciseProvider>().zeigeaufgaben5, onChanged: (value){context.read<CurrentExerciseProvider>().aenderezeigeaufgabenbestimmertnummer(5);},)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${AppLocalizations.of(context)!.showproblems} 6 (${(100*context.watch<CurrentExerciseProvider>().aufgaben6geloest / context.watch<CurrentExerciseProvider>().aufgaben6gesamt).round()}% ${AppLocalizations.of(context)!.solved})"),
              Checkbox(value: context.watch<CurrentExerciseProvider>().zeigeaufgaben6, onChanged: (value){context.read<CurrentExerciseProvider>().aenderezeigeaufgabenbestimmertnummer(6);},)
            ],
          ),
        ],
      )
    );
  }
}
