import 'package:cloud_firestore/cloud_firestore.dart';

class FbGetAllDonation {
static fbGetAllDonation({required funds}) async {
     try {
       CollectionReference collection =
          FirebaseFirestore.instance.collection("payment_account");

      QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection("payment_account")
        .where("payment_id", isEqualTo: "lco@locPay")
        .get();

    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

  var list = data as List;

      collection.doc("lco").set(
          {"balance": int.parse(list[0]["balance"]) + int.parse(funds)}, SetOptions(merge: true));


    } catch (e) {
      return {"status": false, "error": e};
    }
  }
}
