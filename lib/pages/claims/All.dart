import 'package:Myinshora/apis/insurances.dart';
import 'package:Myinshora/models/Claims.dart';
import 'package:Myinshora/shared/AppCard.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:Myinshora/shared/bottomNav.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class Claims extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Navbar(
          title: Text(
            "Claims",
            style: TextStyle(color: Colors.white70),
          ),
          bgColor: Color(0xFFF58634),
          leadIcon: Icon(Icons.arrow_back),
          context: context,
        ),
        body: ListClaim(),
        bottomNavigationBar: Bottom(
          currentIndex: 2,
          context: context,
        ),
      ),
    );
  }
}

// Create a Form widget.
class ListClaim extends StatefulWidget {
  @override
  ListClaimState createState() {
    return ListClaimState();
  }
}

class ListClaimState extends State<ListClaim> {
  bool loading = false;
  var claimsList = new List<ClaimsModel>();
  @override
  void initState() {
    super.initState();
    __getClaims();
  }

  __getClaims() async {
    setState(() {
      loading = true;
    });
    fetchClaims().then((onValue) {
      setState(() {
        Iterable list = convert.jsonDecode(onValue)['claims'].reversed;
        claimsList = list.map((model) => ClaimsModel.fromJson(model)).toList();
        loading = false;
      });
    });
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
            child: claimsList.length > 0
                ? ListView.builder(
                    itemCount: claimsList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 190,
                        width: MediaQuery.of(context).size.width,
                        child: Card(color: Colors.white, child: Container()),
                      );
                    },
                  )
                : noClaims(context),
          );
  }
}
