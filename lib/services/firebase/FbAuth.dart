import 'package:firebase_auth/firebase_auth.dart';

class FbAuth {
  static fbAuthSignUp({required email, required password}) async {
    try {
      print("fb auth caled");
      var flag = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return {
        "status" : true,
        "body" : flag
      };
    } catch (e) {
      return {
        "status" : false,
        "error" : e
      };
    }
  }
}