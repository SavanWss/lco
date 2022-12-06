import 'package:firebase_auth/firebase_auth.dart';

class FbSignOut {
  static fbSignOut() async {
    await FirebaseAuth.instance.signOut();
  }
}