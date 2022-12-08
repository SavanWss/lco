import 'package:cloud_firestore/cloud_firestore.dart';

class FbGetChild {
  static fbGetAllChild() async {
    QuerySnapshot snapShot = await FirebaseFirestore.instance.collection("childs").get();
        List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();


    return data;
  }
}

