import 'package:ajudante/models/TaskModel.dart';
import 'package:ajudante/widgets/Task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';

class AjudanteDatabase {
  late Database database;
  late List<Task> _tasks;

  List<Task> get tasks => _tasks;

  AjudanteDatabase() {
    database = start() as Database;
    _tasks = <Task>[];
  }

  Future<Database> start() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT, creation_date INTEGER, due_date INTEGER)');
      },
      version: 1,
    );
  }

  Future<void> createTask(TaskModel task) async {
    await database.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> getTasks() async {
    final List<Map<String, dynamic>> maps = await database.query('tasks');
    return List.generate(maps.length, (index) => Task.fromMap(maps[index]));
  }

  void updateTasks() async {
    final List<Map<String, dynamic>> maps = await database.query('tasks');
    _tasks = List.generate(maps.length, (index) => Task.fromMap(maps[index]));
  }
}
