// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ScansTable extends Scans with TableInfo<$ScansTable, Scan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _scanTypeMeta = const VerificationMeta(
    'scanType',
  );
  @override
  late final GeneratedColumn<String> scanType = GeneratedColumn<String>(
    'scan_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasThreatsMeta = const VerificationMeta(
    'hasThreats',
  );
  @override
  late final GeneratedColumn<bool> hasThreats = GeneratedColumn<bool>(
    'has_threats',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_threats" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    scanType,
    timestamp,
    hasThreats,
    details,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scans';
  @override
  VerificationContext validateIntegrity(
    Insertable<Scan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('scan_type')) {
      context.handle(
        _scanTypeMeta,
        scanType.isAcceptableOrUnknown(data['scan_type']!, _scanTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_scanTypeMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('has_threats')) {
      context.handle(
        _hasThreatsMeta,
        hasThreats.isAcceptableOrUnknown(data['has_threats']!, _hasThreatsMeta),
      );
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Scan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Scan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      scanType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scan_type'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      hasThreats: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_threats'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      ),
    );
  }

  @override
  $ScansTable createAlias(String alias) {
    return $ScansTable(attachedDatabase, alias);
  }
}

class Scan extends DataClass implements Insertable<Scan> {
  final int id;
  final String scanType;
  final DateTime timestamp;
  final bool hasThreats;
  final String? details;
  const Scan({
    required this.id,
    required this.scanType,
    required this.timestamp,
    required this.hasThreats,
    this.details,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['scan_type'] = Variable<String>(scanType);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['has_threats'] = Variable<bool>(hasThreats);
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    return map;
  }

  ScansCompanion toCompanion(bool nullToAbsent) {
    return ScansCompanion(
      id: Value(id),
      scanType: Value(scanType),
      timestamp: Value(timestamp),
      hasThreats: Value(hasThreats),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
    );
  }

  factory Scan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Scan(
      id: serializer.fromJson<int>(json['id']),
      scanType: serializer.fromJson<String>(json['scanType']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      hasThreats: serializer.fromJson<bool>(json['hasThreats']),
      details: serializer.fromJson<String?>(json['details']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scanType': serializer.toJson<String>(scanType),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'hasThreats': serializer.toJson<bool>(hasThreats),
      'details': serializer.toJson<String?>(details),
    };
  }

  Scan copyWith({
    int? id,
    String? scanType,
    DateTime? timestamp,
    bool? hasThreats,
    Value<String?> details = const Value.absent(),
  }) => Scan(
    id: id ?? this.id,
    scanType: scanType ?? this.scanType,
    timestamp: timestamp ?? this.timestamp,
    hasThreats: hasThreats ?? this.hasThreats,
    details: details.present ? details.value : this.details,
  );
  Scan copyWithCompanion(ScansCompanion data) {
    return Scan(
      id: data.id.present ? data.id.value : this.id,
      scanType: data.scanType.present ? data.scanType.value : this.scanType,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      hasThreats: data.hasThreats.present
          ? data.hasThreats.value
          : this.hasThreats,
      details: data.details.present ? data.details.value : this.details,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Scan(')
          ..write('id: $id, ')
          ..write('scanType: $scanType, ')
          ..write('timestamp: $timestamp, ')
          ..write('hasThreats: $hasThreats, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, scanType, timestamp, hasThreats, details);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Scan &&
          other.id == this.id &&
          other.scanType == this.scanType &&
          other.timestamp == this.timestamp &&
          other.hasThreats == this.hasThreats &&
          other.details == this.details);
}

class ScansCompanion extends UpdateCompanion<Scan> {
  final Value<int> id;
  final Value<String> scanType;
  final Value<DateTime> timestamp;
  final Value<bool> hasThreats;
  final Value<String?> details;
  const ScansCompanion({
    this.id = const Value.absent(),
    this.scanType = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.hasThreats = const Value.absent(),
    this.details = const Value.absent(),
  });
  ScansCompanion.insert({
    this.id = const Value.absent(),
    required String scanType,
    required DateTime timestamp,
    this.hasThreats = const Value.absent(),
    this.details = const Value.absent(),
  }) : scanType = Value(scanType),
       timestamp = Value(timestamp);
  static Insertable<Scan> custom({
    Expression<int>? id,
    Expression<String>? scanType,
    Expression<DateTime>? timestamp,
    Expression<bool>? hasThreats,
    Expression<String>? details,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scanType != null) 'scan_type': scanType,
      if (timestamp != null) 'timestamp': timestamp,
      if (hasThreats != null) 'has_threats': hasThreats,
      if (details != null) 'details': details,
    });
  }

  ScansCompanion copyWith({
    Value<int>? id,
    Value<String>? scanType,
    Value<DateTime>? timestamp,
    Value<bool>? hasThreats,
    Value<String?>? details,
  }) {
    return ScansCompanion(
      id: id ?? this.id,
      scanType: scanType ?? this.scanType,
      timestamp: timestamp ?? this.timestamp,
      hasThreats: hasThreats ?? this.hasThreats,
      details: details ?? this.details,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scanType.present) {
      map['scan_type'] = Variable<String>(scanType.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (hasThreats.present) {
      map['has_threats'] = Variable<bool>(hasThreats.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScansCompanion(')
          ..write('id: $id, ')
          ..write('scanType: $scanType, ')
          ..write('timestamp: $timestamp, ')
          ..write('hasThreats: $hasThreats, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }
}

class $ThreatIndicatorsTable extends ThreatIndicators
    with TableInfo<$ThreatIndicatorsTable, ThreatIndicator> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThreatIndicatorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    value,
    severity,
    description,
    lastUpdated,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'threat_indicators';
  @override
  VerificationContext validateIntegrity(
    Insertable<ThreatIndicator> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ThreatIndicator map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ThreatIndicator(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}severity'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
    );
  }

  @override
  $ThreatIndicatorsTable createAlias(String alias) {
    return $ThreatIndicatorsTable(attachedDatabase, alias);
  }
}

class ThreatIndicator extends DataClass implements Insertable<ThreatIndicator> {
  final int id;
  final String type;
  final String value;
  final String severity;
  final String? description;
  final DateTime lastUpdated;
  const ThreatIndicator({
    required this.id,
    required this.type,
    required this.value,
    required this.severity,
    this.description,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['value'] = Variable<String>(value);
    map['severity'] = Variable<String>(severity);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  ThreatIndicatorsCompanion toCompanion(bool nullToAbsent) {
    return ThreatIndicatorsCompanion(
      id: Value(id),
      type: Value(type),
      value: Value(value),
      severity: Value(severity),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory ThreatIndicator.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ThreatIndicator(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      value: serializer.fromJson<String>(json['value']),
      severity: serializer.fromJson<String>(json['severity']),
      description: serializer.fromJson<String?>(json['description']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'value': serializer.toJson<String>(value),
      'severity': serializer.toJson<String>(severity),
      'description': serializer.toJson<String?>(description),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  ThreatIndicator copyWith({
    int? id,
    String? type,
    String? value,
    String? severity,
    Value<String?> description = const Value.absent(),
    DateTime? lastUpdated,
  }) => ThreatIndicator(
    id: id ?? this.id,
    type: type ?? this.type,
    value: value ?? this.value,
    severity: severity ?? this.severity,
    description: description.present ? description.value : this.description,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  ThreatIndicator copyWithCompanion(ThreatIndicatorsCompanion data) {
    return ThreatIndicator(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      value: data.value.present ? data.value.value : this.value,
      severity: data.severity.present ? data.severity.value : this.severity,
      description: data.description.present
          ? data.description.value
          : this.description,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ThreatIndicator(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('severity: $severity, ')
          ..write('description: $description, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, value, severity, description, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ThreatIndicator &&
          other.id == this.id &&
          other.type == this.type &&
          other.value == this.value &&
          other.severity == this.severity &&
          other.description == this.description &&
          other.lastUpdated == this.lastUpdated);
}

class ThreatIndicatorsCompanion extends UpdateCompanion<ThreatIndicator> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> value;
  final Value<String> severity;
  final Value<String?> description;
  final Value<DateTime> lastUpdated;
  const ThreatIndicatorsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    this.severity = const Value.absent(),
    this.description = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  ThreatIndicatorsCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required String value,
    required String severity,
    this.description = const Value.absent(),
    required DateTime lastUpdated,
  }) : type = Value(type),
       value = Value(value),
       severity = Value(severity),
       lastUpdated = Value(lastUpdated);
  static Insertable<ThreatIndicator> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? value,
    Expression<String>? severity,
    Expression<String>? description,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (value != null) 'value': value,
      if (severity != null) 'severity': severity,
      if (description != null) 'description': description,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  ThreatIndicatorsCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<String>? value,
    Value<String>? severity,
    Value<String?>? description,
    Value<DateTime>? lastUpdated,
  }) {
    return ThreatIndicatorsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      value: value ?? this.value,
      severity: severity ?? this.severity,
      description: description ?? this.description,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThreatIndicatorsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('severity: $severity, ')
          ..write('description: $description, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $ScanResultsTable extends ScanResults
    with TableInfo<$ScanResultsTable, ScanResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _scanIdMeta = const VerificationMeta('scanId');
  @override
  late final GeneratedColumn<int> scanId = GeneratedColumn<int>(
    'scan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES scans (id)',
    ),
  );
  static const VerificationMeta _threatIdMeta = const VerificationMeta(
    'threatId',
  );
  @override
  late final GeneratedColumn<int> threatId = GeneratedColumn<int>(
    'threat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES threat_indicators (id)',
    ),
  );
  static const VerificationMeta _appNameMeta = const VerificationMeta(
    'appName',
  );
  @override
  late final GeneratedColumn<String> appName = GeneratedColumn<String>(
    'app_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _threatNameMeta = const VerificationMeta(
    'threatName',
  );
  @override
  late final GeneratedColumn<String> threatName = GeneratedColumn<String>(
    'threat_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _severityLevelMeta = const VerificationMeta(
    'severityLevel',
  );
  @override
  late final GeneratedColumn<String> severityLevel = GeneratedColumn<String>(
    'severity_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packageNameMeta = const VerificationMeta(
    'packageName',
  );
  @override
  late final GeneratedColumn<String> packageName = GeneratedColumn<String>(
    'package_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foundInMeta = const VerificationMeta(
    'foundIn',
  );
  @override
  late final GeneratedColumn<String> foundIn = GeneratedColumn<String>(
    'found_in',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detectedAtMeta = const VerificationMeta(
    'detectedAt',
  );
  @override
  late final GeneratedColumn<DateTime> detectedAt = GeneratedColumn<DateTime>(
    'detected_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    scanId,
    threatId,
    appName,
    threatName,
    description,
    severityLevel,
    packageName,
    status,
    foundIn,
    detectedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScanResult> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('scan_id')) {
      context.handle(
        _scanIdMeta,
        scanId.isAcceptableOrUnknown(data['scan_id']!, _scanIdMeta),
      );
    } else if (isInserting) {
      context.missing(_scanIdMeta);
    }
    if (data.containsKey('threat_id')) {
      context.handle(
        _threatIdMeta,
        threatId.isAcceptableOrUnknown(data['threat_id']!, _threatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_threatIdMeta);
    }
    if (data.containsKey('app_name')) {
      context.handle(
        _appNameMeta,
        appName.isAcceptableOrUnknown(data['app_name']!, _appNameMeta),
      );
    } else if (isInserting) {
      context.missing(_appNameMeta);
    }
    if (data.containsKey('threat_name')) {
      context.handle(
        _threatNameMeta,
        threatName.isAcceptableOrUnknown(data['threat_name']!, _threatNameMeta),
      );
    } else if (isInserting) {
      context.missing(_threatNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('severity_level')) {
      context.handle(
        _severityLevelMeta,
        severityLevel.isAcceptableOrUnknown(
          data['severity_level']!,
          _severityLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_severityLevelMeta);
    }
    if (data.containsKey('package_name')) {
      context.handle(
        _packageNameMeta,
        packageName.isAcceptableOrUnknown(
          data['package_name']!,
          _packageNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packageNameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('found_in')) {
      context.handle(
        _foundInMeta,
        foundIn.isAcceptableOrUnknown(data['found_in']!, _foundInMeta),
      );
    } else if (isInserting) {
      context.missing(_foundInMeta);
    }
    if (data.containsKey('detected_at')) {
      context.handle(
        _detectedAtMeta,
        detectedAt.isAcceptableOrUnknown(data['detected_at']!, _detectedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_detectedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanResult(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      scanId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scan_id'],
      )!,
      threatId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}threat_id'],
      )!,
      appName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_name'],
      )!,
      threatName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}threat_name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      severityLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}severity_level'],
      )!,
      packageName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      foundIn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}found_in'],
      )!,
      detectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}detected_at'],
      )!,
    );
  }

  @override
  $ScanResultsTable createAlias(String alias) {
    return $ScanResultsTable(attachedDatabase, alias);
  }
}

class ScanResult extends DataClass implements Insertable<ScanResult> {
  final int id;
  final int scanId;
  final int threatId;
  final String appName;
  final String threatName;
  final String description;
  final String severityLevel;
  final String packageName;
  final String status;
  final String foundIn;
  final DateTime detectedAt;
  const ScanResult({
    required this.id,
    required this.scanId,
    required this.threatId,
    required this.appName,
    required this.threatName,
    required this.description,
    required this.severityLevel,
    required this.packageName,
    required this.status,
    required this.foundIn,
    required this.detectedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['scan_id'] = Variable<int>(scanId);
    map['threat_id'] = Variable<int>(threatId);
    map['app_name'] = Variable<String>(appName);
    map['threat_name'] = Variable<String>(threatName);
    map['description'] = Variable<String>(description);
    map['severity_level'] = Variable<String>(severityLevel);
    map['package_name'] = Variable<String>(packageName);
    map['status'] = Variable<String>(status);
    map['found_in'] = Variable<String>(foundIn);
    map['detected_at'] = Variable<DateTime>(detectedAt);
    return map;
  }

  ScanResultsCompanion toCompanion(bool nullToAbsent) {
    return ScanResultsCompanion(
      id: Value(id),
      scanId: Value(scanId),
      threatId: Value(threatId),
      appName: Value(appName),
      threatName: Value(threatName),
      description: Value(description),
      severityLevel: Value(severityLevel),
      packageName: Value(packageName),
      status: Value(status),
      foundIn: Value(foundIn),
      detectedAt: Value(detectedAt),
    );
  }

  factory ScanResult.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanResult(
      id: serializer.fromJson<int>(json['id']),
      scanId: serializer.fromJson<int>(json['scanId']),
      threatId: serializer.fromJson<int>(json['threatId']),
      appName: serializer.fromJson<String>(json['appName']),
      threatName: serializer.fromJson<String>(json['threatName']),
      description: serializer.fromJson<String>(json['description']),
      severityLevel: serializer.fromJson<String>(json['severityLevel']),
      packageName: serializer.fromJson<String>(json['packageName']),
      status: serializer.fromJson<String>(json['status']),
      foundIn: serializer.fromJson<String>(json['foundIn']),
      detectedAt: serializer.fromJson<DateTime>(json['detectedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scanId': serializer.toJson<int>(scanId),
      'threatId': serializer.toJson<int>(threatId),
      'appName': serializer.toJson<String>(appName),
      'threatName': serializer.toJson<String>(threatName),
      'description': serializer.toJson<String>(description),
      'severityLevel': serializer.toJson<String>(severityLevel),
      'packageName': serializer.toJson<String>(packageName),
      'status': serializer.toJson<String>(status),
      'foundIn': serializer.toJson<String>(foundIn),
      'detectedAt': serializer.toJson<DateTime>(detectedAt),
    };
  }

  ScanResult copyWith({
    int? id,
    int? scanId,
    int? threatId,
    String? appName,
    String? threatName,
    String? description,
    String? severityLevel,
    String? packageName,
    String? status,
    String? foundIn,
    DateTime? detectedAt,
  }) => ScanResult(
    id: id ?? this.id,
    scanId: scanId ?? this.scanId,
    threatId: threatId ?? this.threatId,
    appName: appName ?? this.appName,
    threatName: threatName ?? this.threatName,
    description: description ?? this.description,
    severityLevel: severityLevel ?? this.severityLevel,
    packageName: packageName ?? this.packageName,
    status: status ?? this.status,
    foundIn: foundIn ?? this.foundIn,
    detectedAt: detectedAt ?? this.detectedAt,
  );
  ScanResult copyWithCompanion(ScanResultsCompanion data) {
    return ScanResult(
      id: data.id.present ? data.id.value : this.id,
      scanId: data.scanId.present ? data.scanId.value : this.scanId,
      threatId: data.threatId.present ? data.threatId.value : this.threatId,
      appName: data.appName.present ? data.appName.value : this.appName,
      threatName: data.threatName.present
          ? data.threatName.value
          : this.threatName,
      description: data.description.present
          ? data.description.value
          : this.description,
      severityLevel: data.severityLevel.present
          ? data.severityLevel.value
          : this.severityLevel,
      packageName: data.packageName.present
          ? data.packageName.value
          : this.packageName,
      status: data.status.present ? data.status.value : this.status,
      foundIn: data.foundIn.present ? data.foundIn.value : this.foundIn,
      detectedAt: data.detectedAt.present
          ? data.detectedAt.value
          : this.detectedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanResult(')
          ..write('id: $id, ')
          ..write('scanId: $scanId, ')
          ..write('threatId: $threatId, ')
          ..write('appName: $appName, ')
          ..write('threatName: $threatName, ')
          ..write('description: $description, ')
          ..write('severityLevel: $severityLevel, ')
          ..write('packageName: $packageName, ')
          ..write('status: $status, ')
          ..write('foundIn: $foundIn, ')
          ..write('detectedAt: $detectedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    scanId,
    threatId,
    appName,
    threatName,
    description,
    severityLevel,
    packageName,
    status,
    foundIn,
    detectedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanResult &&
          other.id == this.id &&
          other.scanId == this.scanId &&
          other.threatId == this.threatId &&
          other.appName == this.appName &&
          other.threatName == this.threatName &&
          other.description == this.description &&
          other.severityLevel == this.severityLevel &&
          other.packageName == this.packageName &&
          other.status == this.status &&
          other.foundIn == this.foundIn &&
          other.detectedAt == this.detectedAt);
}

class ScanResultsCompanion extends UpdateCompanion<ScanResult> {
  final Value<int> id;
  final Value<int> scanId;
  final Value<int> threatId;
  final Value<String> appName;
  final Value<String> threatName;
  final Value<String> description;
  final Value<String> severityLevel;
  final Value<String> packageName;
  final Value<String> status;
  final Value<String> foundIn;
  final Value<DateTime> detectedAt;
  const ScanResultsCompanion({
    this.id = const Value.absent(),
    this.scanId = const Value.absent(),
    this.threatId = const Value.absent(),
    this.appName = const Value.absent(),
    this.threatName = const Value.absent(),
    this.description = const Value.absent(),
    this.severityLevel = const Value.absent(),
    this.packageName = const Value.absent(),
    this.status = const Value.absent(),
    this.foundIn = const Value.absent(),
    this.detectedAt = const Value.absent(),
  });
  ScanResultsCompanion.insert({
    this.id = const Value.absent(),
    required int scanId,
    required int threatId,
    required String appName,
    required String threatName,
    required String description,
    required String severityLevel,
    required String packageName,
    required String status,
    required String foundIn,
    required DateTime detectedAt,
  }) : scanId = Value(scanId),
       threatId = Value(threatId),
       appName = Value(appName),
       threatName = Value(threatName),
       description = Value(description),
       severityLevel = Value(severityLevel),
       packageName = Value(packageName),
       status = Value(status),
       foundIn = Value(foundIn),
       detectedAt = Value(detectedAt);
  static Insertable<ScanResult> custom({
    Expression<int>? id,
    Expression<int>? scanId,
    Expression<int>? threatId,
    Expression<String>? appName,
    Expression<String>? threatName,
    Expression<String>? description,
    Expression<String>? severityLevel,
    Expression<String>? packageName,
    Expression<String>? status,
    Expression<String>? foundIn,
    Expression<DateTime>? detectedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scanId != null) 'scan_id': scanId,
      if (threatId != null) 'threat_id': threatId,
      if (appName != null) 'app_name': appName,
      if (threatName != null) 'threat_name': threatName,
      if (description != null) 'description': description,
      if (severityLevel != null) 'severity_level': severityLevel,
      if (packageName != null) 'package_name': packageName,
      if (status != null) 'status': status,
      if (foundIn != null) 'found_in': foundIn,
      if (detectedAt != null) 'detected_at': detectedAt,
    });
  }

  ScanResultsCompanion copyWith({
    Value<int>? id,
    Value<int>? scanId,
    Value<int>? threatId,
    Value<String>? appName,
    Value<String>? threatName,
    Value<String>? description,
    Value<String>? severityLevel,
    Value<String>? packageName,
    Value<String>? status,
    Value<String>? foundIn,
    Value<DateTime>? detectedAt,
  }) {
    return ScanResultsCompanion(
      id: id ?? this.id,
      scanId: scanId ?? this.scanId,
      threatId: threatId ?? this.threatId,
      appName: appName ?? this.appName,
      threatName: threatName ?? this.threatName,
      description: description ?? this.description,
      severityLevel: severityLevel ?? this.severityLevel,
      packageName: packageName ?? this.packageName,
      status: status ?? this.status,
      foundIn: foundIn ?? this.foundIn,
      detectedAt: detectedAt ?? this.detectedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scanId.present) {
      map['scan_id'] = Variable<int>(scanId.value);
    }
    if (threatId.present) {
      map['threat_id'] = Variable<int>(threatId.value);
    }
    if (appName.present) {
      map['app_name'] = Variable<String>(appName.value);
    }
    if (threatName.present) {
      map['threat_name'] = Variable<String>(threatName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (severityLevel.present) {
      map['severity_level'] = Variable<String>(severityLevel.value);
    }
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (foundIn.present) {
      map['found_in'] = Variable<String>(foundIn.value);
    }
    if (detectedAt.present) {
      map['detected_at'] = Variable<DateTime>(detectedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanResultsCompanion(')
          ..write('id: $id, ')
          ..write('scanId: $scanId, ')
          ..write('threatId: $threatId, ')
          ..write('appName: $appName, ')
          ..write('threatName: $threatName, ')
          ..write('description: $description, ')
          ..write('severityLevel: $severityLevel, ')
          ..write('packageName: $packageName, ')
          ..write('status: $status, ')
          ..write('foundIn: $foundIn, ')
          ..write('detectedAt: $detectedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ScansTable scans = $ScansTable(this);
  late final $ThreatIndicatorsTable threatIndicators = $ThreatIndicatorsTable(
    this,
  );
  late final $ScanResultsTable scanResults = $ScanResultsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    scans,
    threatIndicators,
    scanResults,
  ];
}

typedef $$ScansTableCreateCompanionBuilder =
    ScansCompanion Function({
      Value<int> id,
      required String scanType,
      required DateTime timestamp,
      Value<bool> hasThreats,
      Value<String?> details,
    });
typedef $$ScansTableUpdateCompanionBuilder =
    ScansCompanion Function({
      Value<int> id,
      Value<String> scanType,
      Value<DateTime> timestamp,
      Value<bool> hasThreats,
      Value<String?> details,
    });

final class $$ScansTableReferences
    extends BaseReferences<_$AppDatabase, $ScansTable, Scan> {
  $$ScansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ScanResultsTable, List<ScanResult>>
  _scanResultsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.scanResults,
    aliasName: $_aliasNameGenerator(db.scans.id, db.scanResults.scanId),
  );

  $$ScanResultsTableProcessedTableManager get scanResultsRefs {
    final manager = $$ScanResultsTableTableManager(
      $_db,
      $_db.scanResults,
    ).filter((f) => f.scanId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scanResultsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ScansTableFilterComposer extends Composer<_$AppDatabase, $ScansTable> {
  $$ScansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scanType => $composableBuilder(
    column: $table.scanType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasThreats => $composableBuilder(
    column: $table.hasThreats,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> scanResultsRefs(
    Expression<bool> Function($$ScanResultsTableFilterComposer f) f,
  ) {
    final $$ScanResultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanResults,
      getReferencedColumn: (t) => t.scanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanResultsTableFilterComposer(
            $db: $db,
            $table: $db.scanResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ScansTableOrderingComposer
    extends Composer<_$AppDatabase, $ScansTable> {
  $$ScansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scanType => $composableBuilder(
    column: $table.scanType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasThreats => $composableBuilder(
    column: $table.hasThreats,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScansTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScansTable> {
  $$ScansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get scanType =>
      $composableBuilder(column: $table.scanType, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<bool> get hasThreats => $composableBuilder(
    column: $table.hasThreats,
    builder: (column) => column,
  );

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  Expression<T> scanResultsRefs<T extends Object>(
    Expression<T> Function($$ScanResultsTableAnnotationComposer a) f,
  ) {
    final $$ScanResultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanResults,
      getReferencedColumn: (t) => t.scanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanResultsTableAnnotationComposer(
            $db: $db,
            $table: $db.scanResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ScansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScansTable,
          Scan,
          $$ScansTableFilterComposer,
          $$ScansTableOrderingComposer,
          $$ScansTableAnnotationComposer,
          $$ScansTableCreateCompanionBuilder,
          $$ScansTableUpdateCompanionBuilder,
          (Scan, $$ScansTableReferences),
          Scan,
          PrefetchHooks Function({bool scanResultsRefs})
        > {
  $$ScansTableTableManager(_$AppDatabase db, $ScansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> scanType = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<bool> hasThreats = const Value.absent(),
                Value<String?> details = const Value.absent(),
              }) => ScansCompanion(
                id: id,
                scanType: scanType,
                timestamp: timestamp,
                hasThreats: hasThreats,
                details: details,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String scanType,
                required DateTime timestamp,
                Value<bool> hasThreats = const Value.absent(),
                Value<String?> details = const Value.absent(),
              }) => ScansCompanion.insert(
                id: id,
                scanType: scanType,
                timestamp: timestamp,
                hasThreats: hasThreats,
                details: details,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ScansTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({scanResultsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (scanResultsRefs) db.scanResults],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (scanResultsRefs)
                    await $_getPrefetchedData<Scan, $ScansTable, ScanResult>(
                      currentTable: table,
                      referencedTable: $$ScansTableReferences
                          ._scanResultsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ScansTableReferences(db, table, p0).scanResultsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.scanId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ScansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScansTable,
      Scan,
      $$ScansTableFilterComposer,
      $$ScansTableOrderingComposer,
      $$ScansTableAnnotationComposer,
      $$ScansTableCreateCompanionBuilder,
      $$ScansTableUpdateCompanionBuilder,
      (Scan, $$ScansTableReferences),
      Scan,
      PrefetchHooks Function({bool scanResultsRefs})
    >;
typedef $$ThreatIndicatorsTableCreateCompanionBuilder =
    ThreatIndicatorsCompanion Function({
      Value<int> id,
      required String type,
      required String value,
      required String severity,
      Value<String?> description,
      required DateTime lastUpdated,
    });
typedef $$ThreatIndicatorsTableUpdateCompanionBuilder =
    ThreatIndicatorsCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<String> value,
      Value<String> severity,
      Value<String?> description,
      Value<DateTime> lastUpdated,
    });

final class $$ThreatIndicatorsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ThreatIndicatorsTable, ThreatIndicator> {
  $$ThreatIndicatorsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ScanResultsTable, List<ScanResult>>
  _scanResultsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.scanResults,
    aliasName: $_aliasNameGenerator(
      db.threatIndicators.id,
      db.scanResults.threatId,
    ),
  );

  $$ScanResultsTableProcessedTableManager get scanResultsRefs {
    final manager = $$ScanResultsTableTableManager(
      $_db,
      $_db.scanResults,
    ).filter((f) => f.threatId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scanResultsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ThreatIndicatorsTableFilterComposer
    extends Composer<_$AppDatabase, $ThreatIndicatorsTable> {
  $$ThreatIndicatorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> scanResultsRefs(
    Expression<bool> Function($$ScanResultsTableFilterComposer f) f,
  ) {
    final $$ScanResultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanResults,
      getReferencedColumn: (t) => t.threatId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanResultsTableFilterComposer(
            $db: $db,
            $table: $db.scanResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ThreatIndicatorsTableOrderingComposer
    extends Composer<_$AppDatabase, $ThreatIndicatorsTable> {
  $$ThreatIndicatorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ThreatIndicatorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ThreatIndicatorsTable> {
  $$ThreatIndicatorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );

  Expression<T> scanResultsRefs<T extends Object>(
    Expression<T> Function($$ScanResultsTableAnnotationComposer a) f,
  ) {
    final $$ScanResultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanResults,
      getReferencedColumn: (t) => t.threatId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanResultsTableAnnotationComposer(
            $db: $db,
            $table: $db.scanResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ThreatIndicatorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ThreatIndicatorsTable,
          ThreatIndicator,
          $$ThreatIndicatorsTableFilterComposer,
          $$ThreatIndicatorsTableOrderingComposer,
          $$ThreatIndicatorsTableAnnotationComposer,
          $$ThreatIndicatorsTableCreateCompanionBuilder,
          $$ThreatIndicatorsTableUpdateCompanionBuilder,
          (ThreatIndicator, $$ThreatIndicatorsTableReferences),
          ThreatIndicator,
          PrefetchHooks Function({bool scanResultsRefs})
        > {
  $$ThreatIndicatorsTableTableManager(
    _$AppDatabase db,
    $ThreatIndicatorsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ThreatIndicatorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ThreatIndicatorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThreatIndicatorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String> severity = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
              }) => ThreatIndicatorsCompanion(
                id: id,
                type: type,
                value: value,
                severity: severity,
                description: description,
                lastUpdated: lastUpdated,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required String value,
                required String severity,
                Value<String?> description = const Value.absent(),
                required DateTime lastUpdated,
              }) => ThreatIndicatorsCompanion.insert(
                id: id,
                type: type,
                value: value,
                severity: severity,
                description: description,
                lastUpdated: lastUpdated,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ThreatIndicatorsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({scanResultsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (scanResultsRefs) db.scanResults],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (scanResultsRefs)
                    await $_getPrefetchedData<
                      ThreatIndicator,
                      $ThreatIndicatorsTable,
                      ScanResult
                    >(
                      currentTable: table,
                      referencedTable: $$ThreatIndicatorsTableReferences
                          ._scanResultsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ThreatIndicatorsTableReferences(
                            db,
                            table,
                            p0,
                          ).scanResultsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.threatId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ThreatIndicatorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ThreatIndicatorsTable,
      ThreatIndicator,
      $$ThreatIndicatorsTableFilterComposer,
      $$ThreatIndicatorsTableOrderingComposer,
      $$ThreatIndicatorsTableAnnotationComposer,
      $$ThreatIndicatorsTableCreateCompanionBuilder,
      $$ThreatIndicatorsTableUpdateCompanionBuilder,
      (ThreatIndicator, $$ThreatIndicatorsTableReferences),
      ThreatIndicator,
      PrefetchHooks Function({bool scanResultsRefs})
    >;
typedef $$ScanResultsTableCreateCompanionBuilder =
    ScanResultsCompanion Function({
      Value<int> id,
      required int scanId,
      required int threatId,
      required String appName,
      required String threatName,
      required String description,
      required String severityLevel,
      required String packageName,
      required String status,
      required String foundIn,
      required DateTime detectedAt,
    });
typedef $$ScanResultsTableUpdateCompanionBuilder =
    ScanResultsCompanion Function({
      Value<int> id,
      Value<int> scanId,
      Value<int> threatId,
      Value<String> appName,
      Value<String> threatName,
      Value<String> description,
      Value<String> severityLevel,
      Value<String> packageName,
      Value<String> status,
      Value<String> foundIn,
      Value<DateTime> detectedAt,
    });

final class $$ScanResultsTableReferences
    extends BaseReferences<_$AppDatabase, $ScanResultsTable, ScanResult> {
  $$ScanResultsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ScansTable _scanIdTable(_$AppDatabase db) => db.scans.createAlias(
    $_aliasNameGenerator(db.scanResults.scanId, db.scans.id),
  );

  $$ScansTableProcessedTableManager get scanId {
    final $_column = $_itemColumn<int>('scan_id')!;

    final manager = $$ScansTableTableManager(
      $_db,
      $_db.scans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_scanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ThreatIndicatorsTable _threatIdTable(_$AppDatabase db) =>
      db.threatIndicators.createAlias(
        $_aliasNameGenerator(db.scanResults.threatId, db.threatIndicators.id),
      );

  $$ThreatIndicatorsTableProcessedTableManager get threatId {
    final $_column = $_itemColumn<int>('threat_id')!;

    final manager = $$ThreatIndicatorsTableTableManager(
      $_db,
      $_db.threatIndicators,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_threatIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScanResultsTableFilterComposer
    extends Composer<_$AppDatabase, $ScanResultsTable> {
  $$ScanResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appName => $composableBuilder(
    column: $table.appName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get threatName => $composableBuilder(
    column: $table.threatName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get severityLevel => $composableBuilder(
    column: $table.severityLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get foundIn => $composableBuilder(
    column: $table.foundIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get detectedAt => $composableBuilder(
    column: $table.detectedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ScansTableFilterComposer get scanId {
    final $$ScansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scanId,
      referencedTable: $db.scans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScansTableFilterComposer(
            $db: $db,
            $table: $db.scans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ThreatIndicatorsTableFilterComposer get threatId {
    final $$ThreatIndicatorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.threatId,
      referencedTable: $db.threatIndicators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThreatIndicatorsTableFilterComposer(
            $db: $db,
            $table: $db.threatIndicators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScanResultsTable> {
  $$ScanResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appName => $composableBuilder(
    column: $table.appName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get threatName => $composableBuilder(
    column: $table.threatName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get severityLevel => $composableBuilder(
    column: $table.severityLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foundIn => $composableBuilder(
    column: $table.foundIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get detectedAt => $composableBuilder(
    column: $table.detectedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ScansTableOrderingComposer get scanId {
    final $$ScansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scanId,
      referencedTable: $db.scans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScansTableOrderingComposer(
            $db: $db,
            $table: $db.scans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ThreatIndicatorsTableOrderingComposer get threatId {
    final $$ThreatIndicatorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.threatId,
      referencedTable: $db.threatIndicators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThreatIndicatorsTableOrderingComposer(
            $db: $db,
            $table: $db.threatIndicators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScanResultsTable> {
  $$ScanResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get appName =>
      $composableBuilder(column: $table.appName, builder: (column) => column);

  GeneratedColumn<String> get threatName => $composableBuilder(
    column: $table.threatName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get severityLevel => $composableBuilder(
    column: $table.severityLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get foundIn =>
      $composableBuilder(column: $table.foundIn, builder: (column) => column);

  GeneratedColumn<DateTime> get detectedAt => $composableBuilder(
    column: $table.detectedAt,
    builder: (column) => column,
  );

  $$ScansTableAnnotationComposer get scanId {
    final $$ScansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scanId,
      referencedTable: $db.scans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScansTableAnnotationComposer(
            $db: $db,
            $table: $db.scans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ThreatIndicatorsTableAnnotationComposer get threatId {
    final $$ThreatIndicatorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.threatId,
      referencedTable: $db.threatIndicators,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ThreatIndicatorsTableAnnotationComposer(
            $db: $db,
            $table: $db.threatIndicators,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScanResultsTable,
          ScanResult,
          $$ScanResultsTableFilterComposer,
          $$ScanResultsTableOrderingComposer,
          $$ScanResultsTableAnnotationComposer,
          $$ScanResultsTableCreateCompanionBuilder,
          $$ScanResultsTableUpdateCompanionBuilder,
          (ScanResult, $$ScanResultsTableReferences),
          ScanResult,
          PrefetchHooks Function({bool scanId, bool threatId})
        > {
  $$ScanResultsTableTableManager(_$AppDatabase db, $ScanResultsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScanResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> scanId = const Value.absent(),
                Value<int> threatId = const Value.absent(),
                Value<String> appName = const Value.absent(),
                Value<String> threatName = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> severityLevel = const Value.absent(),
                Value<String> packageName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> foundIn = const Value.absent(),
                Value<DateTime> detectedAt = const Value.absent(),
              }) => ScanResultsCompanion(
                id: id,
                scanId: scanId,
                threatId: threatId,
                appName: appName,
                threatName: threatName,
                description: description,
                severityLevel: severityLevel,
                packageName: packageName,
                status: status,
                foundIn: foundIn,
                detectedAt: detectedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int scanId,
                required int threatId,
                required String appName,
                required String threatName,
                required String description,
                required String severityLevel,
                required String packageName,
                required String status,
                required String foundIn,
                required DateTime detectedAt,
              }) => ScanResultsCompanion.insert(
                id: id,
                scanId: scanId,
                threatId: threatId,
                appName: appName,
                threatName: threatName,
                description: description,
                severityLevel: severityLevel,
                packageName: packageName,
                status: status,
                foundIn: foundIn,
                detectedAt: detectedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ScanResultsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({scanId = false, threatId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (scanId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.scanId,
                                referencedTable: $$ScanResultsTableReferences
                                    ._scanIdTable(db),
                                referencedColumn: $$ScanResultsTableReferences
                                    ._scanIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (threatId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.threatId,
                                referencedTable: $$ScanResultsTableReferences
                                    ._threatIdTable(db),
                                referencedColumn: $$ScanResultsTableReferences
                                    ._threatIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScanResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScanResultsTable,
      ScanResult,
      $$ScanResultsTableFilterComposer,
      $$ScanResultsTableOrderingComposer,
      $$ScanResultsTableAnnotationComposer,
      $$ScanResultsTableCreateCompanionBuilder,
      $$ScanResultsTableUpdateCompanionBuilder,
      (ScanResult, $$ScanResultsTableReferences),
      ScanResult,
      PrefetchHooks Function({bool scanId, bool threatId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ScansTableTableManager get scans =>
      $$ScansTableTableManager(_db, _db.scans);
  $$ThreatIndicatorsTableTableManager get threatIndicators =>
      $$ThreatIndicatorsTableTableManager(_db, _db.threatIndicators);
  $$ScanResultsTableTableManager get scanResults =>
      $$ScanResultsTableTableManager(_db, _db.scanResults);
}
