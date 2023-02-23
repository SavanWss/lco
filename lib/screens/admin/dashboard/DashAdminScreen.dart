import 'package:flutter/material.dart';

import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';

class DashAdminScreen extends StatefulWidget {
  const DashAdminScreen({super.key});

  @override
  State<DashAdminScreen> createState() => _DashAdminScreenState();
}

class _DashAdminScreenState extends State<DashAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Color.fromARGB(48, 208, 46, 237),
          title: Text("DashBoard"),
          titleSpacing: 1,
          centerTitle: true,
        ),
        drawer: AdminDrawer(),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width
,
                child: Container(
                  
                  child: Text(
                    "total users",
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontSize: 20, backgroundColor: Colors.black54),
                  ),
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromARGB(155, 216, 216, 216),
                ),
              ),
            ],
          ),
        )));
  }
}
