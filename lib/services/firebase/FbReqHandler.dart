import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';

class FbReqHandler {
  static fbAcceptRequest({required childId, required requestedUser}) async {
    print("requested user == ${requestedUser}");
    print("child user == ${childId}");
    try {
      var collection = FirebaseFirestore.instance.collection('childs');

      var querySnapshots =
          await collection.where("child_number", isEqualTo: childId).get();

      for (var snapshot in querySnapshots.docs) {
        var documentID = snapshot.id; // <-- Document ID
        print("doc id == ${documentID}");
        collection
            .doc(documentID)
            .set({"adopted_status": "Yes"}, SetOptions(merge: true));
      }
      print("status updated");

      var collection1 = FirebaseFirestore.instance.collection('users');

      var querySnapshots1 =
          await collection1.where("email", isEqualTo: requestedUser).get();

      print("doc user id array == ${querySnapshots1}");

      for (var snapshot in querySnapshots1.docs) {
        var documentID1 = snapshot.id; // <-- Document ID
        print("doc user id == ${documentID1}");
        print("doc id == ${documentID1}");
        collection1
            .doc(documentID1)
            .set({"adopted_child": 1, "child_number": childId}, SetOptions(merge: true));
      }

      var collection2 = FirebaseFirestore.instance.collection('adoption_process_detail');

      var querySnapshots2 =
          await collection2.where("email", isEqualTo: requestedUser).get();

      print("doc user id array == ${querySnapshots2}");


        collection2
            .doc(requestedUser)
            .set({"request_status": "Accepted", "accepted_time": DateTime.now(), "child_number": childId}, SetOptions(merge: true));
  

      return {"status": true, "body": "success"};
    } catch (e) {
      return {"status": false, "body": e};
    }
  }

  static fbRejectRequest({required requestedUser, required rejectionReason}) async{
    try {

       var collection2 = FirebaseFirestore.instance.collection('adoption_process_detail');

      print("requested user 111111111 == ${requestedUser}");
      print("requested rejection 111111111 == ${rejectionReason}");
        collection2
            .doc(requestedUser)
            .set({"request_status": "Rejected", "rejection_reason": rejectionReason,}, SetOptions(merge: true));
  

       return {"status": true, "body": "success"};
    } catch (e) {
      return {"status": false, "body": e};
    }
  }
}

//  .set({"1":"s"}, SetOptions(merge: true));