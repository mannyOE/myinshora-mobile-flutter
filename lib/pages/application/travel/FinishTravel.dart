import 'package:Myinshora/apis/auth.dart';
import 'package:Myinshora/apis/insurances.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/models/Gender.dart';
import 'package:Myinshora/pages/application/travel/UploadTravel.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class FinishTravel extends StatelessWidget {
  final Application application;
  FinishTravel({
    Key key,
    @required this.application,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Navbar(
          bgColor: Color(0xFFF58634),
          title: Text("Buy Travel Insurance"),
          context: context,
          leadIcon: Icon(Icons.arrow_back),
        ),
        body: CompleteTravel(application: application),
      ),
    );
  }
}

// Create a Form widget.
class CompleteTravel extends StatefulWidget {
  CompleteTravel({@required this.application}) : super();
  final Application application;
  @override
  CompleteTravelState createState() {
    return CompleteTravelState(application: application);
  }
}

class CompleteTravelState extends State<CompleteTravel> {
  CompleteTravelState({@required this.application}) : super();
  Application application;
  Titles selectedTitle;
  final format = DateFormat("yyyy-MM-dd");
  bool selected = false, selected2 = false, loading = false;
  @override
  void initState() {
    super.initState();
    print("dd");
  }

  __applyNow() async {
    try {
      setState(() {
        loading = true;
      });
      Application app = application;

      apply(app.toJson()).then((onValue) {
        var jsonResponse = convert.jsonDecode(onValue)['application'];
        app = Application.fromJson(jsonResponse);
        setState(() {
          loading = false;
          application = app;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadPage(application: app),
          ),
        );
      });
    } catch (e) {
      print(e);
    }
  }

  __parseCondition() {
    if (application.responses.preMedicalCondition != null) {
      return application.responses.preMedicalCondition;
    }
    return "Select Yes/No";
  }

  __parseTitle(data) {
    if (application.user.title != null) {
      return data.where((i) => i.id == application.user.title).toList()[0].name;
    }
    if (!selected) {
      return "Select a title";
    }
    return selectedTitle.name;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      padding: EdgeInsets.only(bottom: 50, right: 20, left: 20),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        children: <Widget>[
          Text(
            "What is your title?",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            builder:
                (BuildContext context, AsyncSnapshot<List<Titles>> snapshot) {
              if (!snapshot.hasData) {
                return LinearProgressIndicator(
                  backgroundColor: Color(0xFFF58634),
                );
              }
              return DropdownButton<Titles>(
                isExpanded: true,
                onChanged: (newVal) {
                  setState(() {
                    application.user.title = newVal.id;
                    selected = true;
                  });
                },
                hint: Text(__parseTitle(snapshot.data),
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                items: snapshot.data.reversed
                    .map((title) => DropdownMenuItem<Titles>(
                        value: title, child: Text(title.name)))
                    .toList(),
              );
            },
            future: fetchTitles(),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Pre-existing Medical Condition?",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButton<String>(
            isExpanded: true,
            onChanged: (newVal) {
              setState(() {
                application.responses.preMedicalCondition = newVal;
                selected2 = true;
              });
            },
            hint: Text(__parseCondition(),
                style: TextStyle(fontSize: 16, color: Colors.black)),
            items: ["Yes", "No"]
                .map((count) =>
                    DropdownMenuItem<String>(value: count, child: Text(count)))
                .toList(),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "If yes, State the condition",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          TextFormField(
            textInputAction: TextInputAction.continueAction,
            maxLines: 2,
            initialValue: application.responses.medicalCOndition,
            onChanged: (val) {
              setState(() {
                application.responses.medicalCOndition = val;
              });
            },
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Purpose for travel",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            maxLines: 2,
            initialValue: application.responses.travelPurpose,
            onChanged: (val) {
              setState(() {
                application.responses.travelPurpose = val;
              });
            },
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Next of Kin Name?",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            initialValue: application.responses.nokName,
            onChanged: (val) {
              setState(() {
                application.responses.nokName = val;
              });
            },
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Relationship with Next of Kin?",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            initialValue: application.responses.nokRelationship,
            onChanged: (val) {
              setState(() {
                application.responses.nokRelationship = val;
              });
            },
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Next of Kin Address?",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            initialValue: application.responses.nokAddr,
            onChanged: (val) {
              setState(() {
                application.responses.nokAddr = val;
              });
            },
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xFFF58634),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0))),
            child: FlatButton(
              onPressed: () {
                __applyNow();
              },
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                      textScaleFactor: 1.3,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
