import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/dialogues/DialogueConfermation.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetChild.dart';
import 'package:little_miracles_orphange/services/firebase/FbReqHandler.dart';
import 'package:little_miracles_orphange/utils/adoptionrequest/AdoptionRequest.dart';

class AdReqAceeptAdminScreen extends StatefulWidget {
  const AdReqAceeptAdminScreen({Key? key}) : super(key: key);

  @override
  _AdReqAceeptAdminScreenState createState() => _AdReqAceeptAdminScreenState();
}

class _AdReqAceeptAdminScreenState extends State<AdReqAceeptAdminScreen> {
  getData() async {
    var data = await FbGetChild.fbGetChildByAquisition(aquisitionType: "No");
    print("your requests data === $data");
    return data;
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
        title: Text("accept-form"),
        titleSpacing: 1,
        centerTitle: true,
      ),
      body: FutureBuilder(
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("oops error"),
                );
              } else if (snapshot.hasData) {
                final data = snapshot.data;

                print("your data === $data");
                List uiData = data as List;

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
id :         ${uiData[i]["child_number"]}
''',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        subtitle: Text(
                                          '''
gender :      ${uiData[i]["gender"]}
adopted :    ${uiData[i]["adopted_status"]}
''',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () async{
                                  print(uiData[i]["child_number"]);
                                  DialogueConfermation.showCustomDialog(context, unNamed: () async {
                                   var response = await FbReqHandler.fbAcceptRequest(childId: uiData[i]["child_number"], requestedUser: AdoptionRequest.adoptionRequest["user_email"]);
                                    print(response);
                                    if(response["status"] == true) {
                                       Navigator.of(context).pop();
                                       Navigator.of(context).pop();
                                       Navigator.of(context).pop();
                                       Navigator.of(context).pop();
                                    } else {
                                      Toast.toastView(msg: "oops!.. something went wrong");
                                    }
                                  });
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
          }),
          future: getData()),
    );
  }
}
