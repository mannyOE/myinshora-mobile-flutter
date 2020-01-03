import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:flutter/material.dart';

class InitComprehensive extends StatelessWidget {
  final Application application;
  InitComprehensive({
    Key key,
    @required this.application,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Navbar(
          title: Text("Buy Comprehensive"),
          context: context,
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
  final int stage = 1;

  @override
  void initState() {
    super.initState();
    application.agencyId = "RIP";
  }

  @override
  Widget build(BuildContext context) {
    Widget currentForm, formTwo;

    // Build a Form widget using the _formKey created above.
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      children: <Widget>[currentForm, formTwo],
    );
  }
}
