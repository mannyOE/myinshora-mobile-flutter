import 'package:Myinshora/apis/auth.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/models/Gender.dart';
import 'package:Myinshora/pages/application/comprehensive/UploadComprehensive.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:intl/intl.dart';

class FinishComprehensive extends StatelessWidget {
  final Application application;
  FinishComprehensive({
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
        body: CompleteComprehensive(application: application),
      ),
    );
  }
}

// Create a Form widget.
class CompleteComprehensive extends StatefulWidget {
  CompleteComprehensive({@required this.application}) : super();
  final Application application;
  @override
  CompleteComprehensiveState createState() {
    return CompleteComprehensiveState(application: application);
  }
}

class CompleteComprehensiveState extends State<CompleteComprehensive> {
  CompleteComprehensiveState({@required this.application}) : super();
  final Application application;
  bool selected = false, loading = false;
  Category selectedCategory;
  final format = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
  }

  __parsecategory(data) {
    if (application.responses.category != null) {
      return data
          .where((i) => i.id == application.responses.category)
          .toList()[0]
          .name;
    }
    return selectedCategory.name;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
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
            builder:
                (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
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
                hint: Text(
                    !selected
                        ? "Select a category"
                        : __parsecategory(snapshot.data),
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
          ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UploadComprehensive(application: application),
                  ),
                );
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
