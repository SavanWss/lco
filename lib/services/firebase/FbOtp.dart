import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:little_miracles_orphange/services/sendEmails/SendEmail.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';

class FbOtp {
  static fbSaveOTP({required user_email}) async {
    int min = 1000;
    int max = 9999;
    int otp = min + Random().nextInt((max + 1) - min);

    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('otp');

      try {
        final firstResponse = await collection.doc(user_email).set({
          "date_and_time": DateTime.now(),
          "OTP": "${otp}",
          "user_email": user_email,
        });

        await SendEmail.sendOtpEmail(
            user_email: LoggedInDetails.userEmail,
            sub: "OTP OF FUND DETAILS",
            body: "Your OTP is ${otp}");
        print("your otp == ${otp}");
        return {"status": true, "OTP": otp};
      } catch (e) {
        return {"status": false, "error": e};
      }
    } catch (e) {
      return {"status": false, "error": e};
    }
  }

  static fbOTPValidation({required user_email, required user_otp}) async {
    QuerySnapshot snapShot =
        await FirebaseFirestore.instance.collection("notices").get();
    List<Object?> data = snapShot.docs.map((e) {
      return e.data();
    }).toList();

    List a = data as List;
    print(a);

    a.sort((a, b) {
      return Comparable.compare(
          a["date_and_time"].toString(), b["date_and_time"].toString());
    });

// your last otp
    var otp = a[a.length - 1];

    if (otp.toString() == user_otp) {
      return true;
    } else {
      return false;
    }
  }
}
