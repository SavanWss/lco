// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/indicator/CircularIndicator.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/services/connectivitychecker/InterNetConnectionChecker.dart';
import 'package:little_miracles_orphange/services/firebase/FbAddNotice.dart';

class AddNoticeAdminScreen extends StatefulWidget {
  const AddNoticeAdminScreen({Key? key}) : super(key: key);

  @override
  _AddNoticeAdminScreenState createState() => _AddNoticeAdminScreenState();
}

class _AddNoticeAdminScreenState extends State<AddNoticeAdminScreen> {
  final _FormKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();
  final eventDataTimeController = TextEditingController();
  final eventModeController = TextEditingController();
  final eventTitleController = TextEditingController();
  final eventTopicController = TextEditingController();
  final eventOrganizeController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    eventDataTimeController.dispose();
    eventModeController.dispose();
    eventTitleController.dispose();
    eventTopicController.dispose();
    eventOrganizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Color.fromARGB(48, 208, 46, 237),
          title: Text("Add Child"),
          titleSpacing: 1,
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"), opacity: 0.6)),
          child: Form(
            key: _FormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Event Title",
                        suffixIcon: Icon(Icons.email),
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 10),
                      ),
                      controller: eventTitleController,
                      validator: ((value) {
                        if (value!.isEmpty || value == null) {
                          return "Enter the Event Title";
                        } else {
                          return null;
                        }
                      }),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Event Topic",
                        suffixIcon: Icon(Icons.email),
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 10),
                      ),
                      controller: eventTopicController,
                      validator: ((value) {
                        if (value!.isEmpty || value == null) {
                          return "Enter the Event Topic";
                        } else {
                          return null;
                        }
                      }),
                    ),
                  ),
                  //  text field
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "description",
                        suffixIcon: Icon(Icons.email),
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 10),
                      ),
                      controller: descriptionController,
                      validator: ((value) {
                        if (value!.isEmpty || value == null) {
                          return "Enter the description";
                        } else {
                          return null;
                        }
                      }),
                    ),
                  ),

                  //
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: "Event Date And Time",
                        suffixIcon: Icon(Icons.calendar_view_day_outlined),
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 10),
                      ),
                      controller: eventDataTimeController,
                      validator: ((value) {
                        if (value!.isEmpty || value == null) {
                          return "Enter the Date And Time Of Event";
                        } else {
                          return null;
                        }
                      }),
                    ),
                  ),

                  // entrance date
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Event Mode",
                        suffixIcon: Icon(Icons.calendar_view_day_outlined),
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 10),
                      ),
                      controller: eventModeController,
                      validator: ((value) {
                        if (value!.isEmpty || value == null) {
                          return "Enter the Event Mode";
                        } else {
                          return null;
                        }
                      }),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Event Organized By",
                        suffixIcon: Icon(Icons.email),
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 10),
                      ),
                      controller: eventOrganizeController,
                      validator: ((value) {
                        if (value!.isEmpty || value == null) {
                          return "Enter the Name Of Organizer";
                        } else {
                          return null;
                        }
                      }),
                    ),
                  ),

                  ElevatedButton(
                      onPressed: () async {
                        print("object");

                        bool interNetConnectionFlag = await InterNetConnectivityChecker.interNetConnectivityChecker();

                        if (interNetConnectionFlag == false) {
                          Toast.toastView(msg: "connect to network!!!");
                          Navigator.of(context).pop();
                          return;
                        }


                        if (_FormKey.currentState!.validate()) {
                          print("form is validated");
                          CircularIndicator.startCircularIndicator(context);
                          var response = await FbAddNotice.fbAddNotice(
                              event_title: eventTitleController.text,
                              event_topic: eventTopicController.text,
                              description: descriptionController.text,
                              event_date_time: eventDataTimeController.text,
                              event_mode: eventModeController.text,
                              event_organize: eventOrganizeController.text);
                          // ignore: unnecessary_brace_in_string_interps

                          if (response["status"] == true) {
                            Toast.toastView(msg: "Notice Added SuccessFully");
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            Toast.toastView(msg: "failed");
                          }
                        }
                      },
                      child: Text("Add Notice"))
                ],
              ),
            ),
          ),
        )

        // drawer: AdminDrawer(),
        );
  }
}
