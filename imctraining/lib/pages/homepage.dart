import 'package:flutter/material.dart';
import 'package:imctraining/providers/current_exercise_provider.dart';
import 'package:imctraining/providers/fullscreen_provider.dart';
import 'package:provider/provider.dart';
import 'package:imctraining/pages/showimcproblems.dart';
import 'package:imctraining/pages/imctraining.dart';
import 'package:imctraining/pages/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentPageIndex = 0;
  bool vollbildmodus = false;


  @override
  void initState(){
    super.initState();
    context.read<CurrentExerciseProvider>().initialisieren();
    context.read<FullscreenProvider>().initialisieren();
  }


  final List _pages = [
    const Imctraining(),
    const Showimcproblems(),
    const Settings(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Homepage"),),*/
      body: _pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            currentPageIndex = index;
          });
        },
        //indicatorColor: Colors.amber(),
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: const Icon(Icons.trending_up),
            icon: const Icon(Icons.trending_up_outlined),
            label: AppLocalizations.of(context)!.imctraining,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.local_library),
            icon: const Icon(Icons.local_library_outlined),
            label: AppLocalizations.of(context)!.imcproblems,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.settings),
            icon: const Icon(Icons.settings_outlined),
            label: AppLocalizations.of(context)!.settings,//'Einstellungen',
          ),
        ],
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        items: const [
        //Training
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          label: 'IMC-Training'
        ),
        //Zeigen
        BottomNavigationBarItem(
          icon: Icon(Icons.local_library),
          label: 'IMC-Probleme'
        ),
        //Einstellungen
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: AppLocalizations.of(context)!.fullscreen,//'Einstellungen',
        ),
      ]),*/
    );
  }
}


/*Center(
        child: ElevatedButton(onPressed:(){
          Navigator.push(
            context, MaterialPageRoute(builder: (context)=>Showimcproblems())
          );
        }, child: Text("go to second page"))
      )*/