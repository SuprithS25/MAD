// lib/services/screens/scan_history_screen.dart

import 'package:flutter/material.dart';
import 'package:capstoneproject/services/database/database.dart';
import 'package:capstoneproject/services/database/database_extensions.dart';

class ScanHistoryScreen extends StatelessWidget {
  final AppDatabase _database = AppDatabase();

  ScanHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FIX: Use FutureBuilder to fetch the Scan History Map (Scan Session + Results)
    return Scaffold(
      appBar: AppBar(title: const Text('Scan History')),
      body: FutureBuilder<Map<Scan, List<ScanResult>>>(
        future: _database.getScanHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error loading history: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          } else {
            final scanHistory = snapshot.data!;
            // Sort by timestamp descending (newest first)
            final sortedScans = scanHistory.keys.toList()
              ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

            if (sortedScans.isEmpty) {
               return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_open, size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 20),
                    Text(
                      'No Scan History Yet',
                      style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Perform a scan to see your results here.',
                      style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                    ),
                  ],
                ),
              );
            }
            
            return ListView.builder(
              itemCount: sortedScans.length,
              itemBuilder: (context, index) {
                final scan = sortedScans[index];
                final results = scanHistory[scan]!;
                final hasThreats = scan.hasThreats;
                final threatCount = results.length;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  elevation: 2,
                  child: ExpansionTile(
                    leading: Icon(
                      hasThreats ? Icons.warning_amber : Icons.check_circle,
                      color: hasThreats ? Colors.red[600] : Colors.green[400],
                    ),
                    title: Text('Full Scan - ${_formatDate(scan.timestamp)}'),
                    subtitle: Text(
                      hasThreats
                          ? '$threatCount Threat${threatCount > 1 ? 's' : ''} Detected'
                          : 'No Threats Found',
                      style: TextStyle(
                        color: hasThreats ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    // Display individual threat results as sub-items
                    children: results.map((result) {
                      return ListTile(
                        contentPadding: const EdgeInsets.only(left: 32, right: 16),
                        title: Text(result.appName),
                        subtitle: Text('Threat: ${result.threatName}'),
                        trailing: Text(result.severityLevel),
                        onTap: () => _showResultDetails(context, result),
                      );
                    }).toList(),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
  
  void _showResultDetails(BuildContext context, ScanResult result) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(result.threatName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('App: ${result.appName}'),
            const SizedBox(height: 8),
            Text('Package: ${result.packageName}'),
            const SizedBox(height: 8),
            Text('Severity: ${result.severityLevel}'),
            const SizedBox(height: 8),
            Text('Found in: ${result.foundIn}'),
            const SizedBox(height: 8),
            Text('Status: ${result.status}'),
            const SizedBox(height: 8),
            Text(
              'Description: ${result.description}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Detected at: ${_formatDate(result.detectedAt)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }


  /// Helper function to format DateTime nicely
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} '
        '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}