import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/services/firebase/FbSignUp.dart';
import 'package:little_miracles_orphange/services/validators/mobile_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _FormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final professionController = TextEditingController();
  final yearlyIncomeController = TextEditingController();
  final dobController = TextEditingController();
  final passwordController = TextEditingController();

  var name = "";
  var email = "";
  var mobileNumber = "";
  var password = "";

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    professionController.dispose();
    yearlyIncomeController.dispose();
    passwordController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SignUp oldWidget) {
    print("widget is updated");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
                    } else if (!MobileValidator.mobleValidator(
                        mobile_number: value)) {
                      return "Enter the Valid mobile number";
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
                    labelText: "dob Income",
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
                      return "Enter the Yearly income";
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
                      return "Enter the adress";
                    } else {
                      return null;
                    }
                  }),
                ),
              ),

              //   Container(
              //     child: Column(
              //       children: [
              //         for(int i = 0; i < initialValueData.length; i++) ...[
              //            Text(initialValueData[i]),
              //            TextFormField(
              //              initialValue: initialValueData[i],
              //             )
              //          ],
              //       ],
              //     ),
              //   ),

              ElevatedButton(
                  onPressed: () async {
                    if (_FormKey.currentState!.validate()) {
                      name = nameController.text;
                      email = emailController.text;
                      password = passwordController.text;

                      print("main reasponse clicked");

                      var mainResponse = await FbSignUp.fbSignUp(
                          email: email,
                          password: password,
                          name: name,
                          mobile: mobileController.text,
                          gender: "gender",
                          dob: "dob",
                          profession: "profession",
                          yearllyIncome: "yearllyIncome",
                          address: "address",
                          marriedStatus: "marriedStatus");

                      print(mainResponse);

                      print("firedata clicked");
                      // await FirebaseFirestoreData.getAllData(collection: "student");

                      CollectionReference userData =
                          FirebaseFirestore.instance.collection("users");

                      print("collection reference === ${userData}");

                      var fireStoreResponse = await userData.add({
                        "address": "address",
                        "adopted_child": "0",
                        "dob": "13/11/2002",
                        "email": email,
                        "gender": "male",
                        "married_status": "true",
                        "mobile": "9898489400",
                        "name": "Savan Italiya",
                        "password": password,
                        "profession": "profession",
                        "role": "user",
                        "total_dnt_fund": 0,
                        "yearly_income": 0,
                      });
                      print("print firestore ====");
                      print(fireStoreResponse);
                      setState(() {
                        print(name);
                        print(email);
                        print(password);
                      });
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
