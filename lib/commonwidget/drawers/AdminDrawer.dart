import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/toast/Toast.dart';
import 'package:little_miracles_orphange/services/firebase/FbSignOut.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';
import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({super.key});

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: ListView(
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  gaplessPlayback: true,
                  filterQuality: FilterQuality.high,
                ),
              ),

              Center(
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text(LoggedInDetails.userName),
                  ),
                ),
              ),

              ListTile(
                onTap: () {
                  Navigator.pushNamed(
                      context, ScreenRoutes.adminDashboardScreen);
                },
                leading: Icon(Icons.dashboard),
                title: Text('DashBoard'),
              ),

              ListTile(
                onTap: () {
                  Navigator.pushNamed(
                      context, ScreenRoutes.adminManageChildScreen);
                },
                leading: Icon(Icons.manage_accounts),
                title: Text('ManageChild'),
              ),

              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, ScreenRoutes.adminReportscreen);
                },
                leading: Icon(Icons.settings),
                title: Text('Ad. Requets'),
              ),

              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, ScreenRoutes.adminUserScreen);
                },
                leading: Icon(Icons.manage_accounts_outlined),
                title: Text('Users'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, ScreenRoutes.adminReportscreen);
                },
                leading: Icon(Icons.settings),
                title: Text('Reports'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(
                      context, ScreenRoutes.adminManageNoticescreen);
                },
                leading: Icon(Icons.settings),
                title: Text('Notice'),
              ),
              ListTile(
                onTap: () async {
                  try {
                    await FbSignOut.fbSignOut();
                    Toast.toastView(msg: "sign out successfully");
                  } catch (e) {}
                  Navigator.popAndPushNamed(context, ScreenRoutes.signInScreen);
                },
                leading: Icon(Icons.settings),
                title: Text('LogOut'),
              ),
              // Spacer(),

              Center(
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
