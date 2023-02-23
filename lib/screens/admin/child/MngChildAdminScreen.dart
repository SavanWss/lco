import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetChild.dart';
import 'package:little_miracles_orphange/utils/managechild/ManageChildData.dart';
import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class MngChildAdminScreen extends StatefulWidget {
  MngChildAdminScreen({super.key});

  @override
  State<MngChildAdminScreen> createState() => _MngChildAdminScreenState();
}

class _MngChildAdminScreenState extends State<MngChildAdminScreen> {
  Future getChildData() async {
    var data = await FbGetChild.fbGetAllChild();

    return data;
  }

  @override
  void initState() {
    print("init state is called");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MngChildAdminScreen oldWidget) {
    print("updated ia called");
    super.didUpdateWidget(oldWidget);
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
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(48, 208, 46, 237),
        title: Text("Child"),
        titleSpacing: 1,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.restorablePushNamed(
              context, ScreenRoutes.adminAddChildScreen);
        },
        isExtended: true,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

                print("your data === $data");
                var uiData = data;
                uiData.sort((a,b) {
                  return Comparable.compare(a['child_number'], b['child_number']);
                });

                var adoptedChildsList = [];
                var notAddoptedChildsList = [];

                for (var element in uiData) {
                  if (element["adopted_status"] == "Yes") {
                    adoptedChildsList.add(element);
                  } else {
                    notAddoptedChildsList.add(element);
                  }
                }


            print("adopted ==== ${adoptedChildsList}");

  print("not adopted ==== ${adoptedChildsList}");

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
                                          "there are no orphanage",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        subtitle: Text('world is happy'),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],



//                             for (int i = 0; i < uiData.length; i++) ...[
//                               GestureDetector(
//                                 child: Card(
//                                   margin: EdgeInsets.all(10),
//                                   color: Colors.white,
//                                   shadowColor:
//                                       Color.fromARGB(255, 255, 255, 255),
//                                   elevation: 20,
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       ListTile(
//                                         leading: genderIconSelector(
//                                             uiData[i]["gender"]),
//                                         title: Text(
//                                           '''
// name :  ${uiData[i]["name"]}
// id :         ${uiData[i]["child_number"]}
// ''',
//                                           style: TextStyle(fontSize: 20),
//                                         ),
//                                         subtitle: Text(
//                                           '''
// gender :      ${uiData[i]["gender"]}
// adopted :    ${uiData[i]["adopted_status"]}
// ''',
//                                           style: TextStyle(fontSize: 20),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   print(uiData[i]["child_number"]);
//                                   ManageChildData.selectedChildData = uiData[i]["child_number"];
//                                   print("managedChilddata === ${ManageChildData.selectedChildData}");
//                                   Navigator.restorablePushNamed(context, ScreenRoutes.adminUpdateChildScreen);
//                                 },
//                               )
//                             ]




SizedBox(height: 15,),

Center(
  child: 
Text(" adopted",style: TextStyle(
  backgroundColor: Colors.white70,
  fontSize: 20
)),
),

SizedBox(height: 15,),
// adopted






                     for (int i = 0; i < adoptedChildsList.length; i++) ...[
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
name :  ${adoptedChildsList[i]["name"]}
id :         ${adoptedChildsList[i]["child_number"]}
''',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        subtitle: Text(
                                          '''
gender :      ${adoptedChildsList[i]["gender"]}
adopted :    ${adoptedChildsList[i]["adopted_status"]}
''',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onLongPress: () {
                                  print("object");
                                  print(adoptedChildsList[i]["child_number"]);
                                  ManageChildData.selectedChildData = adoptedChildsList[i]["child_number"];
                                  print("managedChilddata === ${ManageChildData.selectedChildData}");
                                  Navigator.restorablePushNamed(context, ScreenRoutes.adminUpdateChildScreen);
                                },
                              )
                            ],



SizedBox(height: 15,),

Center(
  child: 
Text("not adopted",style: TextStyle(
  backgroundColor: Colors.white70,
  fontSize: 20
)),
),

SizedBox(height: 15,),
// not adopted




                     for (int i = 0; i < notAddoptedChildsList.length; i++) ...[
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
name :  ${notAddoptedChildsList[i]["name"]}
id :         ${notAddoptedChildsList[i]["child_number"]}
''',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        subtitle: Text(
                                          '''
gender :      ${notAddoptedChildsList[i]["gender"]}
adopted :    ${notAddoptedChildsList[i]["adopted_status"]}
''',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  print(notAddoptedChildsList[i]["child_number"]);
                                  ManageChildData.selectedChildData = notAddoptedChildsList[i]["child_number"];
                                  print("managedChilddata === ${ManageChildData.selectedChildData}");
                                  Navigator.restorablePushNamed(context, ScreenRoutes.adminUpdateChildScreen);
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
    );
  }
}
