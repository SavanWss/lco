// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:little_miracles_orphange/commonwidget/indicator/CircularIndicator.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/services/connectivitychecker/InterNetConnectionChecker.dart';
import 'package:little_miracles_orphange/services/firebase/FbAddAdRequests.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';

class AdoptChildFormUserScreen extends StatefulWidget {
  const AdoptChildFormUserScreen({Key? key}) : super(key: key);

  @override
  _AdoptChildFormUserScreenState createState() =>
      _AdoptChildFormUserScreenState();
}

class _AdoptChildFormUserScreenState extends State<AdoptChildFormUserScreen> {
  final _FormKey = GlobalKey<FormState>();

  var adDesController = TextEditingController();

  var preferredAge = "0-5";
  var preferredGender = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(48, 208, 46, 237),
        title: Text("Adopt-Child"),
        titleSpacing: 1,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
            key: _FormKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  //  adoption reason
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Reason to Adoption",
                        suffixIcon: Icon(Icons.manage_accounts),
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 10),
                      ),
                      controller: adDesController,
                      validator: ((value) {
                        if (value!.isEmpty || value == null) {
                          return "Enter the Name";
                        } else {
                          return null;
                        }
                      }),
                    ),
                  ),

                  // adoption gender preference
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: CustomSingleSelectField(
                        decoration: InputDecoration(
                          labelText: "preferred Gender",
                          suffixIcon: Icon(Icons.calendar_view_day_outlined),
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontSize: 10),
                        ),
                        items: ["Male", "Female", "Other"],
                        validator: ((value) {
                          if (value!.isEmpty || value == null) {
                            return "Enter the Gender";
                          } else {
                            return null;
                          }
                        }),
                        onSelectionDone: (value) {
                          preferredGender = value;
                          print(preferredGender);
                        },
                        selectedItemColor: Color.fromARGB(255, 255, 0, 0),
                        title: 'Gender',
                      )),

                  // adoption age preference
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: CustomSingleSelectField(
                        decoration: InputDecoration(
                          labelText: "preferred Age",
                          suffixIcon: Icon(Icons.calendar_view_day_outlined),
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontSize: 10),
                        ),
                        items: ["0-5", "5-10", "10-15", "15-18"],
                        validator: ((value) {
                          if (value!.isEmpty || value == null) {
                            return "Enter the Age";
                          } else {
                            return null;
                          }
                        }),
                        onSelectionDone: (value) {
                          preferredAge = value;
                          print(preferredAge);
                        },
                        selectedItemColor: Color.fromARGB(255, 255, 0, 0),
                        title: 'Age',
                      )),

                  // adopt child button
                  ElevatedButton(
                      onPressed: () async {
                        print("button is pressed");
                        if (_FormKey.currentState!.validate()) {
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

                          var responseOfAdDetail =
                              await FbAddAdRequests.fbAddAdRequests(
                                  description: adDesController.text,
                                  agepreference: preferredAge,
                                  genderpreference: preferredGender,
                                  username: LoggedInDetails.userName,
                                  useremail: LoggedInDetails.userEmail);

                          if (responseOfAdDetail["status"] == true) {
                            CircularIndicator.stopCircularIndicator(context);
                            Toast.toastView(
                                msg: "adoption request sended successfully");
                            Navigator.pop(context);
                          } else {
                            CircularIndicator.stopCircularIndicator(context);
                            Toast.toastView(
                                msg: "adoption request failed");
                          }
                        }
                      },
                      child: Text("SignIn")),
                ],
              ),
            )),
      ),
    );
  }
}
