import 'package:Myinshora/shared/widgets/Quote.dart';
import 'package:Myinshora/apis/auth.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:flutter/material.dart';

class StartComprehensive extends StatelessWidget {
  final Application application;
  StartComprehensive({
    Key key,
    @required this.application,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Navbar(
          context: context,
          title: Text(application.bouquet),
          bgColor: Color(0xFFF58634),
          leadIcon: Icon(Icons.arrow_back),
        ),
        body: BuyComprehensive(application: application),
      ),
    );
  }
}

// Create a Form widget.
class BuyComprehensive extends StatefulWidget {
  BuyComprehensive({@required this.application}) : super();
  final Application application;
  @override
  BuyComprehensiveState createState() {
    return BuyComprehensiveState(application: application);
  }
}

class BuyComprehensiveState extends State<BuyComprehensive> {
  BuyComprehensiveState({@required this.application}) : super();
  final Application application;
  bool selected = false, selected2 = false, selected3 = false, loading = false;
  String bodyType, year, make;

  @override
  void initState() {
    super.initState();
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
    if (application.percent != null &&
        application.responses.vehicleValue != null) {
      var qt = application.percent * application.responses.vehicleValue;
      qt = qt / 100;
      var tt = qt.toString();
      application.responses.quote = tt.split(".")[0];
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
              QuoteWidget(application: application),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
        child: ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      children: <Widget>[
        Text(
          "Enter your vehicle's Current Value",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          initialValue: application.responses.vehicleValue != null
              ? application.responses.vehicleValue.toString()
              : '',
          onChanged: (val) {
            setState(() {
              application.responses.vehicleValue = int.parse(val);
            });
          },
          style: TextStyle(fontSize: 16, color: Colors.black),
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
          hint: Text(!selected3 ? "Select vehicle make" : __parseMakes(makes),
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
            __getQuote();
          },
        )
      ],
    ));
  }
}
