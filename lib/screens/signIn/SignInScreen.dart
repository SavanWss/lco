import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/Toast.dart';

import 'package:little_miracles_orphange/services/firebase/FbSignIn.dart';

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
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/logo.png"))),
      child: Form(
        key: _FormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ListView(
            children: [
              // email text field
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    suffixIcon: Icon(Icons.email),
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    errorStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0), fontSize: 10),
                  ),
                  controller: emailController,
                  validator: ((value) {
                    if (value!.isEmpty || value == null) {
                      return "Enter the Email";
                    } else if (!value.contains("@")) {
                      return "Enter the Valid Email";
                    } else {
                      return null;
                    }
                  }),
                ),
              ),

              // password text field
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "password Income",
                    suffixIcon: Icon(Icons.calendar_view_day_outlined),
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    errorStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0), fontSize: 10),
                  ),
                  controller: passwordController,
                  validator: ((value) {
                    if (value!.isEmpty || value == null) {
                      return "Enter the password";
                    } else {
                      return null;
                    }
                  }),
                ),
              ),

            // SignIn Button
              ElevatedButton(
                  onPressed: () async {

                    if (_FormKey.currentState!.validate()) {
                      // signin method is called
                      var login = await FbSignIn.fbSignIn(
                          email: emailController.text,
                          password: passwordController.text);

                      //  login validation
                      if (login["status"] == true) {
                        Navigator.pushReplacementNamed(
                            context, ScreenRoutes.welcomeScreen);
                      } else {
                        setState(() {
                          // Toast View
                          Toast.toastView(msg: "login Failed");
                        });
                      }
                    }
                  },
                  child: Text("SignIn")),

              Center(
                child: Text(
                  "or",
                  style: TextStyle(
                      color: Color.fromRGBO(82, 21, 72, 1), fontSize: 15),
                ),
              ),

              // SignUp Button
              ElevatedButton(
                  onPressed: () async {
                    print("button is pressed");
                    Navigator.pushNamed(context, ScreenRoutes.signUpScreen);
                  },
                  child: Text("SignUp")),
            ],
          ),
        ),
      ),
    ));
  }
}
