import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ajudante/widgets/TaskList.dart';
import 'package:ajudante/pages/Todo.dart';
import 'package:ajudante/pages/About.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskList(),
      child: const MainApp()
    )
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentPageIndex = 0;
  final List<Widget> pages = <Widget>[
    Todo(),
    About(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(colorScheme: ColorScheme.dark()),
      home: Scaffold(
        appBar: AppBar(title: Text("Ajudante")),
        body: pages[currentPageIndex],
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(Icons.add_task_outlined),
              icon: Icon(Icons.add_task),
              label: 'Todo'
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.info_outlined),
              icon: Icon(Icons.info),
              label: 'Sobre'
            ),
          ],
        ),
      )
    );
  }
}