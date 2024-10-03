import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imctraining/providers/current_exercise_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class Showimcproblems extends StatefulWidget {
  const Showimcproblems({super.key});

  @override
  State<Showimcproblems> createState() => _ShowimcproblemsState();
}

class _ShowimcproblemsState extends State<Showimcproblems> {
  int jahrauswahl = 0;
  int tagauswahl = 0;
  int aufgabenauswahl = 0;
  List aufgabenliste = [];
  bool aufgabeanngezeigt = false;
  
  void ladeneuesaufgabenbild(){
    if (aufgabenliste.contains(aufgabenauswahl) && jahrauswahl != 0 && tagauswahl != 0 && aufgabenauswahl != 0){
      if (Brightness.light == MediaQuery.of(context).platformBrightness){
        currentshownimage = AssetImage('images/$jahrauswahl/$tagauswahl/$aufgabenauswahl.jpg');
      }
      else{
        currentshownimage = AssetImage('images/$jahrauswahl/$tagauswahl/$aufgabenauswahl' 'd.jpg');
      }
      aufgabeanngezeigt = true;
    }
    else{
      if (Brightness.light == MediaQuery.of(context).platformBrightness){
        currentshownimage = const AssetImage('images/empty.jpg');
      }
      else{
        currentshownimage = const AssetImage('images/emptyd.jpg');
      }
      aufgabeanngezeigt = false;
    }
  }

  var currentshownimage = const AssetImage('images/empty.jpg');
  

  @override
  Widget build(BuildContext context) {
    ladeneuesaufgabenbild();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownMenu(
                width: 110,
                menuHeight: 2*(MediaQuery.of(context).size.height / 3),
                helperText: AppLocalizations.of(context)!.year,
                onSelected: (jahrauswahlselected){
                  if (jahrauswahlselected != null){
                    setState(() {
                      jahrauswahl = jahrauswahlselected;
                      if (jahrauswahl <= 2008){
                        aufgabenliste = [1,2,3,4,5,6];
                      }
                      else if (2020 <= jahrauswahl && jahrauswahl <= 2022){
                        aufgabenliste = [1,2,3,4];
                      }
                      else{
                        aufgabenliste = [1,2,3,4,5];
                      }
                    }
                    );
                  }
                },
                dropdownMenuEntries: const <DropdownMenuEntry>[
                  DropdownMenuEntry(value: 1994, label: '1994'),
                  DropdownMenuEntry(value: 1995, label: '1995'),
                  DropdownMenuEntry(value: 1996, label: '1996'),
                  DropdownMenuEntry(value: 1997, label: '1997'),
                  DropdownMenuEntry(value: 1998, label: '1998'),
                  DropdownMenuEntry(value: 1999, label: '1999'),
                  DropdownMenuEntry(value: 2000, label: '2000'),
                  DropdownMenuEntry(value: 2001, label: '2001'),
                  DropdownMenuEntry(value: 2002, label: '2002'),
                  DropdownMenuEntry(value: 2003, label: '2003'),
                  DropdownMenuEntry(value: 2004, label: '2004'),
                  DropdownMenuEntry(value: 2005, label: '2005'),
                  DropdownMenuEntry(value: 2006, label: '2006'),
                  DropdownMenuEntry(value: 2007, label: '2007'),
                  DropdownMenuEntry(value: 2008, label: '2008'),
                  DropdownMenuEntry(value: 2009, label: '2009'),
                  DropdownMenuEntry(value: 2010, label: '2010'),
                  DropdownMenuEntry(value: 2011, label: '2011'),
                  DropdownMenuEntry(value: 2012, label: '2012'),
                  DropdownMenuEntry(value: 2013, label: '2013'),
                  DropdownMenuEntry(value: 2014, label: '2014'),
                  DropdownMenuEntry(value: 2015, label: '2015'),
                  DropdownMenuEntry(value: 2016, label: '2016'),
                  DropdownMenuEntry(value: 2017, label: '2017'),
                  DropdownMenuEntry(value: 2018, label: '2018'),
                  DropdownMenuEntry(value: 2019, label: '2019'),
                  DropdownMenuEntry(value: 2020, label: '2020'),
                  DropdownMenuEntry(value: 2021, label: '2021'),
                  DropdownMenuEntry(value: 2022, label: '2022'),
                  DropdownMenuEntry(value: 2023, label: '2023'),
                  DropdownMenuEntry(value: 2024, label: '2024'),
                ],
              ),
              DropdownMenu(
                helperText: AppLocalizations.of(context)!.day,
                width: 80,
                onSelected: (tagauswahlselected){
                  if(tagauswahlselected != null){
                    setState(() {
                      tagauswahl = tagauswahlselected;
                    });
                  }
                },
                dropdownMenuEntries: const <DropdownMenuEntry>[
                  DropdownMenuEntry(value: 1, label: '1'),
                  DropdownMenuEntry(value: 2, label: '2'),
                ],
              ),
              DropdownMenu(
                helperText: AppLocalizations.of(context)!.problem,
                width: 80,
                onSelected: (aufgabenauswahlselected){
                  if(aufgabenauswahlselected != null){
                    setState(() {
                      aufgabenauswahl = aufgabenauswahlselected;
                    });
                  }
                },
                dropdownMenuEntries: aufgabenliste.map((e)=>DropdownMenuEntry(value: e, label: e.toString()),).toList(),
              )
            ],
          ),),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.topCenter,
              child: Image(image: currentshownimage),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.problemsolved),
                Switch(
                  value: aufgabeanngezeigt ? 's' == context.watch<CurrentExerciseProvider>().imcaufgabendata[(jahrauswahl-1994)*2+tagauswahl-1].substring(aufgabenauswahl-1,aufgabenauswahl) : false,
                  onChanged: aufgabeanngezeigt ? (bool value){
                    context.read<CurrentExerciseProvider>().aenderemarkierungeineraufgabe(jahrauswahl,tagauswahl,aufgabenauswahl,value);
                  } : null,
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

