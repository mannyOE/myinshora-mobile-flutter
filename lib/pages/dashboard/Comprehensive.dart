import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/models/comps.dart';
import 'package:Myinshora/pages/application/comprehensive/StartComprehensive.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:Myinshora/shared/bottomNav.dart';
import 'package:flutter/material.dart';

class Comprehensive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Navbar(
          title: Text("Comprehensive"),
          bgColor: Color(0xFFF58634),
          leadIcon: Icon(Icons.arrow_back),
          context: context,
        ),
        body: ComprehensiveInsurance(),
        bottomNavigationBar: Bottom(
          currentIndex: 1,
          context: context,
        ),
      ),
    );
  }
}

// Create a Form widget.
class ComprehensiveInsurance extends StatefulWidget {
  @override
  ComprehensiveInsuranceState createState() {
    return ComprehensiveInsuranceState();
  }
}

class ComprehensiveInsuranceState extends State<ComprehensiveInsurance> {
  var userData, comps = new List();
  Iterable list = [
    {
      "name": "Myinshora Basic",
      "color": 0xFFD25900,
      "message": "Basic package for as low as 2.5% per annum",
      "cta": "Buy Myinshora Basic",
      "bouquet": "Comprehensive(Inshora Basic)",
      "type": 1
    },
    {
      "name": "Myinshora Classic",
      "color": 0xFF2A76D5,
      "message": "Classic package for as low as 3% per annum",
      "cta": "Buy Myinshora Classic",
      "bouquet": "Comprehensive(Inshora Classic)",
      "type": 2
    },
    {
      "name": "Myinshora Silver",
      "color": 0xFFF84F86,
      "message": "Silver package for as low as 3.5% per annum",
      "cta": "Buy Myinshora Silver",
      "bouquet": "Comprehensive(Inshora SIlver)",
      "type": 3
    },
    {
      "name": "Myinshora Platinum",
      "color": 0xFF4F3B8F,
      "message": "Platinum package for as low as 4% per annum",
      "cta": "Buy Myinshora Platinum",
      "bouquet": "Comprehensive(Inshora Platinum)",
      "type": 4
    },
    {
      "name": "Myinshora Gold",
      "color": 0xFF62D5DB,
      "message": "Gold package for as low as 5% per annum",
      "cta": "Buy Myinshora Gold",
      "bouquet": "Comprehensive(Inshora Gold)",
      "type": 5
    }
  ];
  Application application;
  @override
  void initState() {
    super.initState();
    setState(() {
      comps = list.map((f) => Comp.fromJson(f)).toList();
    });
  }

  _startApplication(item) {
    application = new Application();
    application.responses = new Responses();
    application.bouquet = item.bouquet;
    application.responses.effectFrom = DateTime.now();
    switch (item.type) {
      case 1:
        application.percent = 2.5;
        application.subClassCoverTypes = new SubClassCoverTypes(
            productId: "f1326cce-47e7-e711-a2be-005056a02281",
            id: "06ee8b29-47e7-e711-a2be-005056a02281",
            productName: "Private Motor Comprehensive",
            subClassName: "Private Motor Comprehensive",
            coverTypeName: "Auto Basic");
        break;
      case 2:
        application.percent = 3.0;
        application.subClassCoverTypes = new SubClassCoverTypes(
            productId: "f1326cce-47e7-e711-a2be-005056a02281",
            id: "8b8cee87-d9ea-e711-a2be-005056a02281",
            productName: "Private Motor Comprehensive",
            subClassName: "Private Motor Comprehensive",
            coverTypeName: "Auto Classic");
        break;
      case 3:
        application.percent = 3.5;
        application.subClassCoverTypes = new SubClassCoverTypes(
            productId: "f1326cce-47e7-e711-a2be-005056a02281",
            id: "c388804b-d9ea-e711-a2be-005056a02281",
            productName: "Private Motor Comprehensive",
            subClassName: "Private Motor Comprehensive",
            coverTypeName: "Auto Deluxe");
        break;
      case 4:
        application.percent = 4.0;
        application.subClassCoverTypes = new SubClassCoverTypes(
            productId: "f1326cce-47e7-e711-a2be-005056a02281",
            id: "cd20dba6-d9ea-e711-a2be-005056a02281",
            productName: "Private Motor Comprehensive",
            subClassName: "Private Motor Comprehensive",
            coverTypeName: "Auto Regular");
        break;
      case 5:
        application.percent = 5.0;
        application.subClassCoverTypes = new SubClassCoverTypes(
            productId: "f1326cce-47e7-e711-a2be-005056a02281",
            id: "02baaf3b-47e7-e711-a2be-005056a02281",
            productName: "Private Motor Comprehensive",
            subClassName: "Private Motor Comprehensive",
            coverTypeName: "Auto Royale");
        break;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StartComprehensive(application: application),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      itemCount: comps.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Color(comps[index].color),
            child: FlatButton(
              onPressed: () {
                _startApplication(comps[index]);
              },
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: <Widget>[
                        Text(
                          comps[index].name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    child: Row(
                      children: <Widget>[
                        Text(comps[index].message,
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
                          comps[index].cta,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
