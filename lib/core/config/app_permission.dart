import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class AppPermission {
  /// Request a single permission
  static Future<bool> requestPermission(Permission permission) async {
    // Check current permission status
    PermissionStatus status = await permission.status;

    // If not granted, request permission
    if (!status.isGranted) {
      status = await permission.request();
    }

    // Return true if permission is granted
    return status.isGranted;
  }

  /// Request multiple permissions
  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
      List<Permission> permissions,
      ) async {
    return await permissions.request();
  }

  /// Check if a specific permission is granted
  static Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.isGranted;
  }

  /// Show a permission denied dialog
  static void showPermissionDeniedDialog(
      BuildContext context, {
        String? title,
        String? message,
        VoidCallback? onOpenSettings,
      }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? 'Permission Denied'),
          content: Text(
            message ?? 'Please grant the required permissions in app settings.',
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  /// Open app settings
  static Future<void> openAppSettings() async {
    await openAppSettings();
  }

  /// Convenience method for camera permission
  static Future<bool> requestCameraPermission(BuildContext context) async {
    bool isGranted = await requestPermission(Permission.camera);

    if (!isGranted) {
      showPermissionDeniedDialog(
        context,
        title: 'Camera Permission',
        message: 'Camera access is required to take photos.',
      );
    }

    return isGranted;
  }

  /// Convenience method for gallery/photo library permission
  static Future<bool> requestGalleryPermission(BuildContext context) async {
    bool isGranted = await requestPermission(Permission.photos);

    if (!isGranted) {
      showPermissionDeniedDialog(
        context,
        title: 'Gallery Permission',
        message: 'Photo library access is required to select images.',
      );
    }

    return isGranted;
  }

  /// Convenience method for storage permissions
  static Future<bool> requestStoragePermissions(BuildContext context) async {
    List<Permission> storagePermissions = Platform.isAndroid
        ? [Permission.storage]
        : [Permission.photos];

    Map<Permission, PermissionStatus> statuses =
    await requestMultiplePermissions(storagePermissions);

    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (!allGranted) {
      showPermissionDeniedDialog(
        context,
        title: 'Storage Permission',
        message: 'Storage access is required to save or access files.',
      );
    }

    return allGranted;
  }
}