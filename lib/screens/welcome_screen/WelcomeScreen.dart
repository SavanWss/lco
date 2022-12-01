import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

import 'package:little_miracles_orphange/commonwidget/drawers/AdminDrawer.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> placeHolderList = [
      "Name",
      "Email",
      "Number",
      "Password",
      "confirmPassword"
    ];

    name(value) {
      print('your firts name is === ${value}');
    }

    email(value) {
      print('your email is === ${value}');
    }

    nummber(value) {
      print('your number is === ${value}');
    }

    password(value) {
      print('your password is === ${value}');
    }

    cpassword(value) {
      print('your  cpassword is === ${value}');
    }

    // final _tabBarKey = GlobalKey(TabBarView)

    // final GlobalKey<TabBar> fileListKey = new GlobalKey<TabBar>();

    var functions = [name, email, nummber, password, cpassword];

    var width = MediaQuery.of(context).size.width;

    final _textEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: AnimSearchBar(
          textController: _textEditingController,
          width: width,
          onSuffixTap: () {
            print(_textEditingController.text);
            setState(() {
              _textEditingController.text = "";
            });
          },
          animationDurationInMilli: 1000,
          closeSearchOnSuffixTap: true,
          helpText: "search here!!!.",
          rtl: true,
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.search_outlined)),
      drawer: AdminDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.abc), label: "rtgs", tooltip: "tooltip"),
          BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: "ntfs",
              tooltip: "tyhj",
              activeIcon: Icon(Icons.abc_rounded))
        ],
      ),
    );
  }
}

class _testdesign extends State<WelcomeScreen> {
  List<String> myfield = ['first name', 'last name', 'age', 'phone no'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset("assets/images/logo.png"),
          for (int i = 0; i < myfield.length; i++) ...[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(hintText: myfield[i]),
              ),
            )
          ],
        ],
      ),
    );
  }
}
