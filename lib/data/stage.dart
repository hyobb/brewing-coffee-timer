import 'database.dart';
import 'package:drift/drift.dart';

part 'stage.g.dart';

class Stage extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get order => integer()();
  TextColumn get title => text().withLength(min: 1, max: 20)();
  IntColumn get second => integer()();
}

@DriftAccessor(tables: [Stage])
class StageDao extends DatabaseAccessor<AppDatabase> with _$StageDaoMixin {
  StageDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  Stream<List<StageData>> streamStages() => select(stage).watch();

  Stream<StageData> streamStage(int id) =>
      (select(stage)..where((table) => table.id.equals(id))).watchSingle();

  Future insertStage(StageCompanion data) => into(stage).insert(data);

  Future<List<StageData>> getAll() {
    return select(stage).get();
  }
}
