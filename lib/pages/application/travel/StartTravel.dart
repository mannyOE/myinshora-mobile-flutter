import 'package:Myinshora/shared/widgets/Quote.dart';
import 'package:Myinshora/apis/auth.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/models/Gender.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:Myinshora/apis/insurances.dart';
import 'package:Myinshora/store/userMgt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

class StartTravel extends StatelessWidget {
  final Application application;
  StartTravel({
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
          leadIcon: Icon(Icons.arrow_back),
          context: context,
        ),
        body: BuyTravel(application: application),
      ),
    );
  }
}

// Create a Form widget.
class BuyTravel extends StatefulWidget {
  BuyTravel({@required this.application}) : super();
  final Application application;
  @override
  BuyTravelState createState() {
    return BuyTravelState(application: application);
  }
}

class BuyTravelState extends State<BuyTravel> {
  BuyTravelState({@required this.application}) : super();
  Application application;
  Country country;
  bool selected = false, selected2 = false, loading = false;
  DateTime takeOffDate, returnDate;
  Quote quote;
  final formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
  }

  __parseDestination(data) {
    if (application.responses.destination != null) {
      return data
          .where((i) => i.id == application.responses.destination)
          .toList()[0]
          .name;
    }
    return country.name;
  }

  getQuote() async {
    try {
      var user = await readUser();
      if (application.responses.startDate == null ||
          application.responses.endDate == null ||
          application.responses.destination == null) {
        return Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFFF58634),
            content: Text("Complete All Fields to get a quote"),
          ),
        );
      }
      var body = {
        "dateOfBirth": user.dateOfBirth.toString(),
        "startDate": application.responses.startDate.toString(),
        "endDate": application.responses.endDate.toString(),
        "destinationCountryId": application.responses.destination
      };
      setState(() {
        loading = true;
      });

      getQuoteApi(body).then((response) {
        setState(() {
          quote = Quote.fromJson(convert.jsonDecode(response)['result']);
          application.responses.quote = quote.premium.toString();
          loading = false;
        });
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) =>
                QuoteWidget(application: application),
          ),
        );
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      child: Form(
        autovalidate: true,
        onChanged: () {
          formKey.currentState.save();
        },
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: <Widget>[
            Text(
              "Where are you off to?",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              builder: (BuildContext context,
                  AsyncSnapshot<List<Country>> snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator(
                    backgroundColor: Color(0xFFF58634),
                  );
                }
                return DropdownButton<Country>(
                  isExpanded: true,
                  onChanged: (newVal) {
                    setState(() {
                      country = newVal;
                      application.responses.destination = newVal.id;
                      selected = true;
                    });
                  },
                  hint: Text(
                      !selected
                          ? "Select Destination Country"
                          : __parseDestination(snapshot.data),
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  items: snapshot.data
                      .map((count) => DropdownMenuItem<Country>(
                          value: count, child: Text(count.name)))
                      .toList(),
                );
              },
              future: fetchCountries(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "When do you take off?",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            DateTimeFormField(
              onlyDate: true,
              initialValue: application.responses.startDate,
              label: "Select a date",
              validator: (value) {
                if (value.isBefore(DateTime.now())) {
                  return 'Choose a date in the future';
                }
                return null;
              },
              onSaved: (DateTime dateTime) => this.setState(() {
                application.responses.startDate = dateTime;
              }),
            ),
            // DateTimeField(
            //   format: format,
            //   style: TextStyle(fontSize: 16, color: Colors.black),
            //   initialValue: application.responses.startDate,
            //   onChanged: (date) => setState(() {
            //     application.responses.startDate = date;
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
            Text(
              "When are you coming back?",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            DateTimeFormField(
                onlyDate: true,
                initialValue: application.responses.endDate,
                label: "Select a date",
                validator: (value) {
                  if (value.isBefore(DateTime.now()) ||
                      !value.isAfter(application.responses.startDate)) {
                    return 'Choose a date in the future';
                  }
                  return null;
                },
                onSaved: (DateTime dateTime) => this.setState(() {
                      application.responses.endDate = dateTime;
                    })),
            // DateTimeField(
            //   format: format,
            //   style: TextStyle(fontSize: 16, color: Colors.black),
            //   initialValue: application.responses.endDate,
            //   onChanged: (date) => setState(() {
            //     application.responses.endDate = date;
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
            Text("Are you travelling in a group?",
                style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(
              height: 20,
            ),
            DropdownButton<String>(
              isExpanded: true,
              onChanged: (newVal) {
                setState(() {
                  application.responses.travelWithGroup = newVal;
                  selected2 = true;
                });
              },
              hint: Text(
                  !selected2
                      ? "Select Yes/No"
                      : application.responses.travelWithGroup,
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              items: ["Yes", "No"]
                  .map((count) => DropdownMenuItem<String>(
                      value: count, child: Text(count)))
                  .toList(),
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
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  getQuote();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
