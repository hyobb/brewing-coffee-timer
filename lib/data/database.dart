import 'package:brewing_coffee_timer/data/stage.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';

part 'database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'brewing_coffee_timer.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Stage], daos: [StageDao])
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onCreate: (Migrator m) async {
        await m.createAll();
        await stageDao.insertStage(StageCompanion(
            order: Value(1), title: Value('뜸'), second: Value(60)));
        await stageDao.insertStage(StageCompanion(
            order: Value(2), title: Value('1차 추출'), second: Value(60)));
        await stageDao.insertStage(StageCompanion(
            order: Value(3), title: Value('2차 추출'), second: Value(40)));
      });
}
