import 'package:ajudante/database.dart';
import 'package:ajudante/widgets/task_popupmenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Task extends StatelessWidget {
  late final String id;
  late final String title;
  late final String description;
  late final int creation_datetime;
  int done = 0;

  Task({
    super.key,
    required this.id,
    required this.title,
    required this.description,
  });
  Task.fromMap(Map<String, dynamic> map, {super.key}) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    creation_datetime = map['creation_datetime'];
    done = map['done'];
  }

  @override
  Widget build(BuildContext context) {
    AjudanteDatabase db = Provider.of<AjudanteDatabase>(context, listen: false);
    return Container(
      alignment: AlignmentDirectional.centerStart,
      decoration: BoxDecoration(
        border: Border.all(
            width: 2.0,
            color: done == 1
                ? Colors.greenAccent
                : Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        children: [
          TaskTitle(id: id, text: title),
          TaskComponent(text: description),
          done == 0 ?
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () => db.setTaskDone(id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade500,
                    foregroundColor: Colors.white,
                  ),
                  child: const Icon(Icons.check_outlined)),
            ],
          ) : const SizedBox.shrink(),
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

class TaskTitle extends StatelessWidget {
  final String id;
  final String text;

  const TaskTitle({super.key, required this.id, required this.text});

  @override
  Widget build(BuildContext context) {
    print(id);
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    text,
                    style: const TextStyle(),
                  ),
                ),
                TaskPopupMenu(
                  id: id,
                )
              ],
            ),
          ),
        ));
  }
}
