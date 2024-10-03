import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imctraining/providers/current_exercise_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Imctraining extends StatelessWidget {
  const Imctraining({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 50,
              ),
              Text((context.watch<CurrentExerciseProvider>().zeigeaufgabennummern)?((context.watch<CurrentExerciseProvider>().aufgabenichtleer)?'${context.watch<CurrentExerciseProvider>().jahr} / ${context.watch<CurrentExerciseProvider>().tag} / ${context.watch<CurrentExerciseProvider>().aufgabe}':'- / - / -'):((context.watch<CurrentExerciseProvider>().aufgabenichtleer)?'${context.watch<CurrentExerciseProvider>().jahr} / ${context.watch<CurrentExerciseProvider>().tag}':'- / -')),
              Image(image: AssetImage((Brightness.light == MediaQuery.of(context).platformBrightness)?'${context.watch<CurrentExerciseProvider>().linkaktuellesaufgabenbildohneendung}.jpg':'${context.watch<CurrentExerciseProvider>().linkaktuellesaufgabenbildohneendung}d.jpg')),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton.tonal(
                    onPressed: context.watch<CurrentExerciseProvider>().aufgabenichtleer ? (){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(AppLocalizations.of(context)!.problemmarkedassolved)));
                      context.read<CurrentExerciseProvider>().markiereaktuelleaufgabealsgeloestundneueaufgabe();
                    }:null,
                    child: const Icon(Icons.done),
                  ),
                  FilledButton.tonal(
                    onPressed: (){
                      context.read<CurrentExerciseProvider>().neuezufaelligeaufgabe();
                    },
                    child: const Icon(
                      Icons.skip_next
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
              ),
            ],
          )
          
        ],
      )
      
      
      
        /* ListView.builder(
          itemCount: 15,
          itemBuilder: (context,index) => ListTile(
            title: Text(index.toString()),
          ),
        ) *///Text("IMC-Training"),
      
    );
  }
}
