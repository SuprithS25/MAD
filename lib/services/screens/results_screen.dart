import 'package:flutter/material.dart';
import 'package:capstoneproject/services/database/database.dart';
import 'package:installed_apps/installed_apps.dart'; // Import for native call

class ResultsScreen extends StatefulWidget {
  final List<ScanResult> scanResults;

  const ResultsScreen({super.key, required this.scanResults});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  // Filter out the 'safe' results for the results screen presentation
  List<ScanResult> get _threatResults => widget.scanResults
      .where((result) => result.severityLevel.toLowerCase() != 'safe')
      .toList();

  final List<ScanResult> _dismissedResults = [];

  @override
  Widget build(BuildContext context) {
    final activeResults = _threatResults
        .where((result) => !_dismissedResults.contains(result))
        .toList();

    final hasThreats = activeResults.isNotEmpty;
    final threatCount = activeResults.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Scan Findings')),
      body: Container(
        color: Colors.grey[50],
        child: Column(
          children: [
            _buildSummaryCard(hasThreats, threatCount),

            Expanded(
              child: hasThreats
                  ? _buildThreatsList(activeResults)
                  : _buildNoThreatsFound(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(bool hasThreats, int threatCount) {
    // Since we only save threats, totalScanned is not accurately known here, but the intent is clear.
    final threatSummary = hasThreats
        ? '$threatCount issue${threatCount > 1 ? 's' : ''} found during scan.'
        : 'No issues found. Device is secure.';

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              hasThreats ? Icons.warning_amber : Icons.check_circle_outline,
              size: 72,
              color: hasThreats ? Colors.orange[700] : Colors.green[600],
            ),
            const SizedBox(height: 20),
            Text(
              hasThreats ? 'Potential Threats Detected' : 'No Threats Found',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: hasThreats ? Colors.orange[700] : Colors.green[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              threatSummary,
              style: const TextStyle(fontSize: 17, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Scan completed: ${DateTime.now().toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThreatsList(List<ScanResult> results) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return _buildThreatCard(result, index);
      },
    );
  }

  Widget _buildThreatCard(ScanResult result, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.security_rounded,
                    color: Colors.red,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.threatName.isEmpty ? 'Unknown Threat' : result.threatName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        result.description.isEmpty ? 'No description available' : result.description,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Divider(height: 1, color: Colors.grey[200]),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.phone_android, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'App: ${result.appName.isEmpty ? 'Unknown Application' : result.appName}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.access_time_filled_rounded,
                  size: 18,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  'Detected: ${_formatTimestamp(result.detectedAt)}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildSeverityChip(result.severityLevel),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _resolveThreat(result),
                  icon: const Icon(Icons.build_circle, size: 20),
                  label: const Text('RESOLVE'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red[700],
                    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoThreatsFound() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified_user_rounded,
              size: 100,
              color: Colors.green[400],
            ),
            const SizedBox(height: 30),
            const Text(
              'Device is Secure!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Great news! No malicious applications or suspicious activities were found during the scan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Back to Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeverityChip(String? severity) {
    Color chipColor;
    String label;
    Color textColor = Colors.white;

    switch (severity?.toLowerCase()) {
      case 'high':
        chipColor = Colors.red[700]!;
        label = 'HIGH';
        break;
      case 'medium':
        chipColor = Colors.orange[700]!;
        label = 'MEDIUM';
        break;
      case 'low':
        chipColor = Colors.yellow[800]!;
        label = 'LOW';
        textColor = Colors.black;
        break;
      default:
        chipColor = Colors.grey[600]!;
        label = 'UNKNOWN';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return 'Unknown time';

    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes} min ago';
    if (difference.inHours < 24) return '${difference.inHours} hours ago';
    if (difference.inDays < 30) return '${difference.inDays} days ago';

    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }

  void _dismissWarning(ScanResult result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          'Dismiss Warning',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to dismiss the warning for "${result.threatName}"?\nThis action cannot be undone.',
          style: TextStyle(color: Colors.grey[700]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _dismissedResults.add(result);
              });
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Warning for "${result.threatName}" dismissed.',
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(15),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Dismiss'),
          ),
        ],
      ),
    );
  }

  void _resolveThreat(ScanResult result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          'Threat Resolution',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To neutralize the **${result.threatName}** threat from **${result.appName}**, you must **uninstall the application**:',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 10),
            Text(
              'Package Name: ${result.packageName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              'Press "Uninstall App" to open your device\'s App Info screen. From there, manually select "Uninstall".',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _dismissedResults.add(result);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Warning for "${result.threatName}" dismissed. **Please proceed with manual uninstallation.**',
                  ),
                  backgroundColor: Colors.orange,
                  duration: const Duration(seconds: 5),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(15),
                ),
              );
            },
            child: const Text(
              'Dismiss Temporarily',
              style: TextStyle(color: Colors.orange),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                // Actual native call to open app settings screen
                await InstalledApps.openSettings(result.packageName);
              } catch (e) {
                print('Error opening settings: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Failed to open settings for ${result.appName}. Please uninstall manually via device settings.',
                    ),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 5),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(15),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Uninstall App'),
          ),
        ],
      ),
    );
  }
}