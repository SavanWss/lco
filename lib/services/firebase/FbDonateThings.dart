import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';


class FbDonateThings {
  static fbDonateThings(
      {required category ,
      required things,
      required quantity,
      }) async {
    try {
      // users data store in firestore

      CollectionReference DonateThingsData =
          FirebaseFirestore.instance.collection("things_donations");

      print("collection reference childs === $DonateThingsData");

      final QuerySnapshot qSnap =
          await FirebaseFirestore.instance.collection('things_donations').get();
      final int donateIndex = qSnap.docs.length;

      // List<Object?> data = snapshot.docs.map((e) {
      //   return e.data();
      // }).toList();

      try {
        var fireStoreResponse = await DonateThingsData.add({
            "category":category,
            "date_and_time": DateTime.now(),
            "name_of_things":things,
            "quantity":quantity,
            "unique_id":donateIndex+1,
            "user_email":LoggedInDetails.userEmail,
            "user_name":LoggedInDetails.userName,

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
