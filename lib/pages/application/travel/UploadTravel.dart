import 'package:Myinshora/apis/insurances.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/models/Gender.dart';
import 'package:Myinshora/models/globals.dart' as prefix0;
import 'package:Myinshora/pages/dashboard/Main.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:flutter/services.dart';
// import 'package:paystack_flutter/paystack_flutter.dart';

class UploadPage extends StatelessWidget {
  final Application application;
  UploadPage({
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
        body: Upload(application: application),
      ),
    );
  }
}

// Create a Form widget.
class Upload extends StatefulWidget {
  Upload({@required this.application}) : super();
  final Application application;
  @override
  UploadState createState() {
    return UploadState(application: application);
  }
}

class UploadState extends State<Upload> {
  UploadState({@required this.application}) : super();
  Application application;
  Titles selectedTitle;
  final format = DateFormat("yyyy-MM-dd");
  bool selected = false, selected2 = false, loading = false;
  String quote;
  final formKey = GlobalKey<FormState>();
  static const platform = const MethodChannel('maugost.com/paystack_flutter');

  String transcation = 'No transcation Yet';
  @override
  void initState() {
    super.initState();
    PaystackPlugin.initialize(publicKey: prefix0.Paystack_public_key);
    quote = application.responses.quote.toString();
  }

  void connectPaystack() async {
    Charge charge = Charge()
      ..amount = int.parse(application.responses.quote) * 100
      ..reference = "myinshora-" +
          application.id +
          "-" +
          DateTime.now().millisecondsSinceEpoch.toString()
      // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = application.user.email;
    CheckoutResponse response = await PaystackPlugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    if (response.status) {
      setState(() {
        loading = true;
      });
      var paylad = {
        "insuranceType": application.subClassCoverTypes.productName,
        "productId": application.subClassCoverTypes.productId,
        "id": application.subClassCoverTypes.id,
        "amount": application.responses.quote,
        "applicationId": application.id
      };
      var app = {
        "product": paylad,
        "payment": {"reference": response.reference},
        "responses": application.responses.toJson(),
        "user": application.user.toJson()
      };
      buyPolicy(app).then((onValue) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
          ),
        );
      }).catchError((onError) {});
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 350,
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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
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
                loading ? LinearProgressIndicator() : Text(""),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFF58634),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0))),
                  child: FlatButton(
                      onPressed: () {
                        connectPaystack();
                      },
                      child: Row(
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

  __applyNow() async {
    try {
      setState(() {
        loading = true;
      });
      formKey.currentState.save();
      Application app = application;

      apply(app.toJson()).then((onValue) {
        var jsonResponse = convert.jsonDecode(onValue)['application'];
        app = Application.fromJson(jsonResponse);
        setState(() {
          loading = false;
          application = app;
        });
        _settingModalBottomSheet(context);
      });
    } catch (e) {
      print(e);
    }
  }

  connectToPaystack() async {
    String result;
    try {
      // result = await PaystackFlutter.connectToPaystack({
      //   "NAME": "Your Name",
      //   "EMAIL": "you@email.com",
      //   "AMOUNT": 100,
      //   "CURRENCY": "NGN",
      //   "PAYMENT_FOR": "Testing API",
      //   "PAYSTACK_PUBLIC_KEY": paystack_pub_key,
      //   "BACKEND_URL": paystack_backend_url,
      // });
    } on PlatformException catch (e) {
      result = e.message;
      print(e.message);
    }

    if (!mounted) return;

    setState(() {
      transcation = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      padding: EdgeInsets.only(bottom: 50, right: 20, left: 20),
      child: Form(
        onChanged: () {
          formKey.currentState.save();
        },
        autovalidate: true,
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          children: <Widget>[
            Text(
              "Passport Number?",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            TextFormField(
              initialValue: application.responses.passportNumber,
              onChanged: (val) {
                setState(() {
                  application.responses.passportNumber = val;
                });
              },
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Passport Expiry Date",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            DateTimeFormField(
              onlyDate: true,
              initialValue: application.responses.passportExpiryDate,
              label: "Select a date",
              validator: (value) {
                if (value.isBefore(DateTime.now()) ||
                    !value.isAfter(application.responses.endDate)) {
                  return 'Choose a date in the future';
                }
                return null;
              },
              onSaved: (DateTime dateTime) => this.setState(() {
                application.responses.passportExpiryDate = dateTime;
              }),
            ),
            // DateTimeField(
            //   format: format,
            //   style: TextStyle(fontSize: 16, color: Colors.black),
            //   initialValue: application.responses.passportExpiryDate,
            //   onChanged: (date) => setState(() {
            //     application.responses.passportExpiryDate = date;
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
              "File Upload (Passport Bio-data page)",
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
                        style: TextStyle(color: Color(0xFFA8518A)),
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
