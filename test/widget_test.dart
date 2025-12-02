import 'package:capstoneproject/services/database/database.dart';
import 'package:capstoneproject/services/database/database_extensions.dart';
import 'package:device_apps/device_apps.dart';

class ThreatDetector {
  final AppDatabase _database;

  ThreatDetector(this._database);

  Future<List<ScanResult>> performFullScan({
    required Function(String appName) onProgress,
  }) async {
    final results = <ScanResult>[];
    final installedApps = await DeviceApps.getInstalledApplications(
      includeAppIcons: false,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: false,
    );

    final knownThreats = await _database.getAllThreatIndicators();

    for (var app in installedApps) {
      // Ensure app has properties needed for comparison
      if (app is Application) {
        // Perform threat matching by package name
        final matchingThreat = knownThreats.firstWhere(
          (threat) => threat.type == 'package' && threat.value == app.packageName,
          orElse: () => null,
        );
        if (matchingThreat != null) {
          results.add(
            ScanResult(
              id: 0, // Placeholder, will be replaced by DB
              scanId: 0, // Placeholder
              threatId: matchingThreat.id,
              appName: app.appName,
              threatName: matchingThreat.description ?? 'Unknown threat',
              description: 'This app matches a known malicious package name.',
              severityLevel: matchingThreat.severity,
              packageName: app.packageName,
              status: 'active',
              foundIn: 'Application Package',
              detectedAt: DateTime.now(),
            ),
          );
        }
      }
      onProgress(app is Application ? app.appName : 'Unknown');
    }

    // Save all detected results to the database
    if (results.isNotEmpty) {
      await _database.saveScanAndResults(results);
    }

    return results;
  }
}
