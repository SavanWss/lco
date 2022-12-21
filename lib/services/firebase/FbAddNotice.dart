// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class FbAddNotice {
  static fbAddNotice(
      {required event_title,
      required event_topic,
      required description,
      required event_date_time,
      required event_mode,
      required event_organize}) async {
    try {
      
      CollectionReference noticeData =
          FirebaseFirestore.instance.collection("notices");

      print("collection reference childs === $noticeData");

      final QuerySnapshot qSnap =
          await FirebaseFirestore.instance.collection('notices').get();
      final int NoticeIndex = qSnap.docs.length;

      try {
        var fireStoreResponse = await noticeData.add({
          "date_and_time":DateTime.now().millisecondsSinceEpoch,
          "decsription":description,
          "event_date_and_time":event_date_time,
          "event_mode":event_mode,
          "event_title":event_title,
          "event_topic":event_topic,
          "organised_by":event_organize,
          "unique_id":NoticeIndex+1
          });

        print(fireStoreResponse);

        return {"status": true, "body": fireStoreResponse};
      } catch (e) {
        return {"status": false, "error": e};
      }
    } catch (e) {
      return {"status": false, "error": e};
    }
  }
}
