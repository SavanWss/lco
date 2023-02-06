import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetReports.dart';

class ReposrtAdminScreen extends StatefulWidget {
  const ReposrtAdminScreen({super.key});

  @override
  State<ReposrtAdminScreen> createState() => _ReposrtAdminScreenState();
}

class _ReposrtAdminScreenState extends State<ReposrtAdminScreen> {
  getData() async {
    var data = await FbGetReports.fbGetThingsReport();
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

                return RefreshIndicator(child: Stack(children: [
                  ListView(
                    children: [
                      DataTable(columns: [
                                  DataColumn(
                                    label: Text('Name'),
                                  ),
                                  DataColumn(
                                    label: Text('Quantity'),
                                  ),
                                  DataColumn(
                                    label: Text('Time'),
                                  ),
                                ], rows: [
                                  for (var i = 0;
                                      i < a.length;
                                      i++) ...[
                                    DataRow(
                                      cells: [
                                        DataCell(Text(
                                          '${a[i]["name_of_things"]}',
                                          softWrap: true,
                                          style: TextStyle(fontSize: 10),
                                        )),
                                        DataCell(Text(
                                            '${a[i]["quantity"]}')),
                                        DataCell(Text(
                                            '${(a[i]['date_and_time']) }'))
                                      ],
                                      onLongPress: () async{
                               
                                      },
                                    )
                                  ]
                                ]),
                    ],
                  )
                ]), onRefresh: () async {
                      setState(() {});
                    });
              }
            }
            return CircularProgressIndicator();
          },
          future: getData()),
    );
  }
}
