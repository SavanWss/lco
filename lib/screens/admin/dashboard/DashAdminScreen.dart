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
      appBar: AppBar(),
      drawer: AdminDrawer(),
      body: Container(
        child: ListView(
          children: [

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 25),
              child: GestureDetector(
                onTap: () {
                  print("card view clicked");
                },
                child: Card(
                shadowColor: Color.fromARGB(189, 70, 63, 63),
                borderOnForeground: true,
                color: Color.fromARGB(255, 255, 255, 255),
                shape: Border.all(
                    style: BorderStyle.solid,
                    color: Color.fromARGB(90, 19, 15, 15)),
                child: SizedBox(
                  height: 50,
                  child: Text("Savan"),
                ),
              ),
              )
            )

          ],
        ),
      ),
    );
  }
}
