import 'package:flutter/material.dart';
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
      appBar: AppBar(
          shadowColor: Color.fromARGB(48, 208, 46, 237),
          title: Text("Reports"),
          titleSpacing: 1,
          centerTitle: true,),
      drawer: AdminDrawer(),
    );
  }
}