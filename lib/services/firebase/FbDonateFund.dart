import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';


class FbDonateFund {
  static fbDonateFund(
      {required amount ,
      required donatedby,
      required paymentmethod,
      }) async {
    try {

      // ignore: non_constant_identifier_names
      CollectionReference DonateFundData =
          FirebaseFirestore.instance.collection("fund_donations");

      print("collection reference childs === $DonateFundData");

      final QuerySnapshot qSnap =
          await FirebaseFirestore.instance.collection('fund_donations').get();
      final int donateFIndex = qSnap.docs.length;

      // List<Object?> data = snapshot.docs.map((e) {
      //   return e.data();
      // }).toList();

      try {
        var fireStoreResponse = await DonateFundData.add({
            "amount":amount,
            "date_and_time": DateTime.now().millisecondsSinceEpoch,
            "donated_by":donatedby,
            "payment_id":donateFIndex+1,
            "payment_methood":paymentmethod,
            "user_email":LoggedInDetails.userEmail,
            "user_name":LoggedInDetails.userName,
            "user_mumber":LoggedInDetails.userMobile,

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
