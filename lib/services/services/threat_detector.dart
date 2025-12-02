// lib/services/threat_detector.dart

import 'package:capstoneproject/services/database/database.dart';
import 'package:capstoneproject/services/database/database_extensions.dart';
import 'package:collection/collection.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class ThreatDetector {
  final AppDatabase _database;

  ThreatDetector(this._database);

  Future<List<ScanResult>> performFullScan({
    Function(String)? onProgress,
  }) async {
    final List<AppInfo> installedApps;
    try {
      installedApps = await InstalledApps.getInstalledApps();
    } catch (e) {
      throw Exception('Failed to retrieve installed apps: $e');
    }

    // Fetch only the malicious IOCs. Threats with severity 'safe' are ignored here.
    final knownThreats = await _database.getAllThreatIndicators()
      .then((threats) => threats.where((t) => t.severity.toLowerCase() != 'safe').toList());
    
    final List<ScanResult> unsavedResults = [];

    // 3. Iterate through real installed apps and check for threats.
    for (final app in installedApps) {
      if (onProgress != null) {
        onProgress('Scanning ${app.name} (${app.packageName})...');
      }

      await Future.delayed(const Duration(milliseconds: 50));

      // Match app package name against known 'package' IOCs.
      final foundThreat = knownThreats.firstWhereOrNull(
        (threat) => threat.type == 'package' && threat.value == app.packageName,
      );

      // FIX: Only add a ScanResult to the list if an actual threat is found.
      if (foundThreat != null) {
        unsavedResults.add(
          ScanResult(
            id: 0, 
            scanId: 0, 
            threatId: foundThreat.id, // Use the unique ID of the specific threat
            appName: app.name, 
            threatName: foundThreat.value,
            description:
                foundThreat.description ?? 'A known malicious package detected.',
            severityLevel: foundThreat.severity,
            packageName: app.packageName, 
            status: 'active',
            foundIn: 'App Package Name', 
            detectedAt: DateTime.now(),
          ),
        );
      }
      // Safe apps are NOT added to the results list.
    }

    // 4. Save the completed scan results (only threats) to the database.
    final savedResults = await _database.saveScanAndResults(unsavedResults);
    return savedResults;
  }
}