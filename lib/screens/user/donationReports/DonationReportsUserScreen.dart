import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/UserDrawer.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetReports.dart';
import 'package:little_miracles_orphange/utils/SegmentFlags.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';


class DonationReportsUserScreen extends StatefulWidget {
  const DonationReportsUserScreen({super.key});

  @override
  State<DonationReportsUserScreen> createState() => _DonationReportsUserScreenState();
}

class _DonationReportsUserScreenState extends State<DonationReportsUserScreen> {
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
    var data = await FbGetReports.fbGetThingsReport();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: UserDrawer(),
      body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // for error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                final data = snapshot.data;
                List a = data as List;
                print("i am user ksbd789912394891498938648934981239849823489392864982345238748923745239867458923892398479");

                a.sort((a, b) {
                  return Comparable.compare(a["date_and_time"].toString(),
                      b["date_and_time"].toString());
                });

                var reversedList = new List.from(a.reversed);
                a = reversedList;

                var segmentFlag = 0;

                var userSpecificDon = [];
                for (var element in a) {
                  if (LoggedInDetails.userEmail == element["user_email"]) {
                    userSpecificDon.add(element);
                  }
                }

                return RefreshIndicator(
                    child: Stack(children: [
                      ListView(
                        children: [

                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: CupertinoSlidingSegmentedControl(
                                  backgroundColor:
                                      Color.fromRGBO(82, 21, 72, 1),
                                  thumbColor:
                                      Color.fromARGB(224, 175, 146, 175),
                                  padding: EdgeInsets.all(8),
                                  groupValue: SegmentFlags.userReportsFlag,
                                  children: {
                                    0: buildSegment("my Conti."),
                                    1: buildSegment("NGO Total"),
                                  },
                                  onValueChanged: (value) {
                                    setState(() {
                                      segmentFlag = value!;
                                      SegmentFlags.userReportsFlag = value;
                                      print("segment flag == $value");
                                    });
                                  }),
                            ),
                          ),

                          if(SegmentFlags.userReportsFlag == 0) ...[
                            DataTable(columns: [
                            DataColumn(
                              label: Text('user'),
                            ),
                            DataColumn(
                              label: Text('fund'),
                            ),
                            DataColumn(
                              label: Text('date_and_time'),
                            ),
                          ], rows: [
                            for (var i = 0; i < userSpecificDon.length; i++) ...[
                              DataRow(
                                cells: [
                                  DataCell(Text(
                                    '${userSpecificDon[i]["user_email"]}',
                                    softWrap: true,
                                    style: TextStyle(fontSize: 10),
                                  )),
                                  DataCell(Text('${userSpecificDon[i]["funds"]}')),
                                  DataCell(Text(
                                      '${DateTime.fromMicrosecondsSinceEpoch(userSpecificDon[i]["date_and_time"].microsecondsSinceEpoch)}'))
                                ],
                                onLongPress: () async {},
                              )
                            ]
                          ]),
                          ],

                          if(SegmentFlags.userReportsFlag == 1) ...[

                          DataTable(columns: [
                            DataColumn(
                              label: Text('user'),
                            ),
                            DataColumn(
                              label: Text('fund'),
                            ),
                            DataColumn(
                              label: Text('date_and_time'),
                            ),
                          ], rows: [
                            for (var i = 0; i < a.length; i++) ...[
                              DataRow(
                                cells: [
                                  DataCell(Text(
                                    '${a[i]["user_email"]}',
                                    softWrap: true,
                                    style: TextStyle(fontSize: 10),
                                  )),
                                  DataCell(Text('${a[i]["funds"]}')),
                                  DataCell(Text(
                                      '${DateTime.fromMicrosecondsSinceEpoch(a[i]["date_and_time"].microsecondsSinceEpoch)}'))
                                ],
                                onLongPress: () async {},
                              )
                            ]
                          ]),
                          ]
                        ],
                      )
                    ]),
                    onRefresh: () async {
                      setState(() {});
                    });
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getData()),
    );
  }
}