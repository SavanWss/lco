import 'dart:convert';

import "package:http/http.dart" as http;

class Notifications {
  static sendNotification(
      {required deviceToken, required title, required body}) async {
        print("api is fired");
    var url = Uri(host: "fcm.googleapis.com",path: "fcm/send",scheme: 'https');
    var reasponse = await http.post(
      url,
      headers: {
        'Content-Type': 'applixation/json',
        'Authorization': 'key=AAAAcaoSxKs:APA91bG1PzRDQWqrvaeFtnCtlpR2x4NQOXv1L2TRPQUwazICgS9TRi_JKLZB5yCLzeiz0zPkKO6Ims6Mpu2fXuBu2GoMc0Y9WoMUCe2SjOUqIu-tCvVWAbylxpZGCWNzJ8c5iOodx-QB'
      },
      body: jsonEncode({
        "to": deviceToken,
        "notification": {
          "body": body,
          "title": title,
          "android_channel_id": "little_miracle_orphanage",
          "sound": true
        }
      }),
    );
    print("notification api response ===> ${reasponse.body}");
  }
}
