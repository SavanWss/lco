import 'package:flutter/material.dart';
import 'package:flutter_basic_chat_bubble/flutter_basic_chat_bubble.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';

class NoticeAdminScreen extends StatefulWidget {
  const NoticeAdminScreen({super.key});

  @override
  State<NoticeAdminScreen> createState() => _NoticeAdminScreenState();
}

class _NoticeAdminScreenState extends State<NoticeAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(48, 208, 46, 237),
        title: Text("Notice"),
        titleSpacing: 1,
        centerTitle: true,
      ),
      drawer: AdminDrawer(),
      body: ListView(
        children: [
          BasicChatBubble(
              message: BasicChatMessage(
            messageText: "hi i am savan",
            peerUserName: "admin",
            timeStamp: DateTime.now().toString(),
          ),
          isMe: true,
          textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
