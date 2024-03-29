import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:little_miracles_orphange/services/firebase/FbAuth.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetDeviceToken.dart';

class FbSignUp {
  static fbSignUp(
      {required email,
      required password,
      required name,
      required mobile,
      required gender,
      required dob,
      required profession,
      required yearllyIncome,
      required address,
      required marriedStatus}) async {
    var notificstionToekn;

    try {
      // email id entered in firebase auth module
      var response =
          await FbAuth.fbAuthSignUp(email: email, password: password);
      print("response === $response");

      if (response["status"] == false) {
        return {"status": false, "error": response["error"]};
      }

      // users data store in firestore

      //  var pushToken =  await FirebaseMessaging.instance.getToken();

      CollectionReference userData =
          FirebaseFirestore.instance.collection("users");

      print("collection reference === $userData");

      try {
        notificstionToekn = await FbGetDeviceToken.fbGetDeviceToken();
        var fireStoreResponse = await userData.add({
          "address": address,
          "adopted_child": 0,
          "dob": dob,
          "email": email,
          "gender": gender,
          "married_status": marriedStatus,
          "mobile": mobile,
          "name": name,
          "password": password,
          "profession": profession,
          "role": "user",
          "total_dnt_fund": 0,
          "yearly_income": int.parse(yearllyIncome),
          'token': notificstionToekn
        });

        print(fireStoreResponse);

        var pushNotificationToken = await FbGetDeviceToken.fbGetDeviceToken();

        try {
          CollectionReference collection =
              FirebaseFirestore.instance.collection('push_tokens');
          await collection
              .doc(email)
              .set({"email": email, "token": pushNotificationToken});
        } catch (e) {}

        return {"status": true, "body": fireStoreResponse};
      } catch (e) {
        FbAuth.fbAuthRemove();

        return {"status": false, "error": e};
      }
    } catch (e) {
      return {"status": false, "error": e};
    }
  }
}
