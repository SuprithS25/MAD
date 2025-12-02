// lib/services/database/database_extensions.dart
import 'package:capstoneproject/services/database/database.dart';
import 'package:drift/drift.dart';

extension ScanResultCompanionExtension on ScanResult {
  ScanResultsCompanion toCompanion(bool isInsert) {
    return ScanResultsCompanion(
      id: isInsert ? const Value.absent() : Value(id),
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
}