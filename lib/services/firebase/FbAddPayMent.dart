import 'package:cloud_firestore/cloud_firestore.dart';

class FbAddPayMent {
  static fbAddPayMent({required user_email, required funds}) async {
    try {
       CollectionReference collection =
          FirebaseFirestore.instance.collection("payment_account");

      QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection("payment_account")
        .where("user_email", isEqualTo: user_email)
        .get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

  print("list ==  ${data}");

    var ls = data as List;

    print(ls);

    var balance = ls[0]["balance"].toString();

      collection.doc(user_email).set(
          {"balance": int.parse(balance) + int.parse(funds)}, SetOptions(merge: true));


    } catch (e) {
      return {"status": false, "error": e};
    }
  }
}