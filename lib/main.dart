import 'package:ajudante/widgets/ContactList.dart';
import 'package:ajudante/widgets/color_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ajudante/widgets/TaskList.dart';
import 'package:ajudante/pages/About.dart';
import 'package:ajudante/pages/Contacts.dart';
import 'package:ajudante/pages/Todo.dart';
import 'package:ajudante/database.dart';

void main() {
  AjudanteDatabase db = AjudanteDatabase();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<TaskList>(
      create: (context) => TaskList(),
    ),
    ChangeNotifierProvider<ContactList>(
      create: (context) => ContactList(),
    ),
    ChangeNotifierProvider<ColorMode>(
      create: (context) => ColorMode(),
    ),
  ], child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentPageIndex = 0;
  final List<Widget> pages = <Widget>[
    const TodoPage(),
    const ContactsPage(),
    const About(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.from(
            colorScheme:
                Provider.of<ColorMode>(context, listen: true).colorScheme),
        home: Scaffold(
          body: pages[currentPageIndex],
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations: const [
              NavigationDestination(
                  selectedIcon: Icon(Icons.add_task_outlined),
                  icon: Icon(Icons.add_task),
                  label: 'Tarefas'),
              NavigationDestination(
                  selectedIcon: Icon(Icons.contacts_outlined),
                  icon: Icon(Icons.contacts),
                  label: 'Contatos'),
              NavigationDestination(
                  selectedIcon: Icon(Icons.info_outlined),
                  icon: Icon(Icons.info),
                  label: 'Sobre'),
            ],
          ),
        ));
  }
}
