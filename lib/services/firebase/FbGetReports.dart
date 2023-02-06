import 'package:cloud_firestore/cloud_firestore.dart';

class FbGetReports {
  static fbGetFundReports() async{
       QuerySnapshot snapShot =
        await FirebaseFirestore.instance.collection("things_donations").get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    return data;
  }

  static fbGetThingsReport()  async{
       QuerySnapshot snapShot =
        await FirebaseFirestore.instance.collection("things_donations").get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    return data;
  }
}