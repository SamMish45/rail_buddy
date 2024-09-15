import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> requestGalleryPermission() async {
    var status = await Permission.photos.request();
    return status.isGranted;
  }

  Future<void> openAppSettings() async {
    await openAppSettings();
  }
}
