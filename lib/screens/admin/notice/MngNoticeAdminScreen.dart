import 'package:flutter/material.dart';
import 'package:flutter_basic_chat_bubble/flutter_basic_chat_bubble.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
import 'package:little_miracles_orphange/services/datastorerinutils/NoticeDataSaver.dart';
// import 'package:little_miracles_orphange/services/firebase/FbGetNotice.dart';
import 'package:little_miracles_orphange/services/firebase/FbGetNotice.dart';
import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class MngNoticeAdminScreen extends StatefulWidget {
  MngNoticeAdminScreen({super.key});

  @override
  State<MngNoticeAdminScreen> createState() => _MngNoticeAdminScreenState();
}

class _MngNoticeAdminScreenState extends State<MngNoticeAdminScreen> {
  Future getNoticeData() async {
    var data = await FbGetNotice.fbGetAllNotice();

    return data;
  }

  @override
  void initState() {
    print("init state is called");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MngNoticeAdminScreen oldWidget) {
    print("updated ia called");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(48, 208, 46, 237),
        title: Text("Notice"),
        titleSpacing: 1,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.restorablePushNamed(
              context, ScreenRoutes.adminAddNoticeScreen);
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
                final List<dynamic> data = snapshot.data as List;

                print("your data === $data");
                var uiData = data;
                print(uiData.runtimeType);
                uiData.sort((a, b) {
                  return Comparable.compare(a["date_and_time"].toString(),
                      b["date_and_time"].toString());
                });

                var reversedList = new List.from(uiData.reversed);
                uiData = reversedList;
                print("sorted ui data ");
                for (var element in uiData) {
                  print(element);
                }

                return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: Stack(
                      children: [
                        ListView.builder(
                            itemCount: uiData.length,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                child: BasicChatBubble(
                                  message: BasicChatMessage(
                                    messageText: uiData[index]["event_title"],
                                    timeStamp:
                                        DateTime.fromMillisecondsSinceEpoch(
                                                uiData[index]["date_and_time"])
                                            .toString(),
                                  ),
                                  isMe: false,
                                  backgroundColor:
                                      Color.fromRGBO(82, 21, 71, 1),
                                  textColor: Color.fromARGB(255, 255, 255, 255),
                                ),
                                onTap: () {
                                  // NoticeDialogue.showNoticeDialogue(context);
                                  NoticeDataSaver.noticeDataSaver(
                                      description: uiData[index]["decsription"],
                                      eventMode: uiData[index]["event_mode"],
                                      eventTime: uiData[index]
                                          ["event_date_and_time"],
                                      eventTitle: uiData[index]["event_title"],
                                      eventTopic: uiData[index]["event_topic"],
                                      noticeTiming: uiData[index]
                                          ["date_and_time"],
                                      organisedBy: uiData[index]
                                          ["organised_by"],
                                      uniqueId: uiData[index]["unique_id"]);

                                  print("object $index");
                                  Navigator.pushNamed(context, ScreenRoutes.detailedNoticeScreen);
                                },
                              );
                            })),
                      ],
                    ));
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getNoticeData()),
    );
  }
}
