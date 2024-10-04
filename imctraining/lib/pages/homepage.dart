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
import 'package:imctraining/providers/current_exercise_provider.dart';
import 'package:imctraining/providers/fullscreen_provider.dart';
import 'package:provider/provider.dart';
import 'package:imctraining/pages/showimcproblems.dart';
import 'package:imctraining/pages/imctraining.dart';
import 'package:imctraining/pages/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentPageIndex = 0;
  bool vollbildmodus = false;
  bool eulaakzeptiert = false;

  Future<void> euladialog() async {
    final prefs = await SharedPreferences.getInstance();
    eulaakzeptiert = prefs.getBool('eula') ?? false;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!eulaakzeptiert){
        return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return PopScope(
              canPop: false,
              child: AlertDialog(
                title: const Text("Disclaimer"),
                content: const SingleChildScrollView(
                  child: Text("This app is intended for IMC training.\n\nFor more information about the IMC problems and the IMC in general, please look at the IMC website (https://www.imc-math.org.uk/).\n\nThis app is Open Source and licenced under the GPL-3.0-or-later licence. The source code can be found on GitHub (https://github.com/Tobias271828/IMC-Training/). This app is written in flutter and dart and more (the licensing and copyright notices can be found in the imctraining/licenses.json file in the GitHub repository (https://github.com/Tobias271828/IMC-Training/). Many thanks to the developers of those projects!\n\nPrivacy notice (from the 3th October 2024): I have developed the app in such a way that - as far as I know - the app does not send any user data anywhere. All your data remains on your device. This privacy notice can be changed at any time without having to inform you. Therefore, I kindly ask you to check it regularly. Changes might for example be made if new features require them. A synchronisation function for training in a team would for example require certain personal information to be sent over the internet. Since I have neither developed flutter and dart, nor kivy, python or any of the libraries or the dependencies needed for building the app, I will not take any responsibility if any personal information gets shared with anyone. For more precise information, I kindly ask you to download the source code of the app and build it by yourself and carefully read through all licence, privacy or similar related notices or agreements of all the dependencies.\n\nCopyright (C) 2024  Tobias Schnieders\n\nThis program is free software: you can redistribute it and/or modify\nit under the terms of the GNU General Public License as published by\nthe Free Software Foundation, either version 3 of the License, or\n(at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\nGNU General Public License for more details.\n\nYou should have received a copy of the GNU General Public License\nalong with this program.  If not, see <https://www.gnu.org/licenses/>.\n\nYou can contact the developer via imctrainingapp.g8199@slmails.com"),
                ),
                actions: <Widget>[
                  TextButton(onPressed: (){
                    akzeptiereeula();
                    Navigator.of(context).pop();
                  }, child: const Text("I accept"))
                ],
              ),
            );
          }
        );
      }
    });
  }


  Future<void> akzeptiereeula() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('eula', true);
  }


  @override
  void initState(){
    super.initState();
    context.read<FullscreenProvider>().initialisieren();
    context.read<CurrentExerciseProvider>().initialisieren();
    //if (!context.read<CurrentExerciseProvider>().eulaakzeptiert){
    //  euladialog();
    //}
    euladialog();
  }


  final List _pages = [
    const Imctraining(),
    const Showimcproblems(),
    const Settings(),
  ];



  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
      )
    );
    
  }
}

