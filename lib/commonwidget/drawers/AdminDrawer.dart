import 'package:flutter/material.dart';

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

              ListTile(
                onTap: () {},
                leading: Icon(Icons.dashboard),
                title: Text('DashBoard'),
              ),

              ListTile(
                onTap: () {},
                leading: Icon(Icons.manage_accounts),
                title: Text('ManageChild'),
              ),

              ListTile(
                onTap: () {},
                leading: Icon(Icons.manage_accounts_outlined),
                title: Text('Users'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings),
                title: Text('Reports'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings),
                title: Text('Notice'),
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
