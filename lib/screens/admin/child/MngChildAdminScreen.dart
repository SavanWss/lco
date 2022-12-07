import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';
import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class MngChildAdminScreen extends StatefulWidget {
  const MngChildAdminScreen({super.key});

  @override
  State<MngChildAdminScreen> createState() => _MngChildAdminScreenState();
}

class _MngChildAdminScreenState extends State<MngChildAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(48, 208, 46, 237),
        title: Text("Child"),
        titleSpacing: 1,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.restorablePushNamed(context, ScreenRoutes.adminAddChildScreen);
        },
        isExtended: true,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: AdminDrawer(),
    );
  }
}
