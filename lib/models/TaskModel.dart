// ignore_for_file: non_constant_identifier_names

import 'package:ajudante/widgets/Task.dart';
import 'package:uuid/uuid.dart';

class TaskModel {
  late String id = const Uuid().v1();
  late String title;
  late String description;
  late int creation_datetime = DateTime.now().millisecondsSinceEpoch;
  late int? due_datetime;
  late int done = 0;

  TaskModel(
      {required this.title,
      required this.description,
      this.due_datetime});

  TaskModel.fromTask(Task task) {
    title = task.title;
    description = task.description;
    creation_datetime = task.creation_datetime;
    due_datetime = null;
    done = task.done;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creation_datetime': creation_datetime,
      // 'due_datetime': due_datetime,
      'done': done,
    };
  }

  @override
  String toString() {
    return "Task{id: $id, title: $title, description: $description, creation_datetime: $creation_datetime, due_datetime: $due_datetime}";
  }
}
