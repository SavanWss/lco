import 'package:cloud_firestore/cloud_firestore.dart';

class FbGetNotice {
  static fbGetAllNotice() async {
    QuerySnapshot snapShot =
        await FirebaseFirestore.instance.collection("notices").get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    return data;
  }

  static fbGetNoticeById({required uniqueid}) async {
    QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection("notices")
        .where("unique_id", isEqualTo: uniqueid)
        .get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    return data;
  }
}
