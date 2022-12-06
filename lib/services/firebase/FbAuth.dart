import 'package:firebase_auth/firebase_auth.dart';

class FbAuth {
  static fbAuthSignUp({required email, required password}) async {
    try {
      print("fb auth caled");
      final flag = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("flag === ${flag}");
      return {"status": true, "body": flag};
    } catch (e) {
      print("error ${e}");
      return {"status": false, "error": e};
    }
  }

  static fbAuthLogin({required email, required password}) async {
    try {
      final flag = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return {"status": true, "body": flag};
    } catch (e) {
      return {"status": false, "error": e};
    }
  }

  static fbAuthRemove() async {
    try {
      // final deletedUser = await
      try {
        await FirebaseAuth.instance.currentUser!.delete();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          print(
              'The user must reauthenticate before this operation can be executed.');
        }
      }
    } catch (e) {
      print("user not deleted");
    }
  }
}
