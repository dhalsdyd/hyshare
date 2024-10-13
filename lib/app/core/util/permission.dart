import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  Future<bool> requestNotification() async {
    bool isGranted = await Permission.notification.isGranted;
    if (!isGranted) {
      PermissionStatus status = await Permission.notification.request();
      return status.isGranted;
    }
    return isGranted;
  }

  Future<bool> requestNotification2() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}
