import 'package:Myinshora/apis/insurances.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/models/globals.dart' as prefix0;
import 'package:Myinshora/pages/dashboard/ViewApplication.dart';
import 'package:Myinshora/shared/AppCard.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:Myinshora/shared/bottomNav.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Navbar(
          bgColor: Color(0xFFF58634),
          title: Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
          context: context,
        ),
        body: TheDashboard(),
        bottomNavigationBar: Bottom(
          currentIndex: 0,
          context: context,
        ),
      ),
    );
  }
}

// Create a Form widget.
class TheDashboard extends StatefulWidget {
  @override
  TheDashboardState createState() {
    return TheDashboardState();
  }
}

class TheDashboardState extends State<TheDashboard> {
  bool loading = false;
  var applications = new List<Application>();
  @override
  void initState() {
    super.initState();
    _getApps();
  }

  _getApps() {
    setState(() {
      loading = true;
    });
    fetchInsurances().then((response) {
      setState(() {
        Iterable list = convert.jsonDecode(response)['applications'].reversed;
        applications =
            list.map((model) => Application.fromJson(model)).toList();
        loading = false;
      });
    });
  }

  showSingle(app) {
    Application application = app;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewApplication(application: application),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: applications.length > 0
                ? ListView.builder(
                    itemCount: applications.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 190,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: Colors.white,
                          child: FlatButton(
                            onPressed: () {
                              showSingle(applications[index]);
                            },
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 17),
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xFFECECEC), width: 1),
                                  )),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            applications[index].bouquet,
                                            style: TextStyle(
                                                color: Color(0xFFF58634),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            color:
                                                applications[index].complete !=
                                                            null &&
                                                        applications[index]
                                                                .complete !=
                                                            false
                                                    ? Color(0xFF6ADD0E)
                                                    : Color(0xFFFD5262),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3),
                                            child: Text(
                                              applications[index].complete !=
                                                          null &&
                                                      applications[index]
                                                              .complete !=
                                                          false
                                                  ? "Complete"
                                                  : "Incomplete",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[Text("Policy Number")],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(applications[index].complete !=
                                                    null &&
                                                applications[index].complete !=
                                                    false &&
                                                applications[index].payment !=
                                                    null
                                            ? "#" +
                                                applications[index]
                                                    .payment
                                                    .policies[0]
                                            : "NA")
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[Text("Expiry Date")],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(applications[index].complete !=
                                                    null &&
                                                applications[index].complete !=
                                                    false &&
                                                applications[index].payment !=
                                                    null
                                            ? applications[index].payment.wet
                                            : "NA")
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[Text("Premium")],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(prefix0.naira +
                                            applications[index].responses.quote)
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : noApps(context),
          );
  }
}
