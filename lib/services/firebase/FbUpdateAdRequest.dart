import 'package:cloud_firestore/cloud_firestore.dart';

class FbUpdateAdRequest {
  fbUpdateAdRequestStatus({required useremail, required updatedStatus}) async {
    var collection = FirebaseFirestore.instance.collection('adoption_process_detail');
collection
    .doc(useremail).update({"request_status":updatedStatus});
  }
}