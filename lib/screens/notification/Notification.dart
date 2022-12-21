// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:http/http.dart' as http;
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
// import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/services/notification/local_notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  Future getToekn() async{
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    final tokenString = token.toString();
    print("token ====== $tokenString");
  }

  @override
  void initState() {
    super.initState();

    getToekn();

    /// app when terminated  
    FirebaseMessaging.instance.getInitialMessage().then((msg) {
      print("FirebaseMessaging instance getInitialMessage");

      if (msg != null) {
        print("we got the new notification in termination mode");
      }

    });

    /// app when foreground
    FirebaseMessaging.onMessage.listen((message) {
      print("FirebaseMessaging onMessage listen"); 
      if (message.notification != null) {
        print("we got a new notification in foreground mode");
        print(message.notification!.title);
        print(message.notification!.body);
        print("bnotification data ==> ${message.data}");
        LocalNotificationService.createanddisplaynotification(message);
      }
     });

    /// app when background
    FirebaseMessaging.onMessageOpenedApp.listen((message) { 
       print("FirebaseMessaging onMessageOpenedApp listen"); 
      if (message.notification != null) {
        print("we got a new notification in background mode");
        print(message.notification!.title);
        print(message.notification!.body);
        print("bnotification data ==> ${message.data}");
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notification"),
      ),
      drawer: AdminDrawer(),
      body: Center(child: Text("Push notification")),
    );
  }
}
