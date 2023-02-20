import 'package:cloud_firestore/cloud_firestore.dart';

class FbGetReports {

  static fbGetThingsReport()  async{
       QuerySnapshot snapShot =
        await FirebaseFirestore.instance.collection("things_donations").get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();



    return data;
  }


 static fbGetFundsReport()  async{
       QuerySnapshot snapShot =
        await FirebaseFirestore.instance.collection("payment_details").get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();
 
 return data;
 }

}