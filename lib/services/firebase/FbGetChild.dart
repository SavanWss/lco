import 'package:cloud_firestore/cloud_firestore.dart';

class FbGetChild {
  static fbGetAllChild() async {
    QuerySnapshot snapShot =
        await FirebaseFirestore.instance.collection("childs").get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    return data;
  }

  static fbGetChildById({required uniqueid}) async {
    QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection("childs")
        .where("child_number", isEqualTo: uniqueid)
        .get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    return data;
  }

  static fbGetChildByAquisition({required aquisitionType}) async {
    QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection("childs")
        .where("adopted_status", isEqualTo: aquisitionType)
        .get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    return data;
  }

}
