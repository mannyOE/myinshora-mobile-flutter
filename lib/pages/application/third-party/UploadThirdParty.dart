import 'dart:async';
import 'dart:io';
import 'package:Myinshora/apis/auth.dart';
import 'package:Myinshora/apis/insurances.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/models/Gender.dart';
import 'package:Myinshora/models/globals.dart' as prefix0;
import 'package:Myinshora/pages/dashboard/Main.dart';
import 'package:Myinshora/shared/Navbar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
// import 'package:paystack_flutter/paystack_flutter.dart';

class UploadThirdParty extends StatelessWidget {
  final Application application;
  UploadThirdParty({
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
        body: UploadsThirdParty(application: application),
      ),
    );
  }
}

// Create a Form widget.
class UploadsThirdParty extends StatefulWidget {
  UploadsThirdParty({@required this.application}) : super();
  final Application application;
  @override
  UploadsThirdPartyState createState() {
    return UploadsThirdPartyState(application: application);
  }
}

class UploadsThirdPartyState extends State<UploadsThirdParty> {
  UploadsThirdPartyState({@required this.application}) : super();
  Application application;
  static const platform = const MethodChannel('maugost.com/paystack_flutter');
  Titles selectedTitle;
  final format = DateFormat("yyyy-MM-dd");
  bool selected = false, selected2 = false, loading = false;
  String quote, year, fileName, path;
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    PaystackPlugin.initialize(publicKey: prefix0.Paystack_public_key);
    quote = application.responses.quote.toString();
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
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

  __parseModels(data) {
    if (application.responses.model != "") {
      return data.where((i) => i == application.responses.model).toList()[0];
    }
    return "Select the model of your car";
  }

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  __applyNow() async {
    try {
      apply({
        "responses": application.responses.toJson(),
        "_id": application.id
      }).then((onValue) {
        setState(() {
          loading = false;
        });
        _settingModalBottomSheet(context);
      });
    } catch (e) {
      print(e);
    }
  }

  getImage() async {
    var img =
        application.uploads.singleWhere((img) => img.type == "Identity Card");
    return prefix0.server + img.path;
  }

  startUpload() {
    setStatus('Uploading Image...');
    setState(() {
      loading = true;
    });
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName, tmpFile.path, application.id, "Identity Card")
        .then((onValue) {
      __applyNow();
    });
  }

  __parseColors(data) {
    if (application.responses.color != "") {
      return data.where((i) => i == application.responses.color).toList()[0];
    }
    return "Select the color of your car";
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
        padding: EdgeInsets.only(bottom: 50, right: 20, left: 20),
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            children: <Widget>[
              Text(
                "Select Vehicle Model",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              FutureBuilder(
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (!snapshot.hasData) {
                    return LinearProgressIndicator(
                      value: null,
                      backgroundColor: Color(0xFFF58634),
                    );
                  }
                  return DropdownButton<String>(
                    isExpanded: true,
                    onChanged: (newVal) {
                      // fetchMakes(newVal);
                      setState(() {
                        application.responses.model = newVal;
                      });
                    },
                    hint: Text(__parseModels(snapshot.data),
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    items: snapshot.data
                        .map((count) => DropdownMenuItem<String>(
                            value: count, child: Text(count)))
                        .toList(),
                  );
                },
                future: fetchModels(
                    application.responses.year, application.responses.make),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Select Vehicle Color",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              FutureBuilder(
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (!snapshot.hasData) {
                    return LinearProgressIndicator(
                      value: null,
                      backgroundColor: Color(0xFFF58634),
                    );
                  }
                  return DropdownButton<String>(
                    isExpanded: true,
                    onChanged: (newVal) {
                      // fetchMakes(newVal);
                      setState(() {
                        application.responses.color = newVal;
                      });
                    },
                    hint: Text(__parseColors(snapshot.data),
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    items: snapshot.data
                        .map((count) => DropdownMenuItem<String>(
                            value: count, child: Text(count)))
                        .toList(),
                  );
                },
                future: fetchColors(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "File Upload (Valid Identification)",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              FlatButton(
                color: Colors.tealAccent,
                onPressed: () {
                  chooseImage();
                },
                child: Row(
                  children: <Widget>[
                    Text("Click to select file"),
                    Spacer(),
                    Icon(Icons.file_upload)
                  ],
                ),
              ),
              FutureBuilder<File>(
                future: file,
                builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      null != snapshot.data) {
                    tmpFile = snapshot.data;
                    base64Image = base64Encode(snapshot.data.readAsBytesSync());
                    return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              setState(() {
                                file = null;
                              });
                            },
                            icon: Icon(Icons.remove_circle_outline),
                          ),
                          Image.file(
                            snapshot.data,
                            width: 150,
                            height: 150,
                          ),
                        ]);
                  } else if (null != snapshot.error) {
                    return const Text(
                      'Error Picking Image',
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return const Text(
                      'No Image Selected',
                      textAlign: TextAlign.center,
                    );
                  }
                },
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
                    if (formKey.currentState.validate()) {
                      file == null ? __applyNow() : startUpload();
                    }
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
              SizedBox(
                height: 20,
              ),
              Text(
                application.uploads.length.toString() + " Previous Uploads",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ));
  }
}
