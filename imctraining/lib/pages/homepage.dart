import 'package:flutter/material.dart';
import 'package:imctraining/providers/current_exercise_provider.dart';
import 'package:imctraining/providers/fullscreen_provider.dart';
import 'package:provider/provider.dart';
import 'package:imctraining/pages/showimcproblems.dart';
import 'package:imctraining/pages/imctraining.dart';
import 'package:imctraining/pages/settings.dart';



class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  bool vollbildmodus = false;


  @override
  void initState(){
    super.initState();
    context.read<CurrentExerciseProvider>().initialisieren();
    context.read<FullscreenProvider>().initialisieren();
  }

  void _navigateBottomBar(int index){
    setState(() {
       _selectedIndex = index;
    });
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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
          label: 'Einstellungen'
        ),
      ]),
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