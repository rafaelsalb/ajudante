import 'package:ajudante/database.dart';
import 'package:ajudante/pages/edit_task.dart';
import 'package:ajudante/widgets/Task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum TaskPopupMenuOptions { edit, remove }

class TaskPopupMenu extends StatefulWidget {
  final String id;
  const TaskPopupMenu({super.key, required this.id});

  @override
  State<TaskPopupMenu> createState() => _TaskPopupMenuState();
}

class _TaskPopupMenuState extends State<TaskPopupMenu> {
  TaskPopupMenuOptions? selected;

  void openEdit(String id, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTaskForm(taskId: id)),
    );
  } 

  @override
  Widget build(BuildContext context) {
    AjudanteDatabase db = Provider.of<AjudanteDatabase>(context, listen: false);
    return PopupMenuButton<TaskPopupMenuOptions>(
      initialValue: null,
      onSelected: (TaskPopupMenuOptions option) {
        setState(() {
          selected = option;
          print(widget.id);
          print(selected);
          switch (selected) {
            case TaskPopupMenuOptions.edit:
              openEdit(widget.id, context);
            case TaskPopupMenuOptions.remove:
              db.deleteTask(widget.id);
            default:
              return;
          }
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<TaskPopupMenuOptions>>[
        const PopupMenuItem<TaskPopupMenuOptions>(
          value: TaskPopupMenuOptions.edit,
          child: Text("Editar"),
        ),
        const PopupMenuItem<TaskPopupMenuOptions>(
          value: TaskPopupMenuOptions.remove,
          child: Text("Remover"),
        ),
      ],
    );
  }
}
