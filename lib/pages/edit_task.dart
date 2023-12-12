import 'package:ajudante/database.dart';
import 'package:ajudante/models/TaskModel.dart';
import 'package:ajudante/widgets/Task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTaskForm extends StatefulWidget {
  final String taskId;
  
  const EditTaskForm({super.key, required this.taskId});

  @override
  State<EditTaskForm> createState() => _EditTaskFormState();
}

class _EditTaskFormState extends State<EditTaskForm> {
  final _formKey = GlobalKey<_EditTaskFormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  Future<void> getData(AjudanteDatabase db) async {
    List<Task> tasks = await db.tasks();
    Task task = tasks.firstWhere((element) => element.id == widget.taskId);
    titleController.text = task.title;
    descriptionController.text = task.description;
  }

  @override
  Widget build(BuildContext context) {
    AjudanteDatabase db = Provider.of<AjudanteDatabase>(context, listen: false);
    getData(db);
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == null || value == "") {
                    return ('Enter text');
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              TextFormField(
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value == "") {
                    return ('Enter text');
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              // Row(
              //   children: [
              //     hasDeadlineCheckbox,
              //     const Text('Definir prazo?'),
              //     if (hasDeadlineCheckbox.isChecked)
              //       DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now()),
              //   ],
              // ),
              Container(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.small(
                        heroTag: 'clear',
                        backgroundColor: Colors.redAccent,
                        onPressed: () => {
                              titleController.text = "",
                              descriptionController.text = "",
                            },
                        child: const Icon(Icons.clear)),
                    const SizedBox(
                      width: 4.0,
                    ),
                    FloatingActionButton.small(
                        heroTag: 'create',
                        backgroundColor: Colors.greenAccent,
                        onPressed: () => {
                              db.updateTask(
                                 widget.taskId,
                                 titleController.text,
                                 descriptionController.text 
                              ),
                              titleController.text = "",
                              descriptionController.text = "",
                              Navigator.of(context).pop(),
                            },
                        child: const Icon(Icons.edit)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}