// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';

import 'package:emailjs/emailjs.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';

class FeedBackUserScreen extends StatefulWidget {
  const FeedBackUserScreen({super.key});

  @override
  State<FeedBackUserScreen> createState() => _FeedBackUserScreenState();
}

class _FeedBackUserScreenState extends State<FeedBackUserScreen> {
  // final _ColumnKey = GlobalKey<ColumnState>();
  @override
  Widget build(BuildContext context) {
    final _FormKey = GlobalKey<FormState>();
    String starRate = "";
    var feedBackContoller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(48, 208, 46, 237),
        title: Text("FeedBack"),
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
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: CustomSingleSelectField(
                        decoration: InputDecoration(
                          labelText: "Gives the star",
                          suffixIcon: Icon(Icons.calendar_view_day_outlined),
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontSize: 10),
                        ),
                        items: ["5", "4", "3", "2", "1"],
                        validator: ((value) {
                          if (value!.isEmpty || value == null) {
                            return "Enter the Age";
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
                        labelText: "Write Your FeedBack",
                        suffixIcon: Icon(Icons.manage_accounts),
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 10),
                      ),
                      controller: feedBackContoller,
                      validator: ((value) {
                        if (value!.isEmpty || value == null) {
                          return "Enter the FeedBack.";
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
                          Map<String, dynamic> templateParams = {
                            "user_name": LoggedInDetails.userName,
                            "feedback_msg": feedBackContoller.text,
                          };

                          try {
                            await EmailJS.send(
                              'service_xv8jdhm',
                              'template_tj8grod',
                              templateParams,
                              const Options(
                                publicKey: 'HPzTaBZDBjd1DvCX2',
                                privateKey: 'A3lGefnD4Xmi6K6LbhPJ1',
                              ),
                            );
                            Toast.toastView(msg: "your feedback sended");
                            setState(() {
                              feedBackContoller.text = "";
                            });
                            Navigator.pop(context);
                            print('SUCCESS!');
                          } catch (error) {
                            print(error.toString());
                          }
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
