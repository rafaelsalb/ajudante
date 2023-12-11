import 'package:ajudante/models/ContactModel.dart';
import 'package:ajudante/models/TaskModel.dart';
import 'package:ajudante/widgets/Contact.dart';
import 'package:ajudante/widgets/Task.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class AjudanteDatabase extends ChangeNotifier {
  static late Database database;

  AjudanteDatabase._create(Database db) {
    database = db;
    notifyListeners();
  }

  static Future<AjudanteDatabase> create() async {
    var db = await openDatabase(
      join(await getDatabasesPath(), 'ajudantebeta0001.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE tasks(id TEXT, title TEXT, description TEXT, creation_datetime INTEGER, done INTEGER)');
        await db.execute(
          'CREATE TABLE contacts(id TEXT, name TEXT, phone TEXT, email TEXT, address TEXT)');
      },
      version: 1,
    );
    return AjudanteDatabase._create(db);
  }

  Future<void> createTask(TaskModel task) async {
    await database.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<List<Task>> tasks() async {
    final List<Map<String, dynamic>> maps = await database.query('tasks');
    return List.generate(maps.length, (index) => Task.fromMap(maps[index]));
  }

  Future<List<Task>> doneTasks() async {
    final List<Map<String, dynamic>> maps = await database.query('tasks', where: 'done = 1');
    return List.generate(maps.length, (index) => Task.fromMap(maps[index]));
  }

  Future<List<Task>> undoneTasks() async {
    final List<Map<String, dynamic>> maps =
        await database.query('tasks', where: 'done = 0');
    return List.generate(maps.length, (index) => Task.fromMap(maps[index]));
  }

  Future<void> updateTask(String id, String title, String description) async {
    await database.execute(
      'UPDATE tasks SET title = ?, description = ? WHERE tasks.id = ?', [title, description, id]
    );
    notifyListeners();
  }

  Future<void> setTaskDone(String id) async {
    await database.execute(
      'UPDATE tasks SET done = 1 WHERE tasks.id = ?', [id]
    );
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    await database.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<void> createContact(ContactModel contact) async {
    await database.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<List<Contact>> contacts() async {
    final List<Map<String, dynamic>> maps = await database.query('contacts');
    return List.generate(maps.length, (index) => Contact.fromMap(maps[index]));
  }

  Future<void> deleteContact(String id) async {
    await database.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }
}
