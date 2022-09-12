import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_desktop/model/todo.dart';

import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(tables: [Todo])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// GET TODO LIST
  Future<List<TodoData>> getAllTodo() async {
    return await todo.select().get();
  }

  /// ADD TODO
  Future<int> insertTodo(TodoCompanion todoCompanion) async {
    return await todo.insertOne(todoCompanion);
  }

  /// UPDATE TODO
  Future<void> updateTodo(TodoCompanion todoCompanion) async {
    return await todo.replaceOne(todoCompanion);
  }

  /// DELETE TODO
  Future<bool> deleteTodo(TodoData todoData) async {
    return await todo.deleteOne(todoData);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
