import 'package:firebase_messaging/firebase_messaging.dart';

class FbGetDeviceToken {
  static fbGetDeviceToken() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    final tokenString = token.toString();
    print("device token from file === $tokenString");
    return tokenString;
  }
}
  