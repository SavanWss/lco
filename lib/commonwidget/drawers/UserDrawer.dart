import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/services/firebase/FbSignOut.dart';
import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';
import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({super.key});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
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
                  Navigator.pushNamed(context, ScreenRoutes.userDashboardScreen);
                },
                leading: Icon(Icons.dashboard),
                title: Text('DashBoard'),
              ),

              if(LoggedInDetails.userAdoptedChild == 0) ...[
                        ListTile(
                onTap: () {
                  Navigator.pushNamed(context, ScreenRoutes.userManageAdoptChildScreen);
                },
                leading: Icon(Icons.manage_accounts),
                title: Text('adopt child'),
              ),
              ],

            if(LoggedInDetails.userAdoptedChild > 0) ...[
                        ListTile(
                onTap: () {
                  // Navigator.pushNamed(context, ScreenRoutes.userManageAdoptChildScreen);
                },
                leading: Icon(Icons.manage_accounts),
                title: Text('my child'),
              ),
              ],


              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, ScreenRoutes.userDonationScren);
                },
                leading: Icon(Icons.manage_accounts_outlined),
                title: Text('make Donation'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, ScreenRoutes.userReportScreen);
                },
                leading: Icon(Icons.settings),
                title: Text('Reports'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, ScreenRoutes.userNoticeScreen);
                },
                leading: Icon(Icons.settings),
                title: Text('Notice'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, ScreenRoutes.userFeedBackScreen);
                },
                leading: Icon(Icons.settings),
                title: Text('FeedBack'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, ScreenRoutes.userPayMentSettingScreen);
                },
                leading: Icon(Icons.payment),
                title: Text('Payments'),
              ),
              ListTile(
                onTap: () async {
                  try {
                    await FbSignOut.fbSignOut();
                  } catch (e) {
                    
                  }
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
