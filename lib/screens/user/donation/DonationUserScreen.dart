// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/UserDrawer.dart';
import 'package:little_miracles_orphange/commonwidget/indicator/CircularIndicator.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/services/firebase/FbDonateThings.dart';

class DonatioonUserScreen extends StatefulWidget {
  const DonatioonUserScreen({super.key});

  @override
  State<DonatioonUserScreen> createState() => _DonatioonUserScreenState();
}

class _DonatioonUserScreenState extends State<DonatioonUserScreen> {
  Widget buildSegment(String text) {
    return Container(
      child: Text(
        text,
        style:
            TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }

  final _FormKeyThings = GlobalKey<FormState>();

  final thingsController = TextEditingController();
  final quantityController = TextEditingController();

  var category = "";

  @override
  void dispose() {
    thingsController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DonatioonUserScreen oldWidget) {
    print("widget is updated");
    super.didUpdateWidget(oldWidget);
  }

  var segmentFlag = 0;
  Size wsize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(48, 208, 46, 237),
        title: Text("Donation"),
        titleSpacing: 1,
        centerTitle: true,
      ),
      drawer: UserDrawer(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: CupertinoSlidingSegmentedControl(
                    backgroundColor: Color.fromRGBO(82, 21, 72, 1),
                    thumbColor: Color.fromARGB(224, 175, 146, 175),
                    padding: EdgeInsets.all(8),
                    groupValue: segmentFlag,
                    children: {
                      0: buildSegment("Add Fund"),
                      1: buildSegment("Add Things")
                    },
                    onValueChanged: (value) {
                      setState(() {
                        segmentFlag = value!;
                        print("segment flag == $value");
                      });
                    }),
              ),
            ),
            if (segmentFlag == 0) ...[],
            if (segmentFlag == 1) ...[
              Padding(
                padding: EdgeInsets.only(top: 70),
                child: Form(
                  key: _FormKeyThings,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          // category add

                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: CustomSingleSelectField(
                                decoration: InputDecoration(
                                  labelText: "Category",
                                  suffixIcon:
                                      Icon(Icons.calendar_view_day_outlined),
                                  labelStyle: TextStyle(fontSize: 15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  errorStyle: TextStyle(
                                      color: Color.fromARGB(255, 255, 0, 0),
                                      fontSize: 10),
                                ),
                                items: ["Cloths", "Stationary"],
                                validator: ((value) {
                                  if (value!.isEmpty || value == null) {
                                    return "Enter the Things";
                                  } else {
                                    return null;
                                  }
                                }),
                                onSelectionDone: (value) {
                                  category = value;
                                  print(category);
                                },
                                selectedItemColor:
                                    Color.fromARGB(255, 255, 0, 0),
                                title: 'Gender Of The Child',
                              )),

                          // item name
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: TextFormField(
                              autofocus: false,
                              // keyboardType: TextInputType.reason,
                              decoration: InputDecoration(
                                labelText: "Name Of Items",
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    fontSize: 10),
                              ),
                              controller: thingsController,
                              validator: ((value) {
                                if (value!.isEmpty || value == null) {
                                  return "Enter the Name of items";
                                } else {
                                  return null;
                                }
                              }),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: TextFormField(
                              autofocus: false,
                              // keyboardType: TextInputType.reason,
                              decoration: InputDecoration(
                                labelText: "Add Quantity Of Items",
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    fontSize: 10),
                              ),
                              controller: quantityController,
                              validator: ((value) {
                                if (value!.isEmpty || value == null) {
                                  return "Enter Quantity Of Items";
                                } else {
                                  return null;
                                }
                              }),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                print("object");
                                if (_FormKeyThings.currentState!.validate()) {
                                  CircularIndicator.startCircularIndicator(
                                      context);
                                  print("form is validated");
                                  var response =
                                      await FbDonateThings.fbDonateThings(
                                          category: category,
                                          things: thingsController.text,
                                          quantity: quantityController.text);

                                  if (response["status"] == true) {
                                    Toast.toastView(
                                        msg: "Donation Add Successfully");

                                    Navigator.pop(context);
                                    setState(() {
                                      thingsController.text = "";
                                      quantityController.text = "";
                                    });
                                  } else {
                                    Toast.toastView(msg: "failed");
                                  }
                                }
                              },
                              child: Text("Donate"))
                        ]),
                  ),
                ),
              )
            ],
          ],
        ),
      )),
    );
  }
}




/*

               child: CupertinoSlidingSegmentedControl(
                    backgroundColor: Color.fromRGBO(82, 21, 72, 1),
                    thumbColor: Color.fromARGB(224, 175, 146, 175),
                    padding: EdgeInsets.all(8),
                    groupValue: segmentFlag,
                    children: {
                      0: buildSegment("Add Fund"),
                      1: buildSegment("Add Things")
                    },
                    onValueChanged: (value) {
                      setState(() {
                        segmentFlag = value!;
                        print("segment flag == $value");
                      });
                    }),

*/