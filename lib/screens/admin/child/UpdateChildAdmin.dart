import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetChild.dart';
import 'package:little_miracles_orphange/utils/managechild/ManageChildData.dart';

class UpdateChildAdmin extends StatefulWidget {
  const UpdateChildAdmin({super.key});

  @override
  State<UpdateChildAdmin> createState() => _UpdateChildAdminState();
}

class _UpdateChildAdminState extends State<UpdateChildAdmin> {

    Future getChildData() async {
    var data = await FbGetChild.fbGetChildById(uniqueid: ManageChildData.selectedChildData);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          shadowColor: Color.fromARGB(48, 208, 46, 237),
          title: Text("Child"),
          titleSpacing: 1,
          centerTitle: true,),
      drawer: AdminDrawer(),
      body: FutureBuilder(future: getChildData(), builder: (context, snapshot) {
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
                var data = snapshot.data;

                return Text("$data");
              }
        }
        return CircularProgressIndicator();
      },),
    );
  }
}