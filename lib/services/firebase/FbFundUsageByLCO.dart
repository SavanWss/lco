import 'package:cloud_firestore/cloud_firestore.dart';

class FbFundUsageByLCO {
  static fbFundUsageByLCO({required funds, required description}) async {
    QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection("payment_account")
        .where("payment_id", isEqualTo: "lco@lcoPay")
        .get();

    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    var ls = data as List;

    print("ls === ${ls}");

    var balance = ls[0]["balance"].toString();
    var number = int.parse(balance);

    if (number - int.parse(funds) <= 0) {
      print("aafter 111122");
      return {"status": false, "error": "insufficient funds"};
    }

    //  //  //  //  //  //

    CollectionReference collection =
        FirebaseFirestore.instance.collection("donation_usage");

    var collection2 = FirebaseFirestore.instance.collection('payment_account');

    collection2.doc("lco").set(
        {"balance": int.parse(balance) - int.parse(funds)},
        SetOptions(merge: true));

    final firstResponse = collection.doc().set({
      "payment_id_from": "lco@lcoPay",
      "date_and_time": DateTime.now(),
      "status": "success",
      "funds": funds,
      "description": description
    });

    return {"status": true, "msg": "funds revoked successfully"};
  }

  static fbGetFundUsageDetailsByLCO() async {
    try {
      
         QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection("donation_usage").get();

    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

  
    return data;
    

    } catch (e) {
      return {"status": false, "error": e};
    }
  }

}
