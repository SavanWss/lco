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
      appBar: AppBar(
          shadowColor: Color.fromARGB(48, 208, 46, 237),
          title: Text("ad-request"),
          titleSpacing: 1,
          centerTitle: true,
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
