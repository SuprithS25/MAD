// lib/services/database/database.dart

import 'package:drift/drift.dart';
import 'connection/connection.dart';
import 'package:capstoneproject/services/database/database_extensions.dart';

part 'database.g.dart';

class Scans extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get scanType => text()(); // full, quick, custom
  DateTimeColumn get timestamp => dateTime()();
  BoolColumn get hasThreats => boolean().withDefault(const Constant(false))();
  TextColumn get details => text().nullable()();
}

class ThreatIndicators extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()(); // ip, url, app, package, etc.
  TextColumn get value => text()();
  TextColumn get severity => text()(); // high, medium, low
  TextColumn get description => text().nullable()();
  DateTimeColumn get lastUpdated => dateTime()();
}

/// Updated ScanResults table to include fields from your original ScanResult class
class ScanResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get scanId => integer().references(Scans, #id)();
  IntColumn get threatId => integer().references(ThreatIndicators, #id)();

  // Extra fields you had in your ScanResult class
  TextColumn get appName => text()();
  TextColumn get threatName => text()();
  TextColumn get description => text()();
  TextColumn get severityLevel => text()();
  TextColumn get packageName => text()();
  TextColumn get status => text()(); // e.g., resolved, quarantined, active

  TextColumn get foundIn => text()(); // where threat was detected
  DateTimeColumn get detectedAt => dateTime()();
}

@DriftDatabase(tables: [Scans, ThreatIndicators, ScanResults])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Singleton pattern for easy access
  static final AppDatabase _instance = AppDatabase();
  static AppDatabase get instance => _instance;

  @override
  int get schemaVersion => 1;

  // Insertions
  Future<int> insertScan(ScansCompanion scan) => into(scans).insert(scan);
  Future<int> insertThreat(ThreatIndicatorsCompanion threat) =>
      into(threatIndicators).insert(threat);
  Future<int> insertScanResult(ScanResultsCompanion result) =>
      into(scanResults).insert(result);

  // Queries
  Future<List<Scan>> getRecentScans() {
    final query = select(scans)
      ..orderBy([
        (t) => OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc),
      ]);
    return query.get();
  }

  // Fetch ScanResults (flat list)
  Future<List<ScanResult>> getAllScanResults() => select(scanResults).get();

  // Get all existing Threat Indicators for IoC comparison
  Future<List<ThreatIndicator>> getAllThreatIndicators() =>
      select(threatIndicators).get();

  /// Rectified Transactional Save Logic to correctly link ScanSession and Results
  Future<List<ScanResult>> saveScanAndResults(List<ScanResult> results) async {
    return transaction(() async {
      // Determine if ANY result is an actual threat (results.isNotEmpty)
      final actualThreatsFound = results.isNotEmpty;

      // 1. Insert the new scan session first to get the auto-incremented ID.
      final newScanId = await insertScan(ScansCompanion.insert(
        scanType: 'full',
        timestamp: DateTime.now(),
        hasThreats: Value(actualThreatsFound), // Only true if threats were found
      ));

      final savedResults = <ScanResult>[];
      for (var result in results) {
        // 2. Start with the companion from the unsaved result object.
        final originalCompanion = result.toCompanion(true);

        // 3. CRITICAL FIX: Explicitly set the correct scanId obtained from step 1.
        final updatedCompanion = originalCompanion.copyWith(
          scanId: Value(newScanId),
        );

        // 4. Insert the corrected companion and get the new row ID.
        final savedId = await into(scanResults).insert(updatedCompanion);

        // 5. Create a final, complete ScanResult object with the correct IDs for the caller.
        savedResults.add(result.copyWith(
          scanId: newScanId, // Use the correct ID
          id: savedId, // Use the database-assigned ID
        ));
      }
      return savedResults;
    });
  }

  /// Query to fetch all Scan results grouped by their scan session.
  Future<Map<Scan, List<ScanResult>>> getScanHistory() async {
    final query = select(scans).join([
      leftOuterJoin(scanResults, scanResults.scanId.equalsExp(scans.id)) // Use LEFT JOIN to include scans with no results
    ])
      ..orderBy([
        OrderingTerm(expression: scans.timestamp, mode: OrderingMode.desc),
      ]);

    final rows = await query.get();

    // Map to hold Scan (session) and its list of results
    final Map<Scan, List<ScanResult>> historyMap = {};

    for (final row in rows) {
      final scan = row.readTable(scans);
      final result = row.readTableOrNull(scanResults); // Use readTableOrNull for LEFT JOIN

      historyMap.putIfAbsent(scan, () => []);
      if (result != null) {
        historyMap[scan]!.add(result);
      }
    }

    // Ensure scans that have no threats are also present.
    final allScans = await getRecentScans();
    for (final scan in allScans) {
      historyMap.putIfAbsent(scan, () => []);
    }

    // Sort each list of ScanResults by detectedAt (desc)
    for (final entry in historyMap.entries) {
      entry.value.sort((a, b) => b.detectedAt.compareTo(a.detectedAt));
    }

    return historyMap;
  }

  // Enable foreign keys
  Future<void> init() async {
    await customStatement('PRAGMA foreign_keys = ON');
  }

  // Pre-populate with known threats
  Future<void> populateDefaultThreats() async {
    final defaultThreats = [
      ThreatIndicatorsCompanion(
        type: Value('ip'),
        value: Value('192.168.1.100'),
        severity: Value('high'),
        description: Value('Known malicious Command & Control IP'),
        lastUpdated: Value(DateTime.now()),
      ),
      ThreatIndicatorsCompanion(
        type: Value('url'),
        value: Value('malicious-domain.com'),
        severity: Value('medium'),
        description: Value('Phishing or data exfiltration domain'),
        lastUpdated: Value(DateTime.now()),
      ),
      // CRITICAL IOC: This package name will be detected if present
      ThreatIndicatorsCompanion(
        type: Value('package'),
        value: Value('com.android.trojan.banker'), 
        severity: Value('high'),
        description: Value('Known financial trojan package name (IOC)'),
        lastUpdated: Value(DateTime.now()),
      ),
      // Add another mock package to ensure it works
      ThreatIndicatorsCompanion(
        type: Value('package'),
        value: Value('com.malware.fakeapp'),
        severity: Value('medium'),
        description: Value('App mimicking a popular utility to steal data.'),
        lastUpdated: Value(DateTime.now()),
      ),
      // FIX: Add a generic indicator for 'Safe/No Threat Found'
      ThreatIndicatorsCompanion(
        type: Value('info'),
        value: Value('secure'),
        severity: Value('safe'),
        description: Value('No malicious Indicators of Compromise detected.'),
        lastUpdated: Value(DateTime.now()),
      ),
    ];

    // Simple check to avoid inserting duplicates on every start
    if (await select(threatIndicators).get().then((value) => value.isEmpty)) {
      for (final threat in defaultThreats) {
        await insertThreat(threat);
      }
    }
  }
}

LazyDatabase _openConnection() {
  return openExecutor();
}