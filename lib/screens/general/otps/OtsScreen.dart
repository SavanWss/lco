import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/utils/authentication/Otps.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(
      children: [
        SizedBox(),


        OTPTextField(
      length: 6,
      fieldStyle: FieldStyle.box,
      keyboardType: TextInputType.number,
      otpFieldStyle: OtpFieldStyle(borderColor: Color.fromARGB(255, 0, 0, 0),
      disabledBorderColor: Colors.grey,
      errorBorderColor: Colors.redAccent,
      enabledBorderColor: Color.fromRGBO(82, 21, 72, 1),
       ),

      spaceBetween: 10,
      onCompleted: (value) {
        if (value == Otps.sendedOtp) {
      
        } else {
          Otps.otpFlag = false;
        }
      },
    )
      ],
    ));
  }
}