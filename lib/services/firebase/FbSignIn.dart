import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:little_miracles_orphange/services/firebase/FbAuth.dart';

class FbSignIn {
  static fbSignIn({required email, required password}) async {
    final loginFlag = await FbAuth.fbAuthLogin(email: email, password: password);

    if (loginFlag["status"] == false) {
      return {"status": false, "error": loginFlag["error"]};
    }

    // users data store in firestore

    CollectionReference userData = FirebaseFirestore.instance.collection("users");

    var data = userData.where("email", isEqualTo: email);

    print("your data is ===> $data");

    print("loginFlag === $loginFlag");
  }
}
