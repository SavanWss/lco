import 'package:cloud_firestore/cloud_firestore.dart';

class FbGetUser {
  static fbGetAllUsres() async {
    QuerySnapshot snapShot =
        await FirebaseFirestore.instance.collection("users").get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    return data;
  }

  static fbGetUsreById({required email}) async {
    QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    return data;
  }
}
