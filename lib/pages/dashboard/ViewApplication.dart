import 'package:Myinshora/apis/auth.dart';
import 'package:Myinshora/apis/insurances.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/models/Claims.dart';
import 'package:Myinshora/models/globals.dart' as prefix0;
import 'package:Myinshora/pages/application/third-party/FinishThirdParty.dart';
import 'package:Myinshora/pages/application/travel/FinishTravel.dart';
import 'package:Myinshora/pages/claims/Motor.dart';
import 'package:Myinshora/pages/claims/Travel.dart';
import 'package:Myinshora/pages/dashboard/Main.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

import 'package:url_launcher/url_launcher.dart';

class ViewApplication extends StatelessWidget {
  final Application application;
  ViewApplication({
    Key key,
    @required this.application,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Navbar(
          title: Text("Single Application"),
          bgColor: Color(0xFFF58634),
          leadIcon: Icon(Icons.arrow_back),
          context: context,
        ),
        body: ViewApp(
          application: application,
        ),
      ),
    );
  }
}

// Create a Form widget.
class ViewApp extends StatefulWidget {
  final Application application;
  ViewApp({
    Key key,
    @required this.application,
  }) : super(key: key);
  @override
  ViewAppState createState() {
    return ViewAppState(application: application);
  }
}

class ViewAppState extends State<ViewApp> {
  final Application application;
  bool loading = false;
  Country country = new Country();
  ViewAppState({
    Key key,
    @required this.application,
  }) : super();
  @override
  void initState() {
    super.initState();
  }

