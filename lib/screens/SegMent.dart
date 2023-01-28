import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SegMent extends StatefulWidget {
  const SegMent({super.key});

  @override
  State<SegMent> createState() => _SegMentState();
}

class _SegMentState extends State<SegMent> {
  Widget buildSegment(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }

  var segmentFlag = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: [
            Positioned(
              top: 20,
              child: Center(
                child: CupertinoSlidingSegmentedControl(
                    backgroundColor:Color.fromRGBO(82, 21, 72, 1),
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

            if (segmentFlag == 0) ...[
              Positioned(
                top: 250,
                  child: Center(
                child: Text("payment screen"),
              ))
            ],

            if(segmentFlag == 1) ...[
              Positioned(
                top: 250,
                child: Center(
                child: Text("add things in donation"),
              ))
            ]

          ],
        ),
      ),
    );
  }
}
