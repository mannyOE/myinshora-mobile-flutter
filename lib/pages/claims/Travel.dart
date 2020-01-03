import 'package:Myinshora/models/Claims.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:flutter/material.dart';

class ClaimTravel extends StatelessWidget {
  final ClaimsModel claim;
  ClaimTravel({
    Key key,
    @required this.claim,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Navbar(
          title: Text("Make a claim (Travel)"),
          bgColor: Color(0xFFF58634),
          leadIcon: Icon(Icons.arrow_back),
          context: context,
        ),
        body: MakeClaim(
          claim: claim,
        ),
      ),
    );
  }
}

// Create a Form widget.
class MakeClaim extends StatefulWidget {
  final ClaimsModel claim;
  MakeClaim({
    Key key,
    @required this.claim,
  }) : super(key: key);
  @override
  MakeClaimState createState() {
    return MakeClaimState(claim: claim);
  }
}

class MakeClaimState extends State<MakeClaim> {
  final ClaimsModel claim;
  bool loading = false;
  MakeClaimState({
    Key key,
    @required this.claim,
  }) : super();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 0),
      children: <Widget>[],
    );
  }
}
