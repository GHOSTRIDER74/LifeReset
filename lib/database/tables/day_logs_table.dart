import 'package:drift/drift.dart';
import 'tasks_table.dart';

class DayLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get taskId => integer().references(Tasks, #id)();
  TextColumn get completedDate => text()();
}