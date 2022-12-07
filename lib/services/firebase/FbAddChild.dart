import 'package:cloud_firestore/cloud_firestore.dart';

class FbAddChild {
  static fbAddChild(
      {required name,
      required dob,
      required entrancedate,
      required gender,
      required adoptedstatus,
      required guidancename,
      required medicalstatus,
      required medicalstatusdescription}) async {
    try {
      // users data store in firestore

      CollectionReference userData =
          FirebaseFirestore.instance.collection("childs");

      print("collection reference childs === $userData");

      final QuerySnapshot qSnap =
          await FirebaseFirestore.instance.collection('childs').get();
      final int childIndex = qSnap.docs.length;

      // List<Object?> data = snapshot.docs.map((e) {
      //   return e.data();
      // }).toList();

      try {
        var fireStoreResponse = await userData.add({
          "name": name,
          "dob": dob,
          "entrance_date": entrancedate,
          "gender": gender,
          "adopted_status": adoptedstatus,
          "guidance_name": guidancename,
          "medical_status": medicalstatus,
          "medical_status_description": medicalstatusdescription,
          "child_number": childIndex + 1
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
