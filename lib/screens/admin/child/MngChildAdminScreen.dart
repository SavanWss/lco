import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetChild.dart';
import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class MngChildAdminScreen extends StatefulWidget {
  MngChildAdminScreen({super.key});

  @override
  State<MngChildAdminScreen> createState() => _MngChildAdminScreenState();
}

class _MngChildAdminScreenState extends State<MngChildAdminScreen> {
  Future getData() async {
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
    } else {
      Icon(Icons.girl, color: Color.fromARGB(255, 242, 182, 182), size: 75);
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
                print("data in builder ${data.length}");
                return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: ListView(
                      children: [
                        if (data.length == 0) ...[
                          Center(
                            child: Card(
                              margin: EdgeInsets.all(10),
                              color: Colors.white,
                              shadowColor: Color.fromARGB(255, 255, 255, 255),
                              elevation: 20,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.album,
                                        color:
                                            Color.fromARGB(255, 255, 168, 168),
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
                        for (int i = 0; i < data.length; i++) ...[
                          Card(
                            margin: EdgeInsets.all(10),
                            color: Colors.white,
                            shadowColor: Color.fromARGB(255, 255, 255, 255),
                            elevation: 20,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: genderIconSelector(data[i]["gender"]),
                                  title: Text(
                                    '''
name :  ${data[i]["name"]}
id :         ${data[i]["child_number"]}
''',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    '''
gender :      ${data[i]["gender"]}
adopted :    ${data[i]["adopted_status"]}
''',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]
                      ],
                    ));
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
