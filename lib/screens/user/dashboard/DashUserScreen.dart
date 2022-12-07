import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/UserDrawer.dart';

class DashUserScreen extends StatefulWidget {
  const DashUserScreen({super.key});

  @override
  State<DashUserScreen> createState() => _DashUserScreenState();
}

class _DashUserScreenState extends State<DashUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text("user dashboard"),
      drawer: UserDrawer(),
    );
  }
}