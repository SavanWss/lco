import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
import 'package:little_miracles_orphange/services/firebase/FbFundUsageByLCO.dart';

class FundUsageReportAdminScreen extends StatefulWidget {
  const FundUsageReportAdminScreen({super.key});

  @override
  State<FundUsageReportAdminScreen> createState() => _FundUsageReportAdminScreenState();
}

class _FundUsageReportAdminScreenState extends State<FundUsageReportAdminScreen> {
 getData() async {
    var data = await FbFundUsageByLCO.fbGetFundUsageDetailsByLCO();
    return data;
  }

  @override
  Widget build(BuildContext context) {
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

                a.sort((a, b) {
                  return Comparable.compare(a["date_and_time"].toString(),
                      b["date_and_time"].toString());
                });

                var reversedList = new List.from(a.reversed);
                a = reversedList;


                print("a == ${a}");

                return RefreshIndicator(
                    child: Stack(children: [
                      ListView(
                        children: [
                          DataTable(columns: [
                            DataColumn(
                              label: Text('funds'),
                            ),
                            DataColumn(
                              label: Text('description'),
                            ),
                            DataColumn(
                              label: Text('date_and_time'),
                            ),
                          ], rows: [
                            for (var i = 0;
                                i < a.length;
                                i++) ...[
                              DataRow(
                                cells: [
                                  DataCell(Text(
                                    '${a[i]["funds"]}',
                                    softWrap: true,
                                    style: TextStyle(fontSize: 10),
                                  )),
                                  DataCell(Text(
                                      '${a[i]["description"]}')),
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