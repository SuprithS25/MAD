// lib/services/screens/home_screens.dart
import 'package:flutter/material.dart';
import 'package:capstoneproject/services/services/permission_service.dart';
import 'package:capstoneproject/services/services/threat_detector.dart';
import 'package:capstoneproject/services/database/database.dart';
import 'package:capstoneproject/services/screens/results_screen.dart';
import 'package:capstoneproject/services/screens/chatbot_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppDatabase _database = AppDatabase();
  late final ThreatDetector _detector;

  bool _isScanning = false;
  String _scanStatus = 'Ready to scan';
  String _currentApp = '';

  @override
  void initState() {
    super.initState();
    _detector = ThreatDetector(_database);
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _database.init(); 
    await _database.populateDefaultThreats();
  }

  Future<void> _startScan() async {
    final allPermissionsGranted = await PermissionService.requestAllPermissions();

    if (!allPermissionsGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Permissions are required to perform the scan. Please grant them.',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    setState(() {
      _isScanning = true;
      _scanStatus = 'Scanning...';
      _currentApp = '';
    });

    try {
      final List<ScanResult> savedResults = await _detector.performFullScan(
        onProgress: (appName) {
          if (mounted) {
            setState(() {
              _scanStatus = 'Scanning: $appName';
              _currentApp = appName;
            });
          }
        },
      );

      if (mounted) {
        setState(() {
          _isScanning = false;
          _scanStatus = 'Scan completed';
          _currentApp = '';
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(scanResults: savedResults),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isScanning = false;
          _scanStatus = 'Scan failed: ${e.toString()}';
          _currentApp = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Scan failed: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MAD'),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade800,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade800!, Colors.indigo.shade400!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.shield_outlined,
              size: 120,
              color: Colors.white,
            ),
            const SizedBox(height: 30),
            const Text(
              'Malicious Application Detector',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              'Scan your device to detect potential threats and malicious activities.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: _isScanning ? null : _startScan,
                icon: _isScanning
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Icon(Icons.play_arrow_rounded, size: 28),
                label: Text(
                  _isScanning ? 'SCANNING...' : 'START SCAN',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isScanning
                      ? Colors.blue[400]
                      : Colors.green.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _scanStatus,
              style: TextStyle(
                fontSize: 18,
                color: _isScanning ? Colors.white : Colors.greenAccent,
                fontWeight: _isScanning ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (_isScanning && _currentApp.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                _currentApp,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatbotScreen(),
            ),
          );
        },
        child: const Icon(Icons.chat),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}