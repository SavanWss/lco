// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison
import 'package:flutter/material.dart';

import 'package:little_miracles_orphange/commonwidget/indicator/CircularIndicator.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';

import 'package:little_miracles_orphange/services/connectivitychecker/InterNetConnectionChecker.dart';
import 'package:little_miracles_orphange/services/datastorerinutils/LogInDataSaver.dart';
import 'package:little_miracles_orphange/services/firebase/FbSignIn.dart';
import 'package:little_miracles_orphange/services/notification/Notifications.dart';

import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';
import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _FormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SignInScreen oldWidget) {
    print("widget is updated");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "Welcome\nBack",
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Column(children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Color(0xff4c505b),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          print("button is pressed");

                          CircularIndicator.startCircularIndicator(context);

                          bool interNetConnectionFlag =
                              await InterNetConnectivityChecker
                                  .interNetConnectivityChecker();
                          print(interNetConnectionFlag);
                          if (interNetConnectionFlag == false) {
                            Toast.toastView(msg: "connect to network!!!");
                            Navigator.of(context).pop();
                            return;
                          }
print("email ===== ${emailController.text}");
print("password ===== ${passwordController.text}");
                          // signin method is called
                          var login = await FbSignIn.fbSignIn(
                              email: emailController.text,
                              password: passwordController.text);

                          //  login validation
                          print("login === $login");
                          if (login["status"] == true) {
                            var userData = login["data"][0];
                            if (userData["profession"] == null ||
                                userData["married_status"] == null ||
                                userData["yearly_income"] == null) {
                              userData["profession"] =
                                  userData["married_status"] = "";
                              userData["yearly_income"] = 0;
                            }

                            LogInDataSaver.logInDataSave(
                                name: userData["name"],
                                mobile: userData["mobile"],
                                email: userData["email"],
                                dob: userData["dob"],
                                role: userData["role"],
                                gender: userData["gender"],
                                address: userData["address"],
                                profession: userData["profession"],
                                totaldonatedfund: userData["total_dnt_fund"],
                                adoptedchild: userData["adopted_child"],
                                yearlyincome: 0,
                                marriedstatus: userData["married_status"]);

                            if (LoggedInDetails.userRole == "user") {
                              Navigator.pushReplacementNamed(
                                  context, ScreenRoutes.userDashboardScreen);
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, ScreenRoutes.adminDashboardScreen);
                            }
                          } else {
                            // Toast View
                            Toast.toastView(msg: "login Failed");
                            Navigator.of(context).pop();
                          }
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          print("button is pressed signUp");
                          Navigator.pushNamed(
                              context, ScreenRoutes.signUpScreen);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Color(0xff4c505b),
                          ),
                        ),
                      ),
             
                    ]),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}








//   ElevatedButton(
              //     onPressed: () async {
              //       print("button is pressed");
              //       if (_FormKey.currentState!.validate()) {
              //         CircularIndicator.startCircularIndicator(context);

              //         bool interNetConnectionFlag =
              //             await InterNetConnectivityChecker
              //                 .interNetConnectivityChecker();
              //         print(interNetConnectionFlag);
              //         if (interNetConnectionFlag == false) {
              //           Toast.toastView(msg: "connect to network!!!");
              //           Navigator.of(context).pop();
              //           return;
              //         }

              //         // signin method is called
              //         var login = await FbSignIn.fbSignIn(
              //             email: emailController.text,
              //             password: passwordController.text);

              //         //  login validation
              //         print("login === $login");
              //         if (login["status"] == true) {
              //           var userData = login["data"][0];
              //           if (userData["profession"] == null || userData["married_status"] == null || userData["yearly_income"] == null) {
              //           userData["profession"] = userData["married_status"] = "";
              //           userData["yearly_income"] = 0;

              //           }

                   

              //           LogInDataSaver.logInDataSave(
              //               name: userData["name"],
              //               mobile: userData["mobile"],
              //               email: userData["email"],
              //               dob: userData["dob"],
              //               role: userData["role"],
              //               gender: userData["gender"],
              //               address: userData["address"],
              //               profession: userData["profession"],
              //               totaldonatedfund: userData["total_dnt_fund"],
              //               adoptedchild: userData["adopted_child"],
              //               yearlyincome: 0,
              //               marriedstatus: userData["married_status"]);

              //           if (LoggedInDetails.userRole == "user") {
              //             Navigator.pushReplacementNamed(
              //                 context, ScreenRoutes.userDashboardScreen);
              //           } else {
              //             Navigator.pushReplacementNamed(
              //                 context, ScreenRoutes.adminDashboardScreen);
              //           }
              //         } else {
              //           // Toast View
              //           Toast.toastView(msg: "login Failed");
              //           Navigator.of(context).pop();
              //         }
              //       }
              //     },
              //     child: Text("SignIn")),

              // Center(
              //   child: Text(
              //     "or",
              //     style: TextStyle(
              //         color: Color.fromRGBO(82, 21, 72, 1), fontSize: 15),
              //   ),
              // ),

              // // SignUp Button
              // ElevatedButton(
              //     onPressed: () async {
              //       print("button is pressed signUp");
              //       Navigator.pushNamed(context, ScreenRoutes.signUpScreen);

              //       var afterResponse = await Notifications.sendNotification(
              //           deviceToken:
              //               "dOrRN-smSPeObaHZ2TdDcL:APA91bH1H7aKKxxMViBLnrDXRifXDnwltqFrA1Hztt1XkOVUtDN8iM39OyWCNhOwU80S5u1CZZX3pGo39hV7xJYPOSWAbzcHWU4zVhvcAkHcNKgINvePKuWeku86tfm3NM1KkVDG4hVO",
              //           title: "first from application",
              //           body: "body");

              //       print(afterResponse);
              //     },
              //     child: Text("SignUp")),
