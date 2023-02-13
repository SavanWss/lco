import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class FbPayMentAccount {
  static fbCreatePayMentAcc({required user_email}) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("payment_account");

      String uniqueId = user_email.split("@")[0];

      try {
        final firstResponse = collection.doc(user_email).set({
          "user_email": user_email,
          "payment_id": "${uniqueId}@lcoPay",
          "balance": 1500,
        });
        return {"status": true, "body": firstResponse};
      } catch (e) {
        return {"status": false, "error": e};
      }
    } catch (e) {
      return {"status": false, "error": e};
    }
  }

  static fbDonateRevokeFunds(
      {required user_email, required donate, required funds}) async {
    QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection("notices")
        .where("user_email", isEqualTo: user_email)
        .get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    var ls = data as List;

    print(ls);

    var balance = ls[0]["balance"].toString();

    print(balance);

    if (int.parse(balance as String) - funds <= 0) {
      return {"status": false, "error": "insufficient funds"};
    }

    var collection2 = FirebaseFirestore.instance.collection('payment_account');

    CollectionReference collection =
        FirebaseFirestore.instance.collection("payment_details");

    if (donate) {
      collection2.doc(user_email).set(
          {"balance": int.parse(balance) - funds}, SetOptions(merge: true));

      collection2.doc("lco").set(
          {"balance": int.parse(balance) + funds}, SetOptions(merge: true));

      final firstResponse = collection.doc(user_email).set({
        "user_email": user_email,
        "payment_id_to": "${user_email.split("@")[0]}@lcoPay",
        "payment_id_from": "lco@lcoPay",
        "date_and_time": DateTime.now(),
        "status": "success",
        "funds": funds,
        "where": "donation"
      });

      return {"status": true, "msg": "funds donated successfully"};
    } else {
      collection2.doc(user_email).set(
          {"balance": int.parse(balance) - funds}, SetOptions(merge: true));

      final firstResponse = collection.doc(user_email).set({
        "user_email": user_email,
             "payment_id_to": "${user_email.split("@")[0]}@lcoPay",
        "payment_id_from": "cash",
        "date_and_time": DateTime.now(),
        "status": "success",
        "funds": funds,
        "where": "revoked"
      });

      return {"status": true, "msg": "funds revoked successfully"};
    }
  }
}
