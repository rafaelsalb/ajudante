import 'package:ajudante/widgets/TaskList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/CreateTaskForm.dart';
import '../widgets/Task.dart';

class TodoPage extends StatefulWidget {
  String get title => "To do";

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<TaskList>(context, listen: true).items;

    return Scaffold(
      appBar: AppBar(title: Text("Tarefas")),
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
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return Stack(
              children: [
                CreateTaskForm(),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: FloatingActionButton(
                    backgroundColor: Colors.deepPurple,
                    onPressed: () => Navigator.of(context).pop(),
                    child: Icon(Icons.close)),
                )
              ],
            );
          },
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
