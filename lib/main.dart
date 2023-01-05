import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:little_miracles_orphange/commonwidget/payment/PayMent.dart';
import 'package:little_miracles_orphange/firebase_options.dart';
import 'package:little_miracles_orphange/screens/SegMent.dart';
import 'package:little_miracles_orphange/screens/admin/adoptionrequest/MngAdRequestAdminScreen.dart';

import 'package:little_miracles_orphange/screens/admin/child/AddChildAdmin.dart';
import 'package:little_miracles_orphange/screens/admin/child/UpdateChildAdmin.dart';
import 'package:little_miracles_orphange/screens/admin/dashboard/DashAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/child/MngChildAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/notice/AddNoticeAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/notice/MngNoticeAdminScreen.dart';

import 'package:little_miracles_orphange/screens/admin/reports/ReportsAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/users/userAdminScreen.dart';
import 'package:little_miracles_orphange/screens/general/notice/DetailedNoticeScreen.dart';

import 'package:little_miracles_orphange/screens/general/signIn/SignInScreen.dart';
import 'package:little_miracles_orphange/screens/general/signup/SignUpScreen.dart';

import 'package:little_miracles_orphange/screens/user/addfund/AddFundUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/adoptchild/MngAdoptChildUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/adoptchild/adoptChildUserFormScreen.dart';
import 'package:little_miracles_orphange/screens/user/dashboard/DashUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/donation/DonationUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/feedback/FeedBackUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/notice/NoticeUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/reports/ResportUserScreen.dart';
import 'package:little_miracles_orphange/services/notification/local_notification_service.dart';

import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';
import 'package:little_miracles_orphange/utils/themes/PrimaryTheme.dart';


// import 'package:little_miracles_orphange/commonwidget/payment/App1.dart';
// import 'package:little_miracles_orphange/commonwidget/payment/PayMent2.dart';
// import 'package:little_miracles_orphange/commonwidget/payment/TableView1.dart';
// import 'package:little_miracles_orphange/screens/admin/notice/NoticeAdminScreen.dart';
// import 'package:little_miracles_orphange/screens/notification/Notification.dart';


// android notification channel

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  LocalNotificationService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Little Miracles Orphanege',
      theme: ThemeData(
        primarySwatch: PrimaryTheme.colorCustom,
        bottomAppBarColor: PrimaryTheme.colorCustom,
      ),
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      initialRoute: ScreenRoutes.signInScreen,
      // initialRoute: "/payment",
      routes: {
        // general Screens
        // ScreenRoutes.welcomeScreen: (context) => WelcomeScreen(),
        ScreenRoutes.signUpScreen: (context) => SignUpScreen(),
        ScreenRoutes.signInScreen: (context) => SignInScreen(),
        ScreenRoutes.detailedNoticeScreen:(context) => DetailedNoticeScreen(),

        // admin Screens
        ScreenRoutes.adminDashboardScreen: (context) => DashAdminScreen(),
        ScreenRoutes.adminUserScreen: (context) => UserAdminScreen(),
        ScreenRoutes.adminManageChildScreen: (context) => MngChildAdminScreen(),
        ScreenRoutes.adminManageNoticescreen: (context) =>
            MngNoticeAdminScreen(),
        ScreenRoutes.adminAddNoticeScreen: (context) => AddNoticeAdminScreen(),
        ScreenRoutes.adminReportscreen: (context) => ReposrtAdminScreen(),
        ScreenRoutes.adminAddChildScreen: (context) => AddChildAdmin(),
        ScreenRoutes.adminUpdateChildScreen: (context) => UpdateChildAdmin(),
        ScreenRoutes.adminManageAdoptionRequestScreen:(context) => MngAdRequestAdminScreen(),

        // user Screen
        ScreenRoutes.userDashboardScreen: (context) => DashUserScreen(),
        ScreenRoutes.userAddFundScreen: (context) => AddFundUserScreen(),
        // ScreenRoutes.userManageAdoptChildScreen: (context) => userManageAdoptChildScreen()
        ScreenRoutes.userManageAdoptChildScreen:(context) => MngAdoptChildUserScreen(),
        ScreenRoutes.userAdoptChildFormScreen:(context) => AdoptChildFormUserScreen(),
        ScreenRoutes.userFeedBackScreen: (context) => FeedBackUserScreen(),
        ScreenRoutes.userNoticeScreen: (context) => NoticeUserScreen(),
        ScreenRoutes.userReportScreen: (context) => ReportUserScreen(),
        ScreenRoutes.userDonationScren:(context) => DonatioonUserScreen(),

        // testiong screens
        "/sendnotification": (context) => SegMent(),
        "/payment":(context) => PayMent(),
        // "/tableView":(context) => TableView1(title: "table view savan")
      },
    );
  }
}

