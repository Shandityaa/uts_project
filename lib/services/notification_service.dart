import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _messaging.requestPermission();

    final token = await _messaging.getToken();
    if (kDebugMode) {
      print("FCM TOKEN: $token");
    }

    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print("Pesan diterima (foreground): ${message.notification?.title}");
      }
    });
  }
}
// update