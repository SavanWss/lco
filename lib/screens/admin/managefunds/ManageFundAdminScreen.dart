import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
import 'package:little_miracles_orphange/commonwidget/indicator/CircularIndicator.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/services/connectivitychecker/InterNetConnectionChecker.dart';
import 'package:little_miracles_orphange/services/firebase/FbFundUsageByLCO.dart';

class ManageFundAdminScreen extends StatefulWidget {
  const ManageFundAdminScreen({super.key});

  @override
  State<ManageFundAdminScreen> createState() => _ManageFundAdminScreenState();
}

class _ManageFundAdminScreenState extends State<ManageFundAdminScreen> {
  @override
  Widget build(BuildContext context) {
    final _FormKey = GlobalKey<FormState>();

    var fundContoller = TextEditingController();
    var descController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          shadowColor: Color.fromARGB(48, 208, 46, 237),
          title: Text("Funds"),
          titleSpacing: 1,
          centerTitle: true,
        ),
        drawer: AdminDrawer(),
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
                        keyboardType: TextInputType.number,
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

                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Describe the use Fund",
                          suffixIcon: Icon(Icons.money),
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontSize: 10),
                        ),
                        controller: descController,
                        validator: ((value) {
                          if (value!.isEmpty || value == null) {
                            return "Enter the Description.";
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

                            var fireBaseResult =
                                await FbFundUsageByLCO.fbFundUsageByLCO(
                                    description: descController.text,
                                    funds: fundContoller.text);

                            if (fireBaseResult["status"] == true) {
                              CircularIndicator.stopCircularIndicator(context);
                              Toast.toastView(msg: "fund Revoked SuccessFully");
                              setState(() {
                                fundContoller.text = "";
                                descController.text = "";
                              });
                            } else {
                              CircularIndicator.stopCircularIndicator(context);
                              Toast.toastView(msg: "${fireBaseResult["error"]}");
                            }


                          }
                        },
                        child: Text("Add Funds")),
                  ],
                ),
              )),
        ));
  }
}
