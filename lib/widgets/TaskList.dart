import 'package:ajudante/widgets/Task.dart';
import 'package:flutter/material.dart';

class TaskList extends ChangeNotifier {
  final List<Task> _items = <Task>[];

  List<Task> get items => _items;

  void addTask(Task task) {
    _items.add(task);
    for (var task in _items) {
      print(task.title);
    }
    notifyListeners();
  }

  void removeFromID(int id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
