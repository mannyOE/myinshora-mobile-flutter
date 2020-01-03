import 'package:Myinshora/apis/auth.dart';
import 'package:Myinshora/apis/insurances.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/models/Gender.dart';
import 'package:Myinshora/models/globals.dart' as prefix0;
import 'package:Myinshora/shared/Navbar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class UploadComprehensive extends StatelessWidget {
  final Application application;
  UploadComprehensive({
    Key key,
    @required this.application,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Navbar(
          bgColor: Color(0xFFF58634),
          title: Text(application.bouquet),
          context: context,
          leadIcon: Icon(Icons.arrow_back),
        ),
        body: UploadsComprehensive(application: application),
      ),
    );
  }
}

// Create a Form widget.
class UploadsComprehensive extends StatefulWidget {
  UploadsComprehensive({@required this.application}) : super();
  final Application application;
  @override
  UploadsComprehensiveState createState() {
    return UploadsComprehensiveState(application: application);
  }
}

class UploadsComprehensiveState extends State<UploadsComprehensive> {
  UploadsComprehensiveState({@required this.application}) : super();
  Application application;
  Titles selectedTitle;
  final format = DateFormat("yyyy-MM-dd");
  bool selected = false, selected2 = false, loading = false;
  String quote, year;
  @override
  void initState() {
    super.initState();
    quote = application.responses.quote.toString();
    print("dd");
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 250,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Spacer(
                        flex: 2,
                      ),
                      Text(
                        "Make Payment",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Insurance Type",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      application.bouquet.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Insurance Premium",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      prefix0.naira + application.responses.quote.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                    )
                  ],
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
                      onPressed: () {},
                      child: loading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Row(
                              children: <Widget>[
                                Text(
                                  "Pay " +
                                      prefix0.naira +
                                      application.responses.quote.toString(),
                                  style: TextStyle(color: Colors.white),
                                  textScaleFactor: 1.3,
                                ),
                                Spacer(),
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                )
                              ],
                            )),
                ),
              ],
            ),
          );
        });
  }

  __parseYears(data) {
    if (application.responses.year != null) {
      return data.where((i) => i == application.responses.year).toList()[0];
    }
    return year;
  }

  __applyNow() async {
    try {
      setState(() {
        loading = true;
      });
      apply(application.toJson()).then((onValue) {
        setState(() {
          loading = false;
        });
        _settingModalBottomSheet(context);
      });
    } catch (e) {
      print(e);
    }
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
            "Select Vehicle Model",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          FutureBuilder(
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return DropdownButton<String>(
                isExpanded: true,
                onChanged: (newVal) {
                  // fetchMakes(newVal);
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
            "Select Vehicle Color",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          FutureBuilder(
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return DropdownButton<String>(
                isExpanded: true,
                onChanged: (newVal) {
                  // fetchMakes(newVal);
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
            "File Upload (Valid Identification)",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          TextFormField(
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
                      "Finish",
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
