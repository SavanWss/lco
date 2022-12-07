

import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';

class MngChildAdminScreen extends StatefulWidget {
  const MngChildAdminScreen({super.key});

  @override
  State<MngChildAdminScreen> createState() => _MngChildAdminScreenState();
}

class _MngChildAdminScreenState extends State<MngChildAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      drawer: AdminDrawer(),
    );
  }
}