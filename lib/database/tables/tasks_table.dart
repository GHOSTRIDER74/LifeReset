import 'package:drift/drift.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get area => text()();
  TextColumn get frequency => text()();
  IntColumn get weekNumber => integer()();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  TextColumn get reminderTime => text().nullable()();
}