import 'package:ajudante/widgets/TodoFilter.dart';
import 'package:ajudante/widgets/color_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/CreateTaskForm.dart';
import '../widgets/Task.dart';
import 'package:ajudante/database.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  String get title => "To do";

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Task> tasks = <Task>[];
  var _context;
  List<Widget> views = <Widget>[
    DoneTasks(tasks: []),
    UndoneTasks(tasks: []),
  ];
  late bool only_done;

  Future<void> updateTasks() async {
    List<Task> done =
        await Provider.of<AjudanteDatabase>(context, listen: false).doneTasks();
    List<Task> undone =
        await Provider.of<AjudanteDatabase>(context, listen: false)
            .undoneTasks();
    setState(() {
      views[0] = DoneTasks(
        tasks: done,
      );
      views[1] = DoneTasks(
        tasks: undone,
      );
    });
  }

  @override
  void dispose() {
    _context.removeListener(updateTasks);
    super.dispose();
  }

  @override
  void initState() {
    updateTasks();
    only_done = Provider.of<TodoFilter>(context, listen: false).only_done;
    _context = context.read<AjudanteDatabase>();
    _context.addListener(updateTasks);
    super.initState();
  }

  void switchOnlyDone() {
    setState(() {
      Provider.of<TodoFilter>(context, listen: false).switch_filter();
      only_done = Provider.of<TodoFilter>(context, listen: false).only_done;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ColorMode>(context, listen: false).colorScheme ==
            ColorScheme.dark();
    print(only_done);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefas"),
        actions: [
          ActionChip(
            label: Icon(Icons.done_all),
            color: MaterialStatePropertyAll(
              only_done
                  ? isDarkMode
                      ? Colors.black
                      : Colors.white
                  : isDarkMode
                      ? Colors.grey.shade800
                      : Colors.grey.shade300,
            ),
            onPressed: switchOnlyDone,
          ),
        ],
      ),
      body: views[only_done ? 1 : 0],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateTaskForm()),
          ).then((_) {
            updateTasks();
          });
        },
        // )
        // },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DoneTasks extends StatefulWidget {
  List<Task> tasks;
  DoneTasks({super.key, required this.tasks});

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  // Future<void> getTasks() async {
  //   List<Task> _tasks =
  //       await Provider.of<AjudanteDatabase>(context, listen: false).doneTasks();
  //   setState(() {
  //     widget.tasks = _tasks;
  //   });
  // }

  @override
  void initState() {
    // getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            child: ListView.builder(
              itemCount: widget.tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                  child: widget.tasks[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class UndoneTasks extends StatefulWidget {
  List<Task> tasks;
  UndoneTasks({super.key, required this.tasks});

  @override
  State<UndoneTasks> createState() => _UndoneTasksState();
}

class _UndoneTasksState extends State<UndoneTasks> {
  // List<Task> tasks = <Task>[];

  // Future<void> getTasks() async {
  //   List<Task> _tasks =
  //       await Provider.of<AjudanteDatabase>(context, listen: false)
  //           .undoneTasks();
  //   setState(() {
  //     tasks = _tasks;
  //   });
  // }

  @override
  void initState() {
    // getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            child: ListView.builder(
              itemCount: widget.tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                  child: widget.tasks[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
