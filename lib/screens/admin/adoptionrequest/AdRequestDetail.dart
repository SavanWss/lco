import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
import 'package:little_miracles_orphange/commonwidget/indicator/CircularIndicator.dart';

class AdRequestDetail extends StatefulWidget {
  const AdRequestDetail({Key? key}) : super(key: key);

  @override
  _AdRequestDetailState createState() => _AdRequestDetailState();
}

class _AdRequestDetailState extends State<AdRequestDetail> {
  Widget buildSegment(String text) {
    return Container(
      child: Text(
        text,
        style:
            TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }

  getData() {}

  var segmentFlag = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Color.fromARGB(48, 208, 46, 237),
          title: Text("ad-request"),
          titleSpacing: 1,
          centerTitle: true,
        ),
        drawer: AdminDrawer(),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                return SafeArea(
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
                      0: buildSegment("Pending"),
                      1: buildSegment("Approved"),
                      2: buildSegment("Rejecting")
                    },
                    onValueChanged: (value) {
                      setState(() {
                        segmentFlag = value!;
                        print("segment flag == $value");
                      });
                    }),
              ),
            ),
            if (segmentFlag == 0) ...[
              Center(
                child: Text(""),
              )
            ],
            if (segmentFlag == 1) ...[],
          ],
        ),
      ));
              }
            }
            return Center(
              child: CircularIndicator.startCircularIndicator(context),
            );
          },
          future: getData(),
        ));
  }
}
