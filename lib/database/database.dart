import 'package:drift/drift.dart';
import 'package:todo_desktop/model/todo.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Todo,
])
class AppDatabase {}
