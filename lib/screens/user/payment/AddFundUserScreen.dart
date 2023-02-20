import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/UserDrawer.dart';
import 'package:little_miracles_orphange/commonwidget/indicator/CircularIndicator.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/services/connectivitychecker/InterNetConnectionChecker.dart';
import 'package:little_miracles_orphange/services/firebase/FbAddPayMent.dart';
import 'package:little_miracles_orphange/services/firebase/FbPayMentAccount.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';

class AddFundUserScreen extends StatefulWidget {
  const AddFundUserScreen({super.key});

  @override
  State<AddFundUserScreen> createState() => _AddFundUserScreenState();
}

class _AddFundUserScreenState extends State<AddFundUserScreen> {
  Future<String> getData() {
    return Future.delayed(Duration(seconds: 10), () {
      return "I am data";
      // throw Exception("Custom Error");
    });
  }

  @override
  Widget build(BuildContext context) {
    final _FormKey = GlobalKey<FormState>();

    var fundContoller = TextEditingController();

    return Scaffold(
        appBar: AppBar(
        shadowColor: Color.fromARGB(48, 208, 46, 237),
        title: Text("Funds"),
        titleSpacing: 1,
        centerTitle: true,
      ),
        drawer: UserDrawer(),
        body: SafeArea(
          child: Form(
              key: _FormKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    //  adoption reason
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                            print("internet connectivity test passed!!!!");
                            print("payment handler is called");
                            var paymentStatus = FbAddPayMent.fbAddPayMent(
                                user_email: LoggedInDetails.userEmail,
                                funds: fundContoller.text);
                            Navigator.of(context).pop();
                            setState(() {
                              Toast.toastView(msg: "FUnd Added Successfully...");
                            });
                          }
                        },
                        child: Text("Add Funds")),
                  ],
                ),
              )),
        ));
  }
}
