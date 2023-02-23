import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';

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

  static fbGetChildBySpecificUserAdoption() async {
      QuerySnapshot snapShot = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: LoggedInDetails.userEmail)
        .get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    print(data);
  List a = data as List;

  QuerySnapshot snapShot2 = await FirebaseFirestore.instance
        .collection("childs")
        .where("child_number", isEqualTo: a[0]["child_number"])
        .get();
    List<Object?> childData = snapShot2.docs.map((e) {
      return e.data();
    }).toList();

print("childsssss ===== ${childData}");

    return childData;
  }

}
