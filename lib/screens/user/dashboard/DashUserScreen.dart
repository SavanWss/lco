import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/UserDrawer.dart';
import 'package:little_miracles_orphange/utils/admindashboard/AdminDashboard.dart';

class DashUserScreen extends StatefulWidget {
  const DashUserScreen({super.key});

  @override
  State<DashUserScreen> createState() => _DashUserScreenState();
}

class _DashUserScreenState extends State<DashUserScreen> {
   @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          shadowColor: Color.fromARGB(48, 208, 46, 237),
          title: Text("DashBoard"),
          titleSpacing: 1,
          centerTitle: true,
        ),
        drawer: UserDrawer(),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 20,),

              SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width
,
                child: Container(
                  
                  child: Center(
                    child: Text(
                    "total users :-   ${AdminDashBoard.TotalUser}",
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontSize: 20, backgroundColor: Colors.black54),
                  ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromARGB(155, 216, 216, 216),
                ),
              ),
              SizedBox(height: 30,),

  SingleChildScrollView(
    physics: ScrollPhysics(),

            scrollDirection: Axis.horizontal,
    child: 
            Row(
              children: [
                for(int i = 1; i <= 11; i++) ...[
                  Image.asset("assets/images/i${i}.jpg",alignment: Alignment.center,fit: BoxFit.fill,)
                ]
              ],

              
            ),
  )

            ],
          ),
        )));
  }

}
