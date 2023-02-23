import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/UserDrawer.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetChild.dart';

class MyCHildUserScreen extends StatefulWidget {
  const MyCHildUserScreen({super.key});

  @override
  State<MyCHildUserScreen> createState() => _MyCHildUserScreenState();
}

class _MyCHildUserScreenState extends State<MyCHildUserScreen> {
  getData() async {
    var data = await FbGetChild.fbGetChildBySpecificUserAdoption();

    return data;
  }

  genderIconSelector(gender) {
    if (gender == "Male") {
      return Icon(Icons.boy,
          color: Color.fromARGB(255, 242, 182, 182), size: 125);
    } else if (gender == "Other") {
      return Icon(Icons.transgender,
          color: Color.fromARGB(255, 242, 182, 182), size: 125);
    } else {
      return Icon(Icons.girl,
          color: Color.fromARGB(255, 242, 182, 182), size: 125);
    }
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
      drawer: UserDrawer(),
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

                print("data ===== ${a}");

                return SingleChildScrollView(
                  child: Stack(children: [
                  Card(
                    shadowColor: Colors.white10,
                    borderOnForeground: true,
                    elevation: 25,
                    shape: Border.all(
                        color: Colors.black,
                        strokeAlign: 10,
                        width: 10,
                        style: BorderStyle.solid),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),

                        // Icon(
                        genderIconSelector(a[0]["gender"]),
                        //     ),

//  Icon(Icons.boy,color:  Color.fromARGB(255, 242, 182, 182), size: 100),

                        SizedBox(
                          height: 40,
                        ),

                        Container(
                          child: Center(
                            child: Text(
                              "Name",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          color: Color.fromARGB(255, 192, 192, 192),
                          height: 25,
                        ),
                        // Text(RequestedUserDetail.userDetails["email"]),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),

                        SizedBox(
                          height: 50,
                          child: Text("${a[0]["name"]}"),
                        ),

                        Container(
                          child: Center(
                            child: Text(
                              "Child_ID",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          color: Color.fromARGB(255, 192, 192, 192),
                          height: 25,
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                        SizedBox(
                          height: 50,
                          child: Text("${a[0]["child_number"]}"),
                        ),
                        // Text((RequestedUserDetail.userDetails["profession"] ==
                        //         null)
                        //     ? "profession not confirmed"
                        //     : "${RequestedUserDetail.userDetails["profession"]}"),

                        Container(
                          child: Center(
                            child: Text(
                              "Gender",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          color: Color.fromARGB(255, 192, 192, 192),
                          height: 25,
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                        SizedBox(
                          height: 50,
                          child: Text("${a[0]["gender"]}"),
                        ),

                        Container(
                          child: Center(
                            child: Text(
                              "Old Guidance",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          color: Color.fromARGB(255, 192, 192, 192),
                          height: 25,
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                        SizedBox(
                          height: 50,
                          child: Text("${a[0]["guidance_name"]}"),
                        ),

                        Container(
                          child: Center(
                            child: Text(
                              "Medical status",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          color: Color.fromARGB(255, 192, 192, 192),
                          height: 25,
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                        SizedBox(
                          height: 50,
                          child: Text("${a[0]["medical_status"]}"),
                        ),

                        if (a[0]["medical_status"] != "Fit") ...[
                          Container(
                            child: Center(
                              child: Text(
                                "Medical Description",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),  
                            width: MediaQuery.of(context).size.width,
                            color: Color.fromARGB(255, 192, 192, 192),
                            height: 25,
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                          SizedBox(
                            height: 50,
                            child:
                                Text("${a[0]["medical_status_description"]}"),
                          ),
                        ]
                      ],
                    ),
                  )
                ]),
                );
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
