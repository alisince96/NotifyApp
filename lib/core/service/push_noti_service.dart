import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebasePushNoti {
  final firebaseMessage = FirebaseMessaging.instance;
  var token = '';

  Future<void> initNoti() async {
    final req = await firebaseMessage.requestPermission();
    print(req.authorizationStatus.index);
    if (req.authorizationStatus.index == 1) {
      final fcmToken = await firebaseMessage.getToken();
      token = fcmToken ?? '';
      print('Token: $token');
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      initPushNoti();
    }
  }

  initPushNoti() {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  }

  String getToken() {
    return token;
  }

  void handleMessage(RemoteMessage? value) {
    if (value == null) return;
  }
}
