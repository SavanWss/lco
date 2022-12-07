import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';

class NoticeAdminScreen extends StatefulWidget {
  const NoticeAdminScreen({super.key});

  @override
  State<NoticeAdminScreen> createState() => _NoticeAdminScreenState();
}

class _NoticeAdminScreenState extends State<NoticeAdminScreen> {
  @override
 Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      drawer: AdminDrawer(),
    );
  }
}