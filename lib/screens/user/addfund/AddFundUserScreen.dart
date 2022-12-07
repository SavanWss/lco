import 'package:flutter/material.dart';
import 'package:little_miracles_orphange/commonwidget/drawers/UserDrawer.dart';

class AddFundUserScreen extends StatefulWidget {
  const AddFundUserScreen({super.key});

  @override
  State<AddFundUserScreen> createState() => _AddFundUserScreenState();
}

class _AddFundUserScreenState extends State<AddFundUserScreen> {
  Future<String> getData() {
    return Future.delayed(Duration(seconds: 10), () {
      return "I am data";
      // throw Exception("Custom Error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: UserDrawer(),
      body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // for error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                final data = snapshot.data as String;
                return Center(
                  child: Text(
                    '$data',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getData()),
    );
  }
}
