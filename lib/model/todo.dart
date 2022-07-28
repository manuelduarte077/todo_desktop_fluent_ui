import 'package:drift/drift.dart';

class Todo extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  BoolColumn get isFinished => boolean()();
}
