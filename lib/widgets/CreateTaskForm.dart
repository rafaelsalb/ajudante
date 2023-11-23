import 'package:ajudante/database.dart';
import 'package:ajudante/models/TaskModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HasDeadlineCheckbox extends StatefulWidget {
  final HasDeadlineCheckboxState state = HasDeadlineCheckboxState();

  HasDeadlineCheckbox({super.key});
  bool get isChecked => state.isChecked;

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class HasDeadlineCheckboxState extends State<HasDeadlineCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (bool? value) => {
        setState(() {
          isChecked = value!;
        }),
      },
    );
  }
}

class CreateTaskForm extends StatefulWidget {
  const CreateTaskForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return CreateTaskFormState();
  }
}

class CreateTaskFormState extends State<CreateTaskForm> {
  final _formKey = GlobalKey<CreateTaskFormState>();
  bool hasDeadline = false;
  late HasDeadlineCheckbox hasDeadlineCheckbox;

  CreateTaskFormState() {
    hasDeadlineCheckbox = HasDeadlineCheckbox();
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AjudanteDatabase db = Provider.of<AjudanteDatabase>(context, listen: false);
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
                                  db.createTask(
                                    TaskModel(
                                      title: titleController.text,
                                      description: descriptionController.text,
                                    ),
                                  ),
                                  titleController.text = "",
                                  descriptionController.text = "",
                                  Navigator.of(context).pop(),
                            },
                        child: const Icon(Icons.add)),
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
