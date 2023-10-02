import 'package:ajudante/widgets/Task.dart';
import 'package:ajudante/widgets/TaskList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HasDeadlineCheckbox extends StatefulWidget {
  HasDeadlineCheckboxState state = HasDeadlineCheckboxState();

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
    return Material(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value == null) {
                  return('Enter text');
                }
                return null;
              },
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextFormField(
              controller: descriptionController,
              validator: (value) {
                if (value == null) {
                  return('Enter text');
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => {
                    titleController.text = "",
                    descriptionController.text = "",
                  },
                  child: const Icon(Icons.clear)),
                ElevatedButton(
                  onPressed: () => {
                    Provider.of<TaskList>(context, listen: false).addTask(Task(title: titleController.text, description: descriptionController.text)),
                    titleController.text = "",
                    descriptionController.text = "",
                  },
                  child: const Icon(Icons.add)),
              ],
            ),
          ],
        ),
      ),
    );
  }

}