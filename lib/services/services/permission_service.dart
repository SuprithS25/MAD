import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestAllPermissions() async {
    // The list of permissions to be requested
    final permissionsToRequest = [
      // Required for app functionality and device scanning proxy
      Permission.phone,
      
      // Request for managing external storage (covers modern Android requirement)
      Permission.manageExternalStorage, 
      
      // These are often needed but let's keep it clean
      // Permission.accessMediaLocation,
      // Permission.accessNotificationPolicy,
      // Permission.systemAlertWindow,
    ];

    // Request permissions and store the results in a map
    // Note: Calling .request() on a list of Permissions will request them simultaneously.
    final Map<Permission, PermissionStatus> statuses = await permissionsToRequest.request();

    // Check if critical permissions are granted
    final storageGranted = statuses[Permission.manageExternalStorage]?.isGranted ?? false;
    final phoneGranted = statuses[Permission.phone]?.isGranted ?? false;

    return storageGranted && phoneGranted;
  }

  static Future<bool> hasRequiredPermissions() async {
    // Check the required permissions statuses directly
    final requiredPermissions = [
      Permission.manageExternalStorage.status, // Check modern storage access
      Permission.phone.status,
    ];

    final List<PermissionStatus> statuses = await Future.wait(requiredPermissions);

    // Check if all required permissions have been granted
    return statuses.every((s) => s.isGranted);
  }
}