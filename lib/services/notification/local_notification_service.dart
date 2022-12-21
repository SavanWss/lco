import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{

  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    // initialized setting on android
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );


    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("on select notification");
        print(details);

      },
    );
  }

  static void createanddisplaynotification(RemoteMessage message) async{
    try {
      final id = DateTime.now().microsecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails("little_miracle_orphanage", "little_miracle_orphanagechannel",
        importance: Importance.max,
        priority: Priority.high
        )
      );

      await _notificationsPlugin.show(id, message.notification!.title, message.notification!.body, notificationDetails, payload: message.data['_id']);
    }on Exception catch (e) {
      print(e);
    }
  }

}