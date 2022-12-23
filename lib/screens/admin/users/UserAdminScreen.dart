

import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetUser.dart';

class UserAdminScreen extends StatefulWidget {
  const UserAdminScreen({super.key});

  @override
  State<UserAdminScreen> createState() => _UserAdminScreenState();
}

class _UserAdminScreenState extends State<UserAdminScreen> {

  Future getChildData() async {
    var data = await FbGetUser.fbGetAllUsres();

    return data;
  }

  @override
  void initState() {
    print("init state is called");
    super.initState();
  }


  genderIconSelector(gender) {
    if (gender == "Male") {
      return Icon(Icons.boy,
          color: Color.fromARGB(255, 242, 182, 182), size: 75);
    } else if (gender == "Other") {
      return Icon(Icons.transgender,
          color: Color.fromARGB(255, 242, 182, 182), size: 75);
    } else {
      return Icon(Icons.girl,
          color: Color.fromARGB(255, 242, 182, 182), size: 75);
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          shadowColor: Color.fromARGB(48, 208, 46, 237),
          title: Text("Users"),
          titleSpacing: 1,
          centerTitle: true,),
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

                print("your data === $data");
                var uiData = data;
  
                return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: Stack(
                      children: [
                        ListView(
                          children: [
                            if (uiData.length == 0) ...[
                              Center(
                                child: Card(
                                  margin: EdgeInsets.all(10),
                                  color: Colors.white,
                                  shadowColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  elevation: 20,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.album,
                                            color: Color.fromARGB(
                                                255, 255, 168, 168),
                                            size: 45),
                                        title: Text(
                                          "currently there are no users",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        subtitle: Text('world is happy'),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                            for (int i = 0; i < uiData.length; i++) ...[
                              GestureDetector(
                                child: Card(
                                  margin: EdgeInsets.all(10),
                                  color: Colors.white,
                                  shadowColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  elevation: 20,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: genderIconSelector(
                                            uiData[i]["gender"]),
                                        title: Text(
                                          '''
name :  ${uiData[i]["name"]}
id :         ${uiData[i]["email"]}
''',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        subtitle: Text(
                                          '''
gender :      ${uiData[i]["gender"]}
profession :    ${uiData[i]["profession"]}
doneted_fund :    ${uiData[i]["total_dnt_fund"]}
adopted_child :    ${uiData[i]["adopted_child"]}
''',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  // print(uiData[i]["child_number"]);
                                  // ManageChildData.selectedChildData = uiData[i]["child_number"];
                                  // print("managedChilddata === ${ManageChildData.selectedChildData}");
                                  // Navigator.restorablePushNamed(context, ScreenRoutes.adminUpdateChildScreen);
                                },
                              )
                            ]
                          ],
                        )
                      ],
                    ));
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getChildData()),
      drawer: AdminDrawer(),
    );
  }
}