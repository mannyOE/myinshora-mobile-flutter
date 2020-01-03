import 'package:Myinshora/pages/auth/Login.dart';
import 'package:Myinshora/pages/dashboard/security.dart';
import 'package:Myinshora/pages/dashboard/userProfile.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:Myinshora/shared/bottomNav.dart';
import 'package:Myinshora/store/userMgt.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: Navbar(
          bgColor: Color(0xFFF58634),
          title: Text("Profile"),
          context: context,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                removeUser();
                removeToken();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
            )
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Tab>[
              new Tab(
                text: "PERSONAL",
              ),
              new Tab(
                text: "SECURITY",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[TheProfile(), Security()],
        ),
        bottomNavigationBar: Bottom(
          currentIndex: 3,
          context: context,
        ),
      ),
    ));
  }
}
