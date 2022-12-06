import 'package:flutter/material.dart';

import 'package:flutter_custom_selector/widget/flutter_single_select.dart';

import 'package:little_miracles_orphange/commonwidget/drawers/Toast.dart';

import 'package:little_miracles_orphange/services/firebase/FbSignUp.dart';

import 'package:little_miracles_orphange/services/validators/mobile_validator.dart';

import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _FormKey = GlobalKey<FormState>();

  // controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  final professionController = TextEditingController();
  final yearlyIncomeController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();

  var gender = "";
  var maritialStatus = "";

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    mobileController.dispose();
    professionController.dispose();
    yearlyIncomeController.dispose();
    passwordController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SignUpScreen oldWidget) {
    print("widget is updated");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/logo.png"), opacity: 0.5)),
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
                    labelText: "Name",
                    suffixIcon: Icon(Icons.manage_accounts),
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    errorStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0), fontSize: 10),
                  ),
                  controller: nameController,
                  validator: ((value) {
                    if (value!.isEmpty || value == null) {
                      return "Enter the Name";
                    } else {
                      return null;
                    }
                  }),
                ),
              ),

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

              // MOBILE text field
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Mobile",
                    suffixIcon: Icon(Icons.numbers),
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    errorStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0), fontSize: 10),
                  ),
                  controller: mobileController,
                  validator: ((value) {
                    if (value!.isEmpty || value == null) {
                      return "Enter the mobile number";
                    } else if (!MobileValidator.mobleValidator(
                        mobile_number: value)) {
                      return "Enter the Valid mobile number";
                    } else if (value.length != 10) {
                      return "mobile number must be 10 digits";
                    } else {
                      return null;
                    }
                  }),
                ),
              ),

              // address
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: "Address",
                    suffixIcon: Icon(Icons.numbers),
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    errorStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0), fontSize: 10),
                  ),
                  controller: addressController,
                  validator: ((value) {
                    if (value!.isEmpty || value == null) {
                      return "Enter the Address";
                    } else {
                      return null;
                    }
                  }),
                ),
              ),

              // profession text field
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Profession",
                    suffixIcon: Icon(Icons.local_post_office),
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    errorStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0), fontSize: 10),
                  ),
                  controller: professionController,
                  validator: ((value) {
                    if (value!.isEmpty || value == null) {
                      return "Enter the profession";
                    } else {
                      return null;
                    }
                  }),
                ),
              ),

              // yearly income
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "yearly Income",
                    suffixIcon: Icon(Icons.money),
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    errorStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0), fontSize: 10),
                  ),
                  controller: yearlyIncomeController,
                  validator: ((value) {
                    if (value!.isEmpty || value == null) {
                      return "Enter the Yearly income";
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
                        color: Color.fromARGB(255, 255, 0, 0), fontSize: 10),
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

              // password
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "password",
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

              // gender
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: CustomSingleSelectField(
                    decoration: InputDecoration(
                      labelText: "Gender",
                      suffixIcon: Icon(Icons.calendar_view_day_outlined),
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      errorStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 0, 0), fontSize: 10),
                    ),
                    initialValue: "Male",
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

              // maritial status
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: CustomSingleSelectField(
                    items: ["Married", "UnMarried", "Divorcee"],
                    decoration: InputDecoration(
                      labelText: "Maritial Status",
                      suffixIcon: Icon(Icons.calendar_view_day_outlined),
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      errorStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 0, 0), fontSize: 10),
                    ),
                    onSelectionDone: (value) {
                      maritialStatus = value;
                      print(maritialStatus);
                    },
                    validator: ((value) {
                      if (value!.isEmpty || value == null) {
                        return "Enter the Maritial Status";
                      } else {
                        return null;
                      }
                    }),
                    selectedItemColor: Color.fromARGB(255, 255, 0, 0),
                    title: 'Gender',
                  )),

              ElevatedButton(
                  onPressed: () async {
               
                    if (_FormKey.currentState!.validate()) {
       

                      var mainResponse = await FbSignUp.fbSignUp(
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                          mobile: mobileController.text,
                          gender: gender,
                          dob: dobController.text,
                          profession: professionController.text,
                          yearllyIncome: yearlyIncomeController.text,
                          address: addressController.text,
                          marriedStatus: maritialStatus);

                      print("mainResponse");
                      print(mainResponse);

                      print("firedata clicked");

                      if (mainResponse["status"] == false) {
                        Toast.toastView(msg: "SignUp Failed");
                        setState(() {});
                      } else {
                        Toast.toastView(msg: "SignUp Successfully");
                        Navigator.pushReplacementNamed(
                            context, ScreenRoutes.welcomeScreen);
                      }
                    }
                  },
                  child: Text("insertData"))
            ],
          ),
        ),
      ),
    ));
  }
}
