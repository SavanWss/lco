import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetReports.dart';

class FundDonateReportsAdminScreen extends StatefulWidget {
  const FundDonateReportsAdminScreen({super.key});

  @override
  State<FundDonateReportsAdminScreen> createState() => _FundDonateReportsAdminScreenState();
}

class _FundDonateReportsAdminScreenState extends State<FundDonateReportsAdminScreen> {
  getData() async {
    var data = await FbGetReports.fbGetFundsReport();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var times = Timestamp.fromMicrosecondsSinceEpoch(634827387926233);

    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(48, 208, 46, 237),
        title: Text("Reports"),
        titleSpacing: 1,
        centerTitle: true,
      ),
      drawer: AdminDrawer(),
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
                print(a);

                a.sort((a, b) {
                  return Comparable.compare(a["date_and_time"].toString(),
                      b["date_and_time"].toString());
                });

                var reversedList = new List.from(a.reversed);
                a = reversedList;

                return RefreshIndicator(
                    child: Stack(children: [
                      ListView(
                        children: [
                          DataTable(columns: [
                            DataColumn(
                              label: Text('user'),
                            ),
                            DataColumn(
                              label: Text('fund'),
                            ),
                            DataColumn(
                              label: Text('dat_and_time'),
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