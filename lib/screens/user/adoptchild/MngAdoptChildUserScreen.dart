// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/UserDrawer.dart';
import 'package:little_miracles_orphange/commonwidget/indicator/CircularIndicator.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetAdRequest.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';
import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class MngAdoptChildUserScreen extends StatefulWidget {
  const MngAdoptChildUserScreen({Key? key}) : super(key: key);

  @override
  _MngAdoptChildUserScreenState createState() =>
      _MngAdoptChildUserScreenState();
}

class _MngAdoptChildUserScreenState extends State<MngAdoptChildUserScreen> {
  getData() async {
    var data = await FbGetAdRequests.fbGetAdRequestsByUserName(
        useremail: LoggedInDetails.userEmail);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Color.fromARGB(48, 208, 46, 237),
          title: Text("Adoption"),
          titleSpacing: 1,
          centerTitle: true,
        ),
        drawer: UserDrawer(),
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
                List data = snapshot.data as List<dynamic>;
                print("your data == $data");

                List pendingRequestList = [];
                List rejectedRequestList = [];

                for (var i = 0; i < data.length; i++) {
                  if (data[i]["request_status"] == "Pending") {
                    pendingRequestList.add(data[i]);
                  }
                }

                for (var i = 0; i < data.length; i++) {
                  if (data[i]["request_status"] == "Rejected") {
                    rejectedRequestList.add(data[i]);
                  }
                }

                return RefreshIndicator(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              child: Column(
                            children: [
                              Padding(padding: EdgeInsets.all(25)),
                              Text(
                                "your Pending Request",
                                style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1,
                                  color: Color.fromRGBO(82, 21, 72, 1),
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(15)),
                              if (pendingRequestList.length == 0) ...[
                                GestureDetector(
                                  child: Card(
                                    child: new Container(
                                      color: Color.fromARGB(255, 0, 145, 234),
                                      padding: new EdgeInsets.all(32.0),
                                      child: new Column(
                                        children: <Widget>[
                                          new Text(
                                            'Nothing Pending Request',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                letterSpacing: 1,
                                                wordSpacing: 1,
                                                fontSize: 18),
                                          ),
                                          new Text(
                                            'can you Adopt one????',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                letterSpacing: 1,
                                                wordSpacing: 1,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    print("button is tapped");
                                    CircularIndicator.startCircularIndicator(context);
                                    var adRequest = await FbGetAdRequests
                                        .fgGetAdRequestAccordingStatus(
                                            useremail:
                                                LoggedInDetails.userEmail,
                                            requestStatus: "Pending");

                                    print(
                                        "your ad request on button tap == $adRequest");

                                    if (adRequest.length == 0) {
                                      print("in if fff");
                                      Navigator.popAndPushNamed(
                                          context,
                                          ScreenRoutes
                                              .userAdoptChildFormScreen);
                                    } else {
                                      Toast.toastView(
                                          msg:
                                              "your old request is in under review");
                                      setState(() {
                                        CircularIndicator.stopCircularIndicator(context);
                                      });
                                    }
                                  },
                                )
                              ],
                              if (pendingRequestList.length != 0) ...[
                                GestureDetector(
                                  child: Card(
                                    child: new Container(
                                      padding: new EdgeInsets.all(32.0),
                                      color: Color.fromARGB(255, 255, 216, 87),
                                      child: new Column(
                                        children: <Widget>[
                                          new Text(
                                            '${data[0]["request_status"]}',
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                letterSpacing: 1,
                                                wordSpacing: 1,
                                                fontSize: 18),
                                          ),
                                          new Text(
                                            'request is under review',
                                            softWrap: true,
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                letterSpacing: 1,
                                                wordSpacing: 1,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Toast.toastView(
                                        msg: "your request is under review");
                                  },
                                )
                              ],
                              Padding(padding: EdgeInsets.all(30)),
                              Text(
                                "your Rejected Request",
                                style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1,
                                  color: Color.fromRGBO(82, 21, 72, 1),
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10)),
                              if (rejectedRequestList.length != 0) ...[
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (var i = 0;
                                            i < rejectedRequestList.length;
                                            i++) ...[
                                          Card(
                                            child: new Container(
                                              padding: new EdgeInsets.all(32.0),
                                              color: Color.fromARGB(
                                                  133, 171, 35, 35),
                                              child: new Column(
                                                children: <Widget>[
                                                  new Text(
                                                    '${rejectedRequestList[i]["request_status"]}',
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        letterSpacing: 1,
                                                        wordSpacing: 1,
                                                        fontSize: 18),
                                                  ),
                                                  new Text(
                                                    '${(rejectedRequestList[i]["rejection_reason"] == "") ? "no reason" : rejectedRequestList[i]["rejection_reason"]}',
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
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
                                    ))
                              ]
                            ],
                          )),
                        ],
                      ),
                    ),
                    onRefresh: (() async {
                      setState(() {});
                    }));
              }
            }
            return Center(child: CircularProgressIndicator());
          },
          future: getData(),
        ));
  }
}
