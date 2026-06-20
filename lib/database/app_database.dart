import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/player_table.dart';
import 'tables/tasks_table.dart';
import 'tables/day_logs_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Players, Tasks, DayLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    return driftDatabase(name: 'life_reset');
  });
}
