import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/pages/application/third-party/StartThirdParty.dart';
import 'package:Myinshora/pages/application/travel/StartTravel.dart';
import 'package:Myinshora/pages/dashboard/Comprehensive.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:Myinshora/shared/bottomNav.dart';
import 'package:flutter/material.dart';

class Buy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Navbar(
          title: Text(
            "Buy Insurance",
            style: TextStyle(color: Colors.white70),
          ),
          context: context,
          bgColor: Color(0xFFF58634),
        ),
        body: BuyInsurance(),
        bottomNavigationBar: Bottom(
          currentIndex: 1,
          context: context,
        ),
      ),
    );
  }
}

// Create a Form widget.
class BuyInsurance extends StatefulWidget {
  @override
  BuyInsuranceState createState() {
    return BuyInsuranceState();
  }
}

class BuyInsuranceState extends State<BuyInsurance> {
  Application application;
  _startTravel() {
    application = new Application();
    application.responses = new Responses();
    application.responses.startDate = DateTime.now();
    application.responses.endDate = DateTime.now();
    application.responses.passportExpiryDate = DateTime.now();
    application.subClassCoverTypes = SubClassCoverTypes();
    application.subClassCoverTypes.productId =
        "cb00e3f3-9feb-e711-a2be-005056a02281";
    application.subClassCoverTypes.productName = "Travel";
    application.subClassCoverTypes.subClassName = "Travel Insurance";
    application.bouquet = "General Travel Insurance";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StartTravel(application: application),
      ),
    );
  }

  _startThirdParty() {
    application = Application();
    application.responses = Responses();
    application.subClassCoverTypes = SubClassCoverTypes();
    application.responses.effectFrom = DateTime.now();
    application.subClassCoverTypes.productId =
        "fef672bd-faf1-e711-a2c0-005056a02281";
    application.subClassCoverTypes.id = "dd55d886-fcf1-e711-a2c0-005056a02281";
    application.subClassCoverTypes.productName = "Private Motor 3rd Party";
    application.subClassCoverTypes.subClassName = "Private Motor 3rd Party";
    application.subClassCoverTypes.coverTypeName = "Third Party Only";
    application.bouquet = "3rd Party (Motor)";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StartThirdParty(application: application),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 320,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: new Wrap(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Buy Auto Insurance",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF58634),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Select Insurance Type",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF737373)),
                    )
                  ],
                ),
                Container(
                  height: 80,
                  margin: EdgeInsets.only(top: 20),
                  color: Color(0xFFF2F4F7),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                      leading: Container(
                        height: 60,
                        width: 60,
                        child: Image.asset("assets/3rd.png"),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      title: new Text(
                        '3rd Party Insurance',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        _startThirdParty();
                      }),
                ),
                Container(
                  height: 80,
                  color: Color(0xFFF2F4F7),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    leading: Container(
                      height: 60,
                      width: 60,
                      child: Image.asset("assets/cp.png"),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    title: new Text(
                      'Comprehensive Insurance',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Comprehensive(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      children: <Widget>[
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Color(0xFF00CB3C),
            child: FlatButton(
              onPressed: () {
                _settingModalBottomSheet(context);
              },
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Auto Insurance",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Image.asset("assets/racing.png", width: 80),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    child: Row(
                      children: <Widget>[
                        Text("Insure your vehicles",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(color: Color(0xFFECECEC), width: 1),
                    )),
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          "Buy Auto Insurance",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Color(0xFF0041C4),
            child: FlatButton(
              onPressed: () {
                _startTravel();
              },
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Travel Insurance",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Image.asset("assets/air-transport.png", width: 80)
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    child: Row(
                      children: <Widget>[
                        Text("Insure your travel",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(color: Color(0xFFECECEC), width: 1),
                    )),
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          "Buy Travel Insurance",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
