import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';

class ReposrtAdminScreen extends StatefulWidget {
  const ReposrtAdminScreen({super.key});

  @override
  State<ReposrtAdminScreen> createState() => _ReposrtAdminScreenState();
}

class _ReposrtAdminScreenState extends State<ReposrtAdminScreen> {
  @override
 Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      drawer: AdminDrawer(),
    );
  }
}