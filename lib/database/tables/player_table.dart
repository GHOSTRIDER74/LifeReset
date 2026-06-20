import 'package:drift/drift.dart';

class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  TextColumn get rank => text().withDefault(const Constant('E'))();
  IntColumn get streakDays => integer().withDefault(const Constant(0))();
  TextColumn get lastCompletedDate => text().nullable()();
  TextColumn get programStartDate => text()();
}