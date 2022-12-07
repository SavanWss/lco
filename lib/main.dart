import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:little_miracles_orphange/firebase_options.dart';
import 'package:little_miracles_orphange/screens/admin/child/AddChildAdmin.dart';

import 'package:little_miracles_orphange/screens/admin/dashboard/DashAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/child/MngChildAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/notice/NoticeAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/reports/ReportsAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/users/userAdminScreen.dart';

import 'package:little_miracles_orphange/screens/signIn/SignInScreen.dart';
import 'package:little_miracles_orphange/screens/signup/SignUpScreen.dart';

import 'package:little_miracles_orphange/screens/user/addfund/AddFundUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/adoptchild/adoptChildUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/dashboard/DashUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/feedback/FeedBackUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/notice/NoticeUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/reports/ResportUserScreen.dart';

import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';
import 'package:little_miracles_orphange/utils/themes/PrimaryTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Little Miracles Orphanege',
      theme: ThemeData(
        primarySwatch: PrimaryTheme.colorCustom,
        bottomAppBarColor: PrimaryTheme.colorCustom,
      ),
      initialRoute: ScreenRoutes.signInScreen,
      routes: {
        // general Screens
        // ScreenRoutes.welcomeScreen: (context) => WelcomeScreen(),
        ScreenRoutes.signUpScreen: (context) => SignUpScreen(),
        ScreenRoutes.signInScreen: (context) => SignInScreen(),

        // admin Screens
        ScreenRoutes.adminDashboardScreen:(context) => DashAdminScreen(),
        ScreenRoutes.adminUserScreen:(context) => UserAdminScreen(),
        ScreenRoutes.adminManageChildScreen:(context) => MngChildAdminScreen(),
        ScreenRoutes.adminNoticescreen:(context) => NoticeAdminScreen(),
        ScreenRoutes.adminReportscreen:(context) => ReposrtAdminScreen(),
        ScreenRoutes.adminAddChildScreen:(context) => AddChildAdmin(),

        // user Screen
        ScreenRoutes.userDashboardScreen:(context) => DashUserScreen(),
        ScreenRoutes.userAddFundScreen:(context) => AddFundUserScreen(),
        ScreenRoutes.userAdoptChildScreen:(context) => AdoptChildUserScreen(),
        ScreenRoutes.userFeedBackScreen:(context) => FeedBackUserScreen(),
        ScreenRoutes.userNoticeScreen:(context) => NoticeUserScreen(),
        ScreenRoutes.userReportScreen:(context) => ReportUserScreen()

      },
    );
  }
}
