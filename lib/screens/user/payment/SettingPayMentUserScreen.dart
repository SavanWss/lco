import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:little_miracles_orphange/commonwidget/indicator/CircularIndicator.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/services/connectivitychecker/InterNetConnectionChecker.dart';
import 'package:little_miracles_orphange/services/firebase/FbPayMentAccount.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(48, 208, 46, 237),
        title: Text("FeedBack"),
        titleSpacing: 1,
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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

                  //  adoption reason
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

                  // send the main
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
                        
                        var paymentStatus = FbPayMentAccount.fbDonateRevokeFunds(user_email: LoggedInDetails.userEmail, donate: true,funds: fundContoller);

                        }
                      },
                      child: Text("Send FeedBack")),
                ],
              ),
            )),
      ),
    );
  }
}
