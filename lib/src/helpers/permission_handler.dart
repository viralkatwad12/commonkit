import 'package:permission_handler/permission_handler.dart';
import 'logger.dart';

/// A utility class to manage app permissions.
/// Simplifies requesting and checking common permissions.
class PermissionManager {
  /// Requests a specific [permission] and returns whether it was granted.
  static Future<bool> request(Permission permission) async {
    final status = await permission.request();
    Logger.info('Permission ${permission.toString()} status: $status');
    return status.isGranted;
  }

  /// Checks if a specific [permission] is granted.
  static Future<bool> isGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  /// Opens the app settings for manual permission management.
  static Future<void> openSettings() async {
    await openAppSettings();
    Logger.info('Opened app settings for permission management');
  }
}