import 'package:flutter/material.dart';
// FIX: Corrected import path for permission_service.dart
import 'package:capstoneproject/services/services/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionPrivacyScreen extends StatefulWidget {
  const PermissionPrivacyScreen({Key? key}) : super(key: key);

  @override
  _PermissionPrivacyScreenState createState() =>
      _PermissionPrivacyScreenState();
}

class _PermissionPrivacyScreenState extends State<PermissionPrivacyScreen> {
  // --- UPDATED: Use a more specific status for external storage ---
  PermissionStatus _storageStatus = PermissionStatus.denied;
  PermissionStatus _phoneStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    // --- UPDATED: Check for the MANAGE_EXTERNAL_STORAGE status ---
    final storageStatus = await Permission.manageExternalStorage.status;
    final phoneStatus = await Permission.phone.status;
    if (mounted) {
      setState(() {
        _storageStatus = storageStatus;
        _phoneStatus = phoneStatus;
      });
    }
  }

  Future<void> _requestPermissions() async {
    await PermissionService.requestAllPermissions();
    _checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions & Privacy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPermissionsSection(),
            const SizedBox(height: 24),
            _buildPrivacyPolicySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Required Permissions',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildPermissionItem(
          title: 'Storage Access',
          description:
              'Needed to scan the device\'s storage for malicious files (Requires "All Files Access").',
          status: _storageStatus,
        ),
        const SizedBox(height: 12),
        _buildPermissionItem(
          title: 'Phone State',
          description:
              'Required to identify applications and services running on your device.',
          status: _phoneStatus,
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: _requestPermissions,
          icon: const Icon(Icons.settings),
          label: const Text('Request Permissions'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
          ),
        ),
      ],
    );
  }

  Widget _buildPermissionItem({
    required String title,
    required String description,
    required PermissionStatus status,
  }) {
    Color iconColor;
    IconData icon;
    String statusText;

    // Check if the permission is granted
    if (status.isGranted) {
      iconColor = Colors.green;
      icon = Icons.check_circle;
      statusText = 'Granted';
    }
    // This case specifically handles MANAGE_EXTERNAL_STORAGE where the user has to go to settings manually.
    else if (status.isDenied || status.isPermanentlyDenied) {
      iconColor = Colors.red;
      icon = Icons.error;
      statusText = 'Denied';
      if (status.isPermanentlyDenied) {
        statusText = 'Permanently Denied';
      }

      // If storage is denied, suggest opening app settings to manually grant All Files Access
      if (title.contains('Storage Access') && status.isDenied) {
        statusText = 'Denied (Requires Manual Grant)';
      }
    } else {
      iconColor = Colors.orange;
      icon = Icons.warning;
      statusText = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                Text(
                  'Status: $statusText',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyPolicySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Privacy Policy',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Data Collection and Usage',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Sentinel Shield is designed to protect your device without compromising your privacy. The application does not collect any personal data, such as your identity, contacts, or location. All scanning is performed locally on your device. Only aggregated, non-personal data (e.g., number of threats detected) may be used to improve the service and threat intelligence accuracy.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),
              Text(
                'Third-Party Services',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'This application uses publicly available threat intelligence feeds. We do not share any of your local scan data with these third-party services. The information is downloaded from them and used for local comparison only.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
