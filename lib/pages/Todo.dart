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

  Future<void> updateTasks() async {
    var _tasks = await Provider.of<AjudanteDatabase>(context, listen: false).tasks();
    setState(() {
      tasks = _tasks;
      print('atualizando...');
      print(tasks);
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
    _context = context.read<AjudanteDatabase>();
    _context.addListener(updateTasks);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tarefas")),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                    child: tasks[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateTaskForm()),
          ).then((_) {
            print('a');
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
