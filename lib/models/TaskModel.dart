import 'package:ajudante/widgets/Task.dart';

class TaskModel {
  late int id;
  late String title;
  late String description;
  late int creation_datetime;
  late int? due_datetime;

  TaskModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.creation_datetime,
      this.due_datetime});

  TaskModel.fromTask(Task task) {
    id = task.id;
    title = task.title;
    description = task.description;
    creation_datetime = task.creation_datetime;
    due_datetime = due_datetime;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creation_datetime': creation_datetime,
      'due_datetime': due_datetime,
    };
  }

  @override
  String toString() {
    return "Task{id: $id, title: $title, description: $description, creation_datetime: $creation_datetime, due_datetime: $due_datetime}";
  }
}
