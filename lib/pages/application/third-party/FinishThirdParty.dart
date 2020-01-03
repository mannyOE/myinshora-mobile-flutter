import 'package:Myinshora/apis/auth.dart';
import 'package:Myinshora/apis/insurances.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/models/Gender.dart';
import 'package:Myinshora/pages/application/third-party/UploadThirdParty.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

class FinishThirdParty extends StatelessWidget {
  final Application application;
  FinishThirdParty({
    Key key,
    @required this.application,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: Navbar(
          title: Text(application.bouquet),
          bgColor: Color(0xFFF58634),
          leadIcon: Icon(Icons.arrow_back),
          context: context,
        ),
        body: CompleteThridParty(application: application),
      ),
    );
  }
}

// Create a Form widget.
class CompleteThridParty extends StatefulWidget {
  CompleteThridParty({@required this.application}) : super();
  final Application application;
  @override
  CompleteThridPartyState createState() {
    return CompleteThridPartyState(application: application);
  }
}

class CompleteThridPartyState extends State<CompleteThridParty> {
  CompleteThridPartyState({@required this.application}) : super();
  final Application application;
  bool selected = false, loading = false;
  Category selectedCategory;
  final format = DateFormat("yyyy-MM-dd");
  final finishKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  __applyNow(context) async {
    Application app = application;
    app.activated = false;
    app.complete = false;
    apply(app.toJson()).then((onValue) {
      var jsonResponse = convert.jsonDecode(onValue)['application'];
      app = Application.fromJson(jsonResponse);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadThirdParty(application: app),
        ),
      );
    });
  }

  __parsecategory(data) {
    if (application.responses.category != "") {
      return data
          .where((i) => i.id == application.responses.category)
          .toList()[0]
          .name;
    }
    if (!selected) {
      return "Select a category";
    }
    return selectedCategory.name;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: Form(
        key: finishKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          children: <Widget>[
            Text(
              "Select a category?",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
              builder: (BuildContext context,
                  AsyncSnapshot<List<Category>> snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator(
                    value: null,
                    backgroundColor: Color(0xFFF58634),
                  );
                }
                return DropdownButton<Category>(
                  isExpanded: true,
                  onChanged: (newVal) {
                    setState(() {
                      selectedCategory = newVal;
                      application.responses.category = newVal.id;
                      selected = true;
                    });
                  },
                  hint: Text(__parsecategory(snapshot.data),
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  items: snapshot.data
                      .map((cat) => DropdownMenuItem<Category>(
                          value: cat, child: Text(cat.name)))
                      .toList(),
                );
              },
              future: fetchCategories(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Vehicle Plate Number",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter License Plate Number';
                }
                return null;
              },
              initialValue: application.responses.numberPlate,
              onChanged: (val) {
                setState(() {
                  application.responses.numberPlate = val;
                });
              },
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Vehicle Chasis Number",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              initialValue: application.responses.chasis,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter Chasis Number';
                }
                return null;
              },
              onChanged: (val) {
                setState(() {
                  application.responses.chasis = val;
                });
              },
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Vehicle Engine Number",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              initialValue: application.responses.engine,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter Engine Number';
                }
                return null;
              },
              onChanged: (val) {
                setState(() {
                  application.responses.engine = val;
                });
              },
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Insurance Cover Effect from",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            DateTimeFormField(
                onlyDate: true,
                initialValue: application.responses.effectFrom,
                label: "Select a date",
                validator: (value) {
                  if (value.isBefore(DateTime.now())) {
                    return 'Choose a date in the future';
                  }
                  return null;
                },
                onSaved: (DateTime dateTime) => this.setState(() {
                      application.responses.effectFrom = dateTime;
                    })),
            // DateTimeField(
            //   format: format,
            //   style: TextStyle(fontSize: 16, color: Colors.black),
            //   initialValue: application.responses.effectFrom,
            //   onChanged: (date) => setState(() {
            //     application.responses.effectFrom = date;
            //   }),
            //   onShowPicker: (context, currentValue) {
            //     return showDatePicker(
            //       initialDate: DateTime.now(),
            //       context: context,
            //       firstDate: DateTime(2019),
            //       lastDate: DateTime(2050),
            //     );
            //   },
            // ),
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
                  if (finishKey.currentState.validate()) {
                    __applyNow(context);
                  }
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
      ),
    );
  }
}
