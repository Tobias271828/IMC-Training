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
                      //BEGIN DELETE
                      /*showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("hi"),
                          content: Text("Moin"),
                          actions: <Widget>[
                            TextButton(onPressed: () => Navigator.pop(context,"Nein"), child: Text("Nein")),
                            TextButton(onPressed: () => Navigator.pop(context,"Ja"), child: Text("Ja")),
                          ],
                        ),
                      );*/
                      //END DELETE
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
