import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class ADrequestHandledAdminScreenDart extends StatefulWidget {
  const ADrequestHandledAdminScreenDart({Key? key}) : super(key: key);

  @override
  _ADrequestHandledAdminScreenDartState createState() =>
      _ADrequestHandledAdminScreenDartState();
}

class _ADrequestHandledAdminScreenDartState
    extends State<ADrequestHandledAdminScreenDart> {
  @override
  Widget build(BuildContext context) {
    var switchFlag = true;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Switch(value: switchFlag, onChanged: ((value) {
            // setState(() {
              // if (switchFlag == true) {
              //   switchFlag = false;
              // } else {
              //   switchFlag = true;
              // }
            // });
          })),

          if(switchFlag) ...[
            Center(
              child: Text("true"),
            )
          ],

          if(!switchFlag) ...[
            Center(
              child: Text("False"),
            )
          ]

        ],
      )),
    );
  }
}
