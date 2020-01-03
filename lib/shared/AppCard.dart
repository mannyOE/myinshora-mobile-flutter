import 'dart:io';

import 'package:Myinshora/pages/dashboard/Buy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appCard(BuildContext context, List application) {
  return Container(
    height: 150,
    width: MediaQuery.of(context).size.width,
    child: Card(
      color: Colors.white,
      child: Padding(
        child: app(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
    ),
  );
}

Widget app() {
  return Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 17),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Color(0xFFECECEC), width: 1),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "3rd Party Motor",
                  style: TextStyle(
                      color: Color(0xFFF58634),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              ],
            ),
            Column(
              children: <Widget>[Text("Completed")],
            )
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[Text("Policy Number")],
          ),
          Column(
            children: <Widget>[Text("Expiry Date")],
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[Text("NA")],
          ),
          Column(
            children: <Widget>[Text("NA")],
          )
        ],
      ),
    ],
  );
}

Widget noApps(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30),
    color: Color(0xFFECECEC),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Align(
          heightFactor: 1.2,
          alignment: Alignment.bottomCenter,
          child: Image.asset("assets/slide1.png"),
        ),
        Align(
          heightFactor: Platform.isIOS ? 4 : 1,
          alignment: Alignment.bottomCenter,
          child: Column(
            children: <Widget>[
              Text(
                "No Insurance Activity",
                style: TextStyle(
                    color: Color(0xFF737373),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Align(
          heightFactor: 2,
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
              elevation: 0,
              color: Color(0xFFA8518A),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Text(
                "Buy Insurance",
                style: TextStyle(color: Color(0xFFFFFFFF)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Buy(),
                  ),
                );
              }),
        ),
      ],
    ),
  );
}

Widget noClaims(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30),
    color: Color(0xFFECECEC),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Align(
          heightFactor: 1.3,
          alignment: Alignment.bottomCenter,
          child: Image.asset("assets/slide1.png"),
        ),
        Align(
          heightFactor: 1.3,
          alignment: Alignment.bottomCenter,
          child: Column(
            children: <Widget>[
              Text(
                "No Claims Activity",
                style: TextStyle(
                    color: Color(0xFF737373),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Align(
          heightFactor: 1.3,
          alignment: Alignment.bottomCenter,
          child: Column(
            children: <Widget>[],
          ),
        ),
      ],
    ),
  );
}
