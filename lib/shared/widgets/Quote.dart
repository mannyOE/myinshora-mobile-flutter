import 'package:Myinshora/apis/insurances.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/models/globals.dart' as prefix0;
import 'package:Myinshora/pages/application/third-party/FinishThirdParty.dart';
import 'package:Myinshora/pages/application/travel/FinishTravel.dart';
import 'dart:convert' as convert;
import 'package:Myinshora/store/userMgt.dart';
import 'package:flutter/material.dart';

class QuoteWidget extends StatelessWidget {
  final Application application;
  QuoteWidget({
    Key key,
    @required this.application,
  }) : super(key: key);

  __applyNow(context) async {
    Application app = application;
    User user = await readUser();
    app.user = user;
    var body = app.toJson();
    apply(body).then((onValue) {
      var jsonResponse = convert.jsonDecode(onValue)['application'];
      app = Application.fromJson(jsonResponse);
      if (app.subClassCoverTypes.productName == "Travel") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinishTravel(application: app),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinishThirdParty(application: app),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.45),
      body: Center(
          child: Card(
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 20.0)),
                    Text(
                      "Quote",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: "AvenirNext",
                          color: Color(0xFFF58634)),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "Price",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      subtitle: Text(
                        application.responses.quote != null
                            ? prefix0.naira + application.responses.quote
                            : "NA",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25),
                      ),
                    ),
                    ListTile(
                      title: Text("Plan",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18)),
                      subtitle: Text(
                        application.bouquet,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFFF58634),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0))),
                      child: FlatButton(
                        onPressed: application.responses.quote == null
                            ? null
                            : () async {
                                __applyNow(context);
                              },
                        child: Text(
                          "Buy Now",
                          style: TextStyle(color: Colors.white),
                          textScaleFactor: 1.3,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
