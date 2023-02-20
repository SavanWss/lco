import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:little_miracles_orphange/commonwidget/indicator/CircularIndicator.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/services/connectivitychecker/InterNetConnectionChecker.dart';
import 'package:little_miracles_orphange/services/firebase/FbOtp.dart';
import 'package:little_miracles_orphange/services/firebase/FbPayMentAccount.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';
import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class SettingPayMentUserScreen extends StatefulWidget {
  const SettingPayMentUserScreen({super.key});

  @override
  State<SettingPayMentUserScreen> createState() =>
      _SettingPayMentUserScreenState();
}

class _SettingPayMentUserScreenState extends State<SettingPayMentUserScreen> {
  final _FormKey = GlobalKey<FormState>();
  String starRate = "";
  var fundContoller = TextEditingController();
  var otpController = TextEditingController();
  var otpSendedFlag = 0;
  var originalOTP = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(48, 208, 46, 237),
        title: Text("Funds"),
        titleSpacing: 1,
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ScreenRoutes.userPayMentAddFundScreen);
        },
        isExtended: true,
        child: Center(
          child: Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: Form(
            key: _FormKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: CustomSingleSelectField(
                        decoration: InputDecoration(
                          labelText: "Funds To...",
                          suffixIcon: Icon(Icons.calendar_view_day_outlined),
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontSize: 10),
                        ),
                        items: ["Donate To Lco", "Revoke Funds"],
                        validator: ((value) {
                          if (value!.isEmpty || value == null) {
                            return "Take Your Choice";
                          } else {
                            return null;
                          }
                        }),
                        onSelectionDone: (value) {
                          starRate = value;
                          print(starRate);
                        },
                        selectedItemColor: Color.fromARGB(255, 255, 0, 0),
                        title: 'Age',
                      )),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Enter Your Amount",
                        suffixIcon: Icon(Icons.money),
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 10),
                      ),
                      controller: fundContoller,
                      validator: ((value) {
                        if (value!.isEmpty || value == null) {
                          return "Enter the Amount.";
                        } else {
                          return null;
                        }
                      }),
                    ),
                  ),

                  if (otpSendedFlag == 0) ...[
                    ElevatedButton(
                        onPressed: () async {
                          if (_FormKey.currentState!.validate()) {
                            CircularIndicator.startCircularIndicator(context);

                            bool interNetConnectionFlag =
                                await InterNetConnectivityChecker
                                    .interNetConnectivityChecker();

                            if (interNetConnectionFlag == false) {
                              Toast.toastView(msg: "connect to network!!!");
                              Navigator.of(context).pop();
                              return;
                            }

                            var getOtp = await FbOtp.fbSaveOTP(
                                user_email: LoggedInDetails.userEmail);
                            print(
                                "your otp ========= ${getOtp["OTP"]} type == ${getOtp["OTP"].runtimeType}");
                            originalOTP = getOtp["OTP"].toString();
                            Navigator.of(context).pop();
                            otpSendedFlag = 1;
                            setState(() {});
                          }
                        },
                        child: Text("Get OTP")),
                  ],

                  // send the main
                  if (otpSendedFlag != 0) ...[
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Enter Your OTP",
                          suffixIcon: Icon(Icons.money),
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontSize: 10),
                        ),
                        controller: otpController,
                        validator: ((value) {
                          if (value!.isEmpty || value == null) {
                            return "Enter the OTP.";
                          } else {
                            return null;
                          }
                        }),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          print(
                              "lasteeee otp = ${originalOTP}    ${otpController.text} ");

                          if (_FormKey.currentState!.validate()) {
                            CircularIndicator.startCircularIndicator(context);

                            bool interNetConnectionFlag =
                                await InterNetConnectivityChecker
                                    .interNetConnectivityChecker();
                            print("last sendededede otp ==== ${originalOTP}");

                            if (interNetConnectionFlag == false) {
                              Toast.toastView(msg: "connect to network!!!");
                              Navigator.of(context).pop();
                              return;
                            }
                            print("internet connectivity test passed!!!!");
                            print("payment handler is called");

                            print(
                                "otp controller == ${otpController.text}  ${originalOTP} ");

                            if (otpController.text == originalOTP) {
                              if (starRate == "Donate To Lco") {
                                var paymentStatus =
                                    await FbPayMentAccount.fbDonateRevokeFunds(
                                        user_email: LoggedInDetails.userEmail,
                                        donate: true,
                                        funds: fundContoller.text);

                                if (paymentStatus["status"] == true) {
                                  Toast.toastView(msg: "Donated SuccessFuly");
                                  otpSendedFlag = 0;
                                  setState(() {
                                    originalOTP = "";
                                  });
                                } else {
                                  Toast.toastView(
                                      msg: "Oops Error Occured...!");
                                }
                              } else {
                                print("in else cadger");
                                var paymentStatus =
                                    await FbPayMentAccount.fbDonateRevokeFunds(
                                        user_email: LoggedInDetails.userEmail,
                                        donate: false,
                                        funds: fundContoller.text);

                                if (paymentStatus["status"] == true) {
                                  Toast.toastView(msg: "Revoked SuccessFuly");
                                  setState(() {});
                                } else {
                                  Toast.toastView(
                                      msg: "Oops Error Occured...!");
                                }
                              }
                            } else {
                              Toast.toastView(msg: "Enter Correct OTP");
                            }

                            Navigator.of(context).pop();
                          }
                        },
                        child: Text("Perform")),
                    ElevatedButton(
                        onPressed: () async {
                          otpSendedFlag = 0;
                          setState(() {});
                        },
                        child: Text("Resend OTP")),
                  ]
                ],
              ),
            )),
      ),
    );
  }
}
