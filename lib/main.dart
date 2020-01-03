import 'package:Myinshora/pages/dashboard/Main.dart';
import 'package:Myinshora/store/userMgt.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'pages/onboarding.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      theme: ThemeData(
        fontFamily: 'Avenir',
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(
      Duration(seconds: 2),
      () async {
        var user = await readUser();
        Navigator.of(context).pop();
        if (user == null) {
          SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Onboarding(),
            ),
          );
        } else {
          SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              child: Image.asset("assets/logo1.png"),
              height: 110,
            ),
          )
        ],
      ),
    );
  }
}