  __deleteApp() async {
    deleteInsurance(application.id).then((onValue) {
      var jsonResponse = convert.jsonDecode(onValue);
      Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xFFF58634),
          content: Text(jsonResponse['message'])));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    });
  }

  __startClaim() {
    var claim = new ClaimsModel();
    claim.application = application.id;
    claim.user = application.user.id;
    claim.policyNumber = application.payment.policies[0];
    if (application.bouquet.contains("3rd") ||
        application.bouquet.contains("Comprehensive")) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClaimMotor(claim: claim),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClaimTravel(
            claim: claim,
          ),
        ),
      );
    }
  }

  __continueApp() {
    if (application.complete != null && application.complete != false) {
    } else {
      if (application.bouquet.contains("3rd") ||
          application.bouquet.contains("Comprehensive")) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinishThirdParty(application: application),
          ),
        );
      }
      if (application.bouquet.contains("General")) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinishTravel(application: application),
          ),
        );
      }
    }
  }

  _launchURL(url) async {
    if (await canLaunch(prefix0.server + url)) {
      await launch(prefix0.server + url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 0),
      children: <Widget>[
        application.bouquet.contains("General")
            ? Card(
                // card for travel insurance
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 17),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFECECEC), width: 1),
                        )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  application.bouquet,
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
                                  color: application.complete
                                      ? Color(0xFF6ADD0E)
                                      : Color(0xFFFD5262),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  child: Text(
                                    application.complete
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[Text("Policy Number")],
                          ),
                          Column(
                            children: <Widget>[
                              Text(application.complete &&
                                      application.payment != null
                                  ? application.payment.policies[0]
                                  : "NA")
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[Text("Expiry Date")],
                          ),
                          Column(
                            children: <Widget>[
                              Text(application.complete &&
                                      application.payment != null
                                  ? application.payment.wet
                                  : "NA")
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[Text("Premium")],
                          ),
                          Column(
                            children: <Widget>[
                              Text(application.responses.quote),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[Text("Destination Country")],
                          ),
                          Column(
                            children: <Widget>[
                              FutureBuilder(
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Country>> snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  }
                                  country = snapshot.data
                                      .where((i) =>
                                          i.id ==
                                          application.responses.destination)
                                      .toList()[0];
                                  return Text(country.name);
                                },
                                future: fetchCountries(),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[Text("Take off date")],
                          ),
                          Column(
                            children: <Widget>[
                              Text(DateFormat.yMMMMd()
                                  .format(application.responses.startDate)
                                  .toString())
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[Text("Return date")],
                          ),
                          Column(
                            children: <Widget>[
                              Text(DateFormat.yMMMMd()
                                  .format(application.responses.endDate)
                                  .toString())
                            ],
                          )
                        ],
                      ),
                      application.complete == null ||
                              application.complete == false
                          ? Container(
                              padding: EdgeInsets.fromLTRB(0, 17, 0, 0),
                              margin: EdgeInsets.fromLTRB(0, 17, 0, 0),
                              decoration: BoxDecoration(
                                  border: Border(
                                top: BorderSide(
                                    color: Color(0xFFECECEC), width: 1),
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      FlatButton(
                                        color: Color(0xFFF58634),
                                        onPressed: () {
                                          __continueApp();
                                        },
                                        child: Text(
                                          'Continue Application',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {
                                          __deleteApp();
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Color(0xFFFD5262),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.fromLTRB(0, 17, 0, 0),
                              margin: EdgeInsets.fromLTRB(0, 17, 0, 0),
                              decoration: BoxDecoration(
                                  border: Border(
                                top: BorderSide(
                                    color: Color(0xFFECECEC), width: 1),
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      !application.claimInProgress
                                          ? FlatButton(
                                              color: Color(0xFFF58634),
                                              onPressed: () {
                                                __startClaim();
                                              },
                                              child: Text(
                                                'Make Claim',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            )
                                          : FlatButton(
                                              color: Color(0xFFF58634),
                                              onPressed: () {},
                                              child: Text(
                                                'Claim In Progress',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      FlatButton(
                                        color: Color(0xFFF58634),
                                        onPressed: () {
                                          _launchURL(application.policy);
                                        },
                                        child: Text(
                                          'Open Policy',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              )
            : Card(
                // card for motor insurance
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 17),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFECECEC), width: 1),
                        )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  application.bouquet,
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
                                  color: application.complete != null &&
                                          application.complete != false
                                      ? Color(0xFF6ADD0E)
                                      : Color(0xFFFD5262),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  child: Text(
                                    application.complete != null &&
                                            application.complete != false
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[Text("Policy Number")],
                          ),
                          Column(
                            children: <Widget>[
                              Text(application.complete != null &&
                                      application.complete != false &&
                                      application.payment != null
                                  ? application.payment.policies[0]
                                  : "NA")
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[Text("Premium")],
                          ),
                          Column(
                            children: <Widget>[
                              Text(prefix0.naira + application.responses.quote),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[Text("Expiry Date")],
                          ),
                          Column(
                            children: <Widget>[
                              Text(application.complete != null &&
                                      application.complete != false &&
                                      application.payment != null
                                  ? application.payment.wet
                                  : "NA")
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[Text("Bouquet")],
                          ),
                          Column(
                            children: <Widget>[Text(application.bouquet)],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      application.bouquet.contains("Comp")
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text("Vehicle's Current Value")
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(application.responses.vehicleValue
                                        .toString())
                                  ],
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text("Vehicle's Body Type")
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(application.responses.bodyType)
                                  ],
                                )
                              ],
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("Vehicle's Manufacture year")
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(application.responses.year)
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[Text("Vehicle's Make")],
                          ),
                          Column(
                            children: <Widget>[
                              Text(application.responses.make)
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      application.complete == null ||
                              application.complete == false
                          ? Container(
                              padding: EdgeInsets.fromLTRB(0, 17, 0, 0),
                              margin: EdgeInsets.fromLTRB(0, 17, 0, 0),
                              decoration: BoxDecoration(
                                  border: Border(
                                top: BorderSide(
                                    color: Color(0xFFECECEC), width: 1),
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      FlatButton(
                                        color: Color(0xFFF58634),
                                        onPressed: () {
                                          __continueApp();
                                        },
                                        child: Text(
                                          'Continue Application',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {
                                          __deleteApp();
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Color(0xFFFD5262),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.fromLTRB(0, 17, 0, 0),
                              margin: EdgeInsets.fromLTRB(0, 17, 0, 0),
                              decoration: BoxDecoration(
                                  border: Border(
                                top: BorderSide(
                                    color: Color(0xFFECECEC), width: 1),
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      !application.claimInProgress
                                          ? FlatButton(
                                              color: Color(0xFFF58634),
                                              onPressed: () {
                                                __startClaim();
                                              },
                                              child: Text(
                                                'Make Claim',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            )
                                          : FlatButton(
                                              color: Color(0xFFF58634),
                                              onPressed: () {},
                                              child: Text(
                                                'Claim In Progress',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      FlatButton(
                                        color: Color(0xFFF58634),
                                        onPressed: () {
                                          _launchURL(application.policy);
                                        },
                                        child: Text(
                                          'Open Policy',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              )
      ],
    );
  }
}
