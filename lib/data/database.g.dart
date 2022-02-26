// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class StageData extends DataClass implements Insertable<StageData> {
  final int id;
  final int order;
  final String title;
  final int second;
  StageData(
      {required this.id,
      required this.order,
      required this.title,
      required this.second});
  factory StageData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return StageData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      order: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      second: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}second'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order'] = Variable<int>(order);
    map['title'] = Variable<String>(title);
    map['second'] = Variable<int>(second);
    return map;
  }

  StageCompanion toCompanion(bool nullToAbsent) {
    return StageCompanion(
      id: Value(id),
      order: Value(order),
      title: Value(title),
      second: Value(second),
    );
  }

  factory StageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StageData(
      id: serializer.fromJson<int>(json['id']),
      order: serializer.fromJson<int>(json['order']),
      title: serializer.fromJson<String>(json['title']),
      second: serializer.fromJson<int>(json['second']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'order': serializer.toJson<int>(order),
      'title': serializer.toJson<String>(title),
      'second': serializer.toJson<int>(second),
    };
  }

  StageData copyWith({int? id, int? order, String? title, int? second}) =>
      StageData(
        id: id ?? this.id,
        order: order ?? this.order,
        title: title ?? this.title,
        second: second ?? this.second,
      );
  @override
  String toString() {
    return (StringBuffer('StageData(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('title: $title, ')
          ..write('second: $second')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, order, title, second);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StageData &&
          other.id == this.id &&
          other.order == this.order &&
          other.title == this.title &&
          other.second == this.second);
}

class StageCompanion extends UpdateCompanion<StageData> {
  final Value<int> id;
  final Value<int> order;
  final Value<String> title;
  final Value<int> second;
  const StageCompanion({
    this.id = const Value.absent(),
    this.order = const Value.absent(),
    this.title = const Value.absent(),
    this.second = const Value.absent(),
  });
  StageCompanion.insert({
    this.id = const Value.absent(),
    required int order,
    required String title,
    required int second,
  })  : order = Value(order),
        title = Value(title),
        second = Value(second);
  static Insertable<StageData> custom({
    Expression<int>? id,
    Expression<int>? order,
    Expression<String>? title,
    Expression<int>? second,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (order != null) 'order': order,
      if (title != null) 'title': title,
      if (second != null) 'second': second,
    });
  }

  StageCompanion copyWith(
      {Value<int>? id,
      Value<int>? order,
      Value<String>? title,
      Value<int>? second}) {
    return StageCompanion(
      id: id ?? this.id,
      order: order ?? this.order,
      title: title ?? this.title,
      second: second ?? this.second,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (second.present) {
      map['second'] = Variable<int>(second.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StageCompanion(')
          ..write('id: $id, ')
          ..write('order: $order, ')
          ..write('title: $title, ')
          ..write('second: $second')
          ..write(')'))
        .toString();
  }
}

class $StageTable extends Stage with TableInfo<$StageTable, StageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StageTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int?> order = GeneratedColumn<int?>(
      'order', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _secondMeta = const VerificationMeta('second');
  @override
  late final GeneratedColumn<int?> second = GeneratedColumn<int?>(
      'second', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, order, title, second];
  @override
  String get aliasedName => _alias ?? 'stage';
  @override
  String get actualTableName => 'stage';
  @override
  VerificationContext validateIntegrity(Insertable<StageData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('second')) {
      context.handle(_secondMeta,
          second.isAcceptableOrUnknown(data['second']!, _secondMeta));
    } else if (isInserting) {
      context.missing(_secondMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return StageData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $StageTable createAlias(String alias) {
    return $StageTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $StageTable stage = $StageTable(this);
  late final StageDao stageDao = StageDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [stage];
}
