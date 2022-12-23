import 'package:flutter/material.dart';
import 'package:profile/profile.dart';

class PayMent2 extends StatefulWidget {
  const PayMent2({Key? key}) : super(key: key);

  @override
  State<PayMent2> createState() => _PayMent2State();
}

class _PayMent2State extends State<PayMent2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Profile(
            imageUrl: "https://images.unsplash.com/photo-1598618356794-eb1720430eb4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
            name: "Shamim Miah",
            website: "shamimmiah.com",
            designation: "Project Manager | Flutter & Blockchain Developer",
            email: "cse.shamimosmanpailot@gmail.com",
            phone_number: "01757736053",
          ),
        ));
  }
}
