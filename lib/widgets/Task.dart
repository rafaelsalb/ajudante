import 'package:ajudante/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Task extends StatelessWidget {
  late final String id;
  late final String title;
  late final String description;
  late final int creation_datetime;

  Task({super.key, required this.id, required this.title, required this.description});
  Task.fromMap(Map<String, dynamic> map, {super.key}) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    creation_datetime = map['creation_datetime'];
  }


  @override
  Widget build(BuildContext context) {
    AjudanteDatabase db = Provider.of<AjudanteDatabase>(context, listen: false);
    return Container(
      alignment: AlignmentDirectional.centerStart,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        children: [
          TaskComponent(text: title),
          TaskComponent(text: description),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () => db
                      .deleteTask(id),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade500),
                  child: const Icon(Icons.check_outlined)),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade500),
                  child: const Icon(Icons.edit)),
              ElevatedButton(
                  onPressed: () => db
                      .deleteTask(id),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade500),
                  child: const Icon(Icons.remove_circle_outline)),
            ],
          ))
        ],
      ),
    );
  }
}

class TaskComponent extends StatelessWidget {
  TaskComponent({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: BorderDirectional(
                bottom: BorderSide(
          width: 2.0,
          color: Theme.of(context).dividerColor,
        ))),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(),
            ),
          ),
        ));
  }
}
