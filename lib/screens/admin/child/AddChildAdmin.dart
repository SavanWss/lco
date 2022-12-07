// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/services/firebase/FbAddChild.dart';

class AddChildAdmin extends StatefulWidget {
  const AddChildAdmin({super.key});

  @override
  State<AddChildAdmin> createState() => _AddChildAdminState();
}

class _AddChildAdminState extends State<AddChildAdmin> {
  final _FormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final entranceDateController = TextEditingController();
  final guidanceNameController = TextEditingController();
  final healthDescriberController = TextEditingController();

  var gender = "";
  var adoptionStatus = "";
  var healthStatus = "Fit";

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    entranceDateController.dispose();
    guidanceNameController.dispose();
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
                  // name text field
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "name",
                        suffixIcon: Icon(Icons.email),
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 10),
                      ),
                      controller: nameController,
                      validator: ((value) {
                        if (value!.isEmpty || value == null) {
                          return "Enter the name";
                        } else {
                          return null;
                        }
                      }),
                    ),
                  ),

                  // date of birth
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: "dob",
                        suffixIcon: Icon(Icons.calendar_view_day_outlined),
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 10),
                      ),
                      controller: dobController,
                      validator: ((value) {
                        if (value!.isEmpty || value == null) {
                          return "Enter the DOB";
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
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: "entrance date",
                        suffixIcon: Icon(Icons.calendar_view_day_outlined),
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 10),
                      ),
                      controller: entranceDateController,
                      validator: ((value) {
                        if (value!.isEmpty || value == null) {
                          return "Enter the DOB";
                        } else {
                          return null;
                        }
                      }),
                    ),
                  ),

                  // gender
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: CustomSingleSelectField(
                        decoration: InputDecoration(
                          labelText: "Gender",
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
                          gender = value;
                          print(gender);
                        },
                        selectedItemColor: Color.fromARGB(255, 255, 0, 0),
                        title: 'Gender',
                      )),

                  // adoption validatior
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: CustomSingleSelectField(
                        decoration: InputDecoration(
                          labelText: "is Adopted???",
                          suffixIcon: Icon(Icons.calendar_view_day_outlined),
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontSize: 10),
                        ),
                        items: ["Yes", "No"],
                        validator: ((value) {
                          if (value!.isEmpty || value == null) {
                            return "Enter the Adoption status";
                          } else {
                            return null;
                          }
                        }),
                        onSelectionDone: (value) {
                          adoptionStatus = value;
                          print(adoptionStatus);
                        },
                        selectedItemColor: Color.fromARGB(255, 255, 0, 0),
                        title: 'Adoption Status',
                      )),

                  // guidance name text field
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "guidance Name",
                        suffixIcon: Icon(Icons.email),
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 10),
                      ),
                      controller: guidanceNameController,
                      validator: ((value) {
                        if (value!.isEmpty || value == null) {
                          return "Enter the guidance name";
                        } else {
                          return null;
                        }
                      }),
                    ),
                  ),

                  // mental health issue type
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: CustomSingleSelectField(
                        decoration: InputDecoration(
                          labelText: "Medical Issue Type",
                          suffixIcon: Icon(Icons.calendar_view_day_outlined),
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontSize: 10),
                        ),
                        items: ["Fit", "Mental", "Physical"],
                        validator: ((value) {
                          if (value!.isEmpty || value == null) {
                            return "Enter the Health Type";
                          } else {
                            return null;
                          }
                        }),
                        onSelectionDone: (value) {
                          healthStatus = value;
                          print(healthStatus);
                          setState(() {
                            healthDescriberController.text = "";
                          });
                        },
                        selectedItemColor: Color.fromARGB(255, 255, 0, 0),
                        title: 'Health Type',
                      )),

                  if (healthStatus != "Fit") ...[
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Health Description",
                          suffixIcon: Icon(Icons.email),
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontSize: 10),
                        ),
                        controller: healthDescriberController,
                        validator: ((value) {
                          if (value!.isEmpty || value == null) {
                            return "Enter the Heath description";
                          } else {
                            return null;
                          }
                        }),
                      ),
                    ),
                  ],

                  ElevatedButton(
                      onPressed: () async {
                        print("object");
                        if (_FormKey.currentState!.validate()) {
                          print("form is validated");
                          var response = await FbAddChild.fbAddChild(name: nameController.text, dob: dobController.text, entrancedate: entranceDateController.text, gender: gender, adoptedstatus: adoptionStatus, guidancename: guidanceNameController.text, medicalstatus: healthStatus, medicalstatusdescription: healthDescriberController.text);
                          // ignore: unnecessary_brace_in_string_interps
                          print("response in add child ${response}");

                          if (response["status"] == true) {
                            Toast.toastView(msg: "Child Added SuccessFully");
                            Navigator.pop(context);
                          } else {
                            Toast.toastView(msg: "failed");
                          }

                        }
                      },
                      child: Text("add Child"))
                ],
              ),
            ),
          ),
        )

        // drawer: AdminDrawer(),
        );
  }
}
