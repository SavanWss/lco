import 'package:cloud_firestore/cloud_firestore.dart';

class FbAddAdRequests {
  static fbAddAdRequests(
      {required description,
      required agepreference,
      required genderpreference,
      required username,
      required useremail}) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('adoption_process_detail');

      try {
        final firstResponse = await collection.doc(useremail).set({
          "adoption_description": description,
          "age_preference": agepreference,
          "gender_preference": genderpreference,
          "date_and_time": DateTime.now(),
          "request_status": "Pending",
          "user_email": useremail,
          "user_name": username,
          "rejection_reason": "" 
        });

        return {"status": true};
      } catch (e) {
        return {"status": false, "error": e};
      }
    } catch (e) {
      return {"status": false, "error": e};
    }
  }
}
