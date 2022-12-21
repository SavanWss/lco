import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/utils/managenotice/NoticeDetails.dart';

class DetailedNoticeScreen extends StatefulWidget {
  const DetailedNoticeScreen({Key? key}) : super(key: key);

  @override
  _DetailedNoticeScreenState createState() => _DetailedNoticeScreenState();
}

class _DetailedNoticeScreenState extends State<DetailedNoticeScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> mainTitleList = [
      "Issued Time",
      "Event Title",
      "Event_Topic",
      "Event Mode",
      "Event Timing",
      "Event Description",
      "Organizer"
    ];

    List noticeDataList = [
      NoticeDetails.noticeIssuedTime,
      NoticeDetails.noticeEventTitle,
      NoticeDetails.noticeEventTopic,
      NoticeDetails.noticeEventMode,
      NoticeDetails.noticeEventDateTime,
      NoticeDetails.noticeDescription,
      NoticeDetails.noticeOrganisedBy
    ];

    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(48, 208, 46, 237),
        title: Text("Child"),
        titleSpacing: 1,
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              clipBehavior: Clip.antiAlias,
              physics: AlwaysScrollableScrollPhysics(),
              dragStartBehavior: DragStartBehavior.start,
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                  itemCount: mainTitleList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    print("object $index");
                    return Card(
                      // borderOnForeground: true,
                      elevation: 25,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            mainTitleList[index].toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Oswald",
                                color: Color.fromRGBO(82, 21, 71, 1)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              noticeDataList[index].toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Oswald",
                                  color: Color.fromRGBO(82, 21, 71, 1),
                                  letterSpacing: 1,
                                  wordSpacing: 10),
                            ),
                          ),
                        ],
                      ),
                    );
                  }))),
    );
  }
}


// 'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',