import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/dialogues/DialogUtils.dart';
import 'package:little_miracles_orphange/commonwidget/dialogues/DialogueApprovedDetails.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
import 'package:little_miracles_orphange/commonwidget/indicator/CircularIndicator.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetAdRequest.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetUser.dart';
import 'package:little_miracles_orphange/utils/adoptionrequest/AdoptionRequest.dart';
import 'package:little_miracles_orphange/utils/requesteduserdetail/RequestedUserDetail.dart';

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
    print("your requests data === $data");
    return data;
  }

  getuserSpecificData() async {
    var data = await FbGetUser.fbGetUsreById(email: AdoptionRequest.adoptionRequest["user_email"]);
    print("your requests data === $data");
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
                  child: Text("oops error"),
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

                print(
                    "your Rejected request length size ${rejectedRequestList.length}");

                return RefreshIndicator(
                    child: SafeArea(
                        child: SingleChildScrollView(
                      child: Column(
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
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
                                child: DataTable(columns: [
                                  DataColumn(
                                    label: Text('email'),
                                  ),
                                  DataColumn(
                                    label: Text('name'),
                                  ),
                                  DataColumn(
                                    label: Text('reason'),
                                  ),
                                ], rows: [
                                  for (var i = 0;
                                      i < pendingRequestList.length;
                                      i++) ...[
                                    DataRow(
                                      cells: [
                                        DataCell(Text(
                                          '${pendingRequestList[i]["user_email"]}',
                                          softWrap: true,
                                          style: TextStyle(fontSize: 10),
                                        )),
                                        DataCell(Text(
                                            '${pendingRequestList[i]["user_name"]}')),
                                        DataCell(Text(
                                            '${pendingRequestList[i]["adoption_description"]}')),
                                      ],
                                      onLongPress: () async{
                                        CircularIndicator.startCircularIndicator(context);
                                        AdoptionRequest.adoptionRequest =
                                            pendingRequestList[i];
                                        print(AdoptionRequest
                                            .adoptionRequest["user_email"]);
                                        // Navigator.restorablePushNamed(context, ScreenRoutes.adminAdReqResponseScreen);
                                        var user = await FbGetUser.fbGetUsreById(email: pendingRequestList[i]["user_email"]);
                                        RequestedUserDetail.userDetails = user[0];
                                        CircularIndicator.stopCircularIndicator(context);
                                        DialogUtils.showCustomDialog(context);
                                      },
                                    )
                                  ]
                                ]),
                              ),
                            )
                          ],

                          // approved requests
                          if (segmentFlag == 1) ...[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(columns: [
                                DataColumn(
                                  label: Text('email'),
                                ),
                                DataColumn(
                                  label: Text('name'),
                                ),
                                DataColumn(
                                  label: Text('child'),
                                ),
                              ], rows: [
                                for (var i = 0;
                                    i < accepedRequestList.length;
                                    i++) ...[
                                  DataRow(
                                    cells: [
                                      DataCell(Text(
                                        '${accepedRequestList[i]["user_email"]}',
                                        softWrap: true,
                                        style: TextStyle(fontSize: 10),
                                      )),
                                      DataCell(Text(
                                          '${accepedRequestList[i]["user_name"]}')),
                                      DataCell(Text(
                                          '${accepedRequestList[i]["child_number"]}')),
                                    ],
                                    onLongPress: () {
                                      DialogueApprovedDetails.showCustomDialog(context);
                                    },
                                  )
                                ]
                              ]),
                            )
                          ],

                          if (segmentFlag == 2) ...[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(columns: [
                                DataColumn(
                                  label: Text('email'),
                                ),
                                DataColumn(
                                  label: Text('name'),
                                ),
                                DataColumn(
                                  label: Text('reason'),
                                ),
                              ], rows: [
                                for (var i = 0;
                                    i < rejectedRequestList.length;
                                    i++) ...[
                                  DataRow(
                                    cells: [
                                      DataCell(Text(
                                        '${rejectedRequestList[i]["user_email"]}',
                                        softWrap: true,
                                        style: TextStyle(fontSize: 10),
                                      )),
                                      DataCell(Text(
                                          '${rejectedRequestList[i]["user_name"]}')),
                                      DataCell(Text(
                                          '${rejectedRequestList[i]["rejection_reason"]}')),
                                    ],
                                  )
                                ]
                              ]),
                            )
                          ]
                        ],
                      ),
                    )),
                    onRefresh: (() async {
                      setState(() {});
                    }));
              }
            }
            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          },

          // Future that needs to be resolved
          // inorder to display something on the Canvas
          future: getData(),
        ));
  }
}
