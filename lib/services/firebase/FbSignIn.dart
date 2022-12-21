// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:little_miracles_orphange/services/firebase/FbAuth.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetDeviceToken.dart';

class FbSignIn {
  static fbSignIn({required email, required password}) async {
    final loginFlag =
        await FbAuth.fbAuthLogin(email: email, password: password);

    if (loginFlag["status"] == false) {
      return {"status": false, "error": loginFlag["error"]};
    }

    // users data store in firestore

//     Future<QuerySnapshot<Map<String, dynamic>>> userData1 = FirebaseFirestore.instance.collection("users").get();

//     var data1 = userData1;

//     print("your data is ===> ${data1}");
// FirebaseFirestore.instance
//     .collection('users')
//     .get()
//     .then((QuerySnapshot querySnapshot) {
//         querySnapshot.docs.forEach((doc) {
//             print(doc.data());
//         });
//     }).catchError((Error) {
//       print(Error);
//     });
// print("after");

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();

    var data1 = snapshot.docs;

    List<Object?> data = snapshot.docs.map((e) {
      return e.data();
    }).toList();
    print("new userData 1111 $data");
    print("before obj");

    print("loginFlag === $loginFlag");

// set push notification token

    var pushNotificationToken = await FbGetDeviceToken.fbGetDeviceToken();

    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('push_tokens');
      var ad1 = await collection
          .doc(email)
          .set({"email": email, "token": pushNotificationToken});
    } catch (e) {}

    print("print data is settled");
    return {"status": true, "data": data};
  }
}
