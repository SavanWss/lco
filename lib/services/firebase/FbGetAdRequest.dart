import 'package:cloud_firestore/cloud_firestore.dart';

class FbGetAdRequests {
  static fbGetAdRequests() async {
    QuerySnapshot snapShot =
        await FirebaseFirestore.instance.collection("adoption_process_detail").get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    return data;
  }

  static fbGetAdRequestsById({required uniqueid}) async {
    QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection("adoption_process_detail")
        .where("unique_id", isEqualTo: uniqueid)
        .get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    return data;
  }

  static fbGetAdRequestsByUserName({required useremail}) async {
      QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection("adoption_process_detail")
        .where("user_email", isEqualTo: useremail)
        .get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

  print("data ============ ${data}");

    return data;
  }

  static fgGetAdRequestAccordingStatus({required useremail, required requestStatus}) async {
  QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection("adoption_process_detail")
        .where("user_email", isEqualTo: useremail)
        .where("request_status", isEqualTo: requestStatus)
        .get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    return data;
  }

}
