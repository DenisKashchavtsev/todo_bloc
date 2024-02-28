import 'package:hive/hive.dart';

import '../models/todo.dart';

class TodoRepository {
  Future<Box<Todo>> get _database => Hive.openBox('app_db');

  Future<List<Todo>> getAllData() async {
    final database = await _database;

    return database.values.map((v) {
      return Todo(
          title: v.title,
          description: v.description,
          isDone: v.isDone,
          category: v.category);
    }).toList();
  }

  Future<Todo?> getData(int key) async {
    final database = await _database;
    return database.get(key);
  }

  Future<void> deleteData(int id) async {
    final database = await _database;
    database.delete(id);
    getAllData();
  }

  Future<void> addData(Todo model) async {
    final database = await _database;
    await database.add(model);
    getAllData();
  }

  Future<void> updateData(int key, Todo model) async {
    final database = await _database;
    database.put(key, model);
  }
}
