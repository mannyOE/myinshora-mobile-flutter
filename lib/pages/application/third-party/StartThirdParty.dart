import 'package:Myinshora/apis/auth.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:Myinshora/shared/widgets/Quote.dart';
import 'package:flutter/material.dart';

class StartThirdParty extends StatelessWidget {
  final Application application;
  StartThirdParty({
    Key key,
    @required this.application,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Navbar(
          context: context,
          title: Text("Thrid Party Insurance"),
          bgColor: Color(0xFFF58634),
          leadIcon: Icon(Icons.arrow_back),
        ),
        body: BuyThirdParty(application: application),
      ),
    );
  }
}

// Create a Form widget.
class BuyThirdParty extends StatefulWidget {
  BuyThirdParty({@required this.application}) : super();
  final Application application;
  @override
  BuyThirdPartyState createState() {
    return BuyThirdPartyState(application: application);
  }
}

class BuyThirdPartyState extends State<BuyThirdParty> {
  BuyThirdPartyState({@required this.application}) : super();
  final Application application;
  bool selected = false, selected2 = false, selected3 = false, loading = false;
  String bodyType, year, make;
  final startKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  __parseBodies(data) {
    if (application.responses.bodyType != null) {
      return data.where((i) => i == application.responses.bodyType).toList()[0];
    }
    return bodyType;
  }

  __parseYears(data) {
    if (application.responses.year != null) {
      return data.where((i) => i == application.responses.year).toList()[0];
    }
    return year;
  }

  __parseMakes(data) {
    if (application.responses.make != null) {
      return data.where((i) => i == application.responses.make).toList()[0];
    }
    return make;
  }

  __getMakes(year) async {
    setState(() {
      loading = true;
    });
    fetchMakes(year).then((onValue) {
      setState(() {
        year = onValue;
        loading = false;
      });
    });
  }

  __getQuote() {
    if (application.responses.bodyType == null) {
      return;
    }
    switch (application.responses.bodyType) {
      case "Bus":
        application.responses.quote = "7500";
        break;
      case "Car":
        application.responses.quote = "5000";
        break;
      case "Jeep - Suv":
        application.responses.quote = "5000";
        break;
      case "Truck":
        application.responses.quote = "10000";
        break;
    }

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            QuoteWidget(application: application),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      child: Form(
        key: startKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: <Widget>[
            Text(
              "Choose your vehicle's body type",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator(
                    backgroundColor: Color(0xFFF58634),
                  );
                }
                return DropdownButton<String>(
                  isExpanded: true,
                  onChanged: (newVal) {
                    setState(() {
                      bodyType = newVal;
                      application.responses.bodyType = newVal;
                      selected = true;
                    });
                  },
                  hint: Text(
                      !selected
                          ? "Select a body type"
                          : __parseBodies(snapshot.data),
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  items: snapshot.data
                      .map((count) => DropdownMenuItem<String>(
                          value: count, child: Text(count)))
                      .toList(),
                );
              },
              future: fetchBodyTypes(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Choose your vehicle's manufacture year",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator(
                    backgroundColor: Color(0xFFF58634),
                  );
                }
                return DropdownButton<String>(
                  isExpanded: true,
                  onChanged: (newVal) {
                    __getMakes(newVal);
                    setState(() {
                      application.responses.year = newVal;
                      year = newVal;
                      selected2 = true;
                    });
                  },
                  hint: Text(
                      !selected2
                          ? "Select manufacture year"
                          : __parseYears(snapshot.data),
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  items: snapshot.data
                      .map((count) => DropdownMenuItem<String>(
                          value: count, child: Text(count)))
                      .toList(),
                );
              },
              future: fetchYears(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Choose your vehicle's make",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButton<String>(
              isExpanded: true,
              onChanged: (newVal) {
                setState(() {
                  application.responses.make = newVal;
                  make = newVal;
                  selected3 = true;
                });
              },
              hint: Text(
                  !selected3 ? "Select vehicle make" : __parseMakes(makes),
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              items: makes != null
                  ? makes
                      .map((count) => DropdownMenuItem<String>(
                          value: count, child: Text(count)))
                      .toList()
                  : [],
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              color: Color(0xFFF58634),
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      "Get Quote",
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                if (startKey.currentState.validate()) {
                  __getQuote();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
