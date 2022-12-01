import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:little_miracles_orphange/screens/signup/SignUp.dart';
import 'package:little_miracles_orphange/services/firebase/FbAuth.dart';

class FbSignUp {

  static fbSignUp(
      {required email,
      required password,
      required name,
      required mobile,
      required gender,
      required dob,
      required profession,
      required yearllyIncome,
      required address,
      required marriedStatus}) async {
    try {
      // email id entered in firebase auth module
      print("fb sign up called");
      var response =
          await FbAuth.fbAuthSignUp(email: email, password: password);
      print("response === ${response}");
      print("in main if status faild outsider");
      // if (response.status == false) {
      //   print("in main if status faild");
      //   return {"status": false, "error": response.error};
      // }
      print("in main if status faild outsider under below the code");
      // users data store in firestore
      CollectionReference userData =
          FirebaseFirestore.instance.collection("users");

      print("collection reference === ${userData}");

      var fireStoreResponse = await userData.add({
        "address": "address",
        "adopted_child": "0",
        "dob": "13/11/2002",
        "email": email,
        "gender": "male",
        "married_status": "true",
        "mobile": "9898489400",
        "name": "Savan Italiya",
        "password": password,
        "profession": profession,
        "role": "user",
        "total_dnt_fund": 0,
        "yearly_income": 0,
      });
      print(fireStoreResponse);
      return fireStoreResponse;
    } catch (e) {
      return {"status": false, "error": e};
    }
  }

  static signup() async {
     CollectionReference userData =
          FirebaseFirestore.instance.collection("users");

      print("collection reference === ${userData}");

      var fireStoreResponse = await userData.add({
        "address": "address",
        "adopted_child": "0",
        "dob": "13/11/2002",
        "email": "email",
        "gender": "male",
        "married_status": "true",
        "mobile": "9898489400",
        "name": "Savan Italiya",
        "password": "password",
        "profession": "profession",
        "role": "user",
        "total_dnt_fund": "0",
        "yearly_income": "0",
      });
      print(fireStoreResponse);
  }

}


void main(List<String> args) async {
  await FbSignUp.signup();
}