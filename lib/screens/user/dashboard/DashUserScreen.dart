import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/UserDrawer.dart';

class DashUserScreen extends StatefulWidget {
  const DashUserScreen({super.key});

  @override
  State<DashUserScreen> createState() => _DashUserScreenState();
}

class _DashUserScreenState extends State<DashUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
               for(int i = 0; i < 5; i++) ...[Text(" data $i")],

           ListView.builder(itemCount: 60,
           physics: NeverScrollableScrollPhysics(),
           shrinkWrap: true,
          //  dragStartBehavior: DragStartBehavior.start,
          scrollDirection: Axis.vertical,
           itemBuilder: (context, index) {
             return Text("data in container $index ");
           },)

          ],
        ),
      )),





      // body: SafeArea(
      //     child: Stack(
      //   children: [
      //     for (int i = 0; i < 5; i++) ...[
      //       Container(
      //         padding: EdgeInsets.only(top: (i + 1) * 20),
      //         child: Text("data === $i"),
      //       )
      //     ],

      //   Container(
      //     padding: EdgeInsets.only(top: 120),
      //     child: ListView.builder(itemCount: 6,
      //     shrinkWrap: true,
      //       itemBuilder: (context, index) {
      //          return Text("data in container $index ");
      //        },),
      //   )

      //     // Positioned(
      //     //   top:  120,
      //     //   child: ListView.builder(itemCount: 6,
      //     //  itemBuilder: (context, index) {
      //     //     return Text("data in container $index ");
      //     //   },),
      //     // )
      //   ],
      // )),

      drawer: UserDrawer(),
    );
  }
}
