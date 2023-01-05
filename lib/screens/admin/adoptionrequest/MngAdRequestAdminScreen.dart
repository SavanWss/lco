import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
import 'package:little_miracles_orphange/commonwidget/indicator/CircularIndicator.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetAdRequest.dart';

class MngAdRequestAdminScreen extends StatefulWidget {
  const MngAdRequestAdminScreen({Key? key}) : super(key: key);

  @override
  _MngAdRequestAdminScreenState createState() =>
      _MngAdRequestAdminScreenState();
}

class _MngAdRequestAdminScreenState extends State<MngAdRequestAdminScreen> {
  Widget buildSegment(String text) {
    return Container(
      child: Text(
        text,
        style:
            TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }

  getData() async {
    var data = await FbGetAdRequests.fbGetAdRequests();
    return data;
  }

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
                var data = snapshot.data as List<dynamic>;

                List pendingRequestList = [];
                List rejectedRequestList = [];
                List accepedRequestList = [];

                for (var i = 0; i < data.length; i++) {
                  switch (data[i]["request_status"]) {
                    case "Pending":
                      pendingRequestList.add(data[i]);
                      break;
                    case "Rejected":
                      rejectedRequestList.add(data[i]);
                      break;
                    case "Accepted":
                      accepedRequestList.add(data[i]);
                      break;
                    default:
                  }
                }

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

                      // pending requests
                      if (segmentFlag == 0) ...[
                        for (var i = 0; i < pendingRequestList.length; i++) ...[
                          Card(
                            child: new Container(
                              padding: new EdgeInsets.all(32.0),
                              color: Color.fromARGB(255, 255, 216, 87),
                              child: new Column(
                                children: <Widget>[
                                  new Text(
                                    '${pendingRequestList[i]["request_status"]}',
                                    softWrap: true,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        letterSpacing: 1,
                                        wordSpacing: 1,
                                        fontSize: 18),
                                  ),
                                  new Text(
                                    'your request under review',
                                    softWrap: true,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        letterSpacing: 1,
                                        wordSpacing: 1,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]
                      ],

                      // approved requests
                      if (segmentFlag == 1) ...[
                        for (var i = 0; i < accepedRequestList.length; i++) ...[
                          Card(
                            child: new Container(
                              padding: new EdgeInsets.all(32.0),
                              color: Color.fromARGB(133, 142, 227, 141),
                              child: new Column(
                                children: <Widget>[
                                  new Text(
                                    '${accepedRequestList[i]["request_status"]}',
                                    softWrap: true,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        letterSpacing: 1,
                                        wordSpacing: 1,
                                        fontSize: 18),
                                  ),
                                  new Text(
                                    '${(rejectedRequestList[i]["rejection_reason"] == "") ? "no reason" : rejectedRequestList[i]["rejection_reason"]}',
                                    softWrap: true,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        letterSpacing: 1,
                                        wordSpacing: 1,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]
                      ],

                      // rejected requests
                      if (segmentFlag == 2) ...[
                        for (var i = 0;
                            i < rejectedRequestList.length;
                            i++) ...[
                          Card(
                            child: new Container(
                              padding: new EdgeInsets.all(32.0),
                              color: Color.fromARGB(133, 171, 35, 35),
                              child: new Column(
                                children: <Widget>[
                                  new Text(
                                    '${rejectedRequestList[i]["request_status"]}',
                                    softWrap: true,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        letterSpacing: 1,
                                        wordSpacing: 1,
                                        fontSize: 18),
                                  ),
                                  new Text(
                                    '${(rejectedRequestList[i]["rejection_reason"] == "") ? "no reason" : rejectedRequestList[i]["rejection_reason"]}',
                                    softWrap: true,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        letterSpacing: 1,
                                        wordSpacing: 1,
                                        fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]
                      ]
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
