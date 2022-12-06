import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:little_miracles_orphange/firebase_options.dart';
import 'package:little_miracles_orphange/screens/signIn/SignInScreen.dart';

import 'package:little_miracles_orphange/screens/signup/SignUpScreen.dart';
import 'package:little_miracles_orphange/screens/welcome_screen/WelcomeScreen.dart';

import 'package:little_miracles_orphange/utils/screens_routes/ScreenRoutes.dart';
import 'package:little_miracles_orphange/utils/themes/PrimaryTheme.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

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
        bottomAppBarColor: PrimaryTheme.colorCustom
      ),
      initialRoute: ScreenRoutes.signInScreen,
      routes: {
        ScreenRoutes.welcomeScreen:(context) => WelcomeScreen(),
        ScreenRoutes.signUpScreen:(context) => SignUpScreen(),
        ScreenRoutes.signInScreen:(context) => SignInScreen()
      },
    );
  }
}
