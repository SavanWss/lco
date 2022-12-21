import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:little_miracles_orphange/firebase_options.dart';

import 'package:little_miracles_orphange/screens/admin/child/AddChildAdmin.dart';
import 'package:little_miracles_orphange/screens/admin/child/UpdateChildAdmin.dart';
import 'package:little_miracles_orphange/screens/admin/dashboard/DashAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/child/MngChildAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/notice/AddNoticeAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/notice/MngNoticeAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/notice/NoticeAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/reports/ReportsAdminScreen.dart';
import 'package:little_miracles_orphange/screens/admin/users/userAdminScreen.dart';
import 'package:little_miracles_orphange/screens/general/notice/DetailedNoticeScreen.dart';

import 'package:little_miracles_orphange/screens/notification/Notification.dart';

import 'package:little_miracles_orphange/screens/general/signIn/SignInScreen.dart';
import 'package:little_miracles_orphange/screens/general/signup/SignUpScreen.dart';

import 'package:little_miracles_orphange/screens/user/addfund/AddFundUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/adoptchild/adoptChildUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/dashboard/DashUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/feedback/FeedBackUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/notice/NoticeUserScreen.dart';
import 'package:little_miracles_orphange/screens/user/reports/ResportUserScreen.dart';
import 'package:little_miracles_orphange/services/notification/local_notification_service.dart';

import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';
import 'package:little_miracles_orphange/utils/themes/PrimaryTheme.dart';

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
      // initialRoute: ScreenRoutes.signInScreen,
      initialRoute: ScreenRoutes.signInScreen,
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

        // user Screen
        ScreenRoutes.userDashboardScreen: (context) => DashUserScreen(),
        ScreenRoutes.userAddFundScreen: (context) => AddFundUserScreen(),
        ScreenRoutes.userAdoptChildScreen: (context) => AdoptChildUserScreen(),
        ScreenRoutes.userFeedBackScreen: (context) => FeedBackUserScreen(),
        ScreenRoutes.userNoticeScreen: (context) => NoticeUserScreen(),
        ScreenRoutes.userReportScreen: (context) => ReportUserScreen(),

        // testiong screens
        "/sendnotification": (context) => NotificationScreen(),
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);

//   final String? title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   @override
//   void initState() {
//     super.initState();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 channelDescription: channel.description,
//                 color: Colors.blue,
//                 playSound: true,
//                 icon: '@mipmap/ic_launcher',
//               ),
//             ));
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         showDialog(
//             context: context,
//             builder: (_) {
//               return AlertDialog(
//                 title: Text(notification.title!),
//                 content: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [Text(notification.body!)],
//                   ),
//                 ),
//               );
//             });
//       }
//     });
//   }

//   void showNotification() {
//     setState(() {
//       _counter++;
//     });
//     flutterLocalNotificationsPlugin.show(
//         0,
//         "Testing $_counter",
//         "How you doin ?",
//         NotificationDetails(
//             android: AndroidNotificationDetails(channel.id, channel.name,
//                 channelDescription: channel.description,
//                 importance: Importance.high,
//                 color: Colors.blue,
//                 playSound: true,
//                 icon: '@mipmap/ic_launcher')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title!),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: showNotification,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
