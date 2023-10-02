import 'package:ajudante/widgets/TaskList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/CreateTaskForm.dart';
import '../widgets/Task.dart';
import 'package:ajudante/pages/About.dart';

class Todo extends StatefulWidget {
  String get title => "To do";

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<TaskList>(context, listen: true).items;

    return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CreateTaskForm(),
            ),
            Expanded(
              child: SizedBox(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                      child: tasks[index],
                    );
                  }
                ),
              ),
            ),
          ],
        );
  }
}