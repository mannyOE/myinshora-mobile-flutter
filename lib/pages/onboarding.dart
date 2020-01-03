import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'auth/Login.dart';
import 'auth/Signup.dart';
import 'dart:io';

class Onboarding extends StatelessWidget {
  const Onboarding({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: , set a linear background from top to bottom
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            titleWidget: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: Image.asset("assets/logo.png"),
                      height: 90,
                    ),
                    Text(
                      "Simple and Transparent",
                      style: TextStyle(
                          color: Color(0xFF240F00),
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incid",
                          style:
                              TextStyle(color: Color(0xFF737373), fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            bodyWidget: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      child: Image.asset("assets/slide1.png"),
                      height: 300,
                    ),
                  ),
                ],
              ),
            ),
            footer: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/gradient-box.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 40, horizontal: 25),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Already a member? "),
                              Text(
                                " Sign In",
                                style: TextStyle(color: Color(0xFFF58634)),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  heightFactor: Platform.isIOS ? 2 : 1,
                )
              ],
            ),
          ),
          PageViewModel(
            titleWidget: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: Image.asset("assets/logo.png"),
                      height: 90,
                    ),
                    Text(
                      "We got you Covered",
                      style: TextStyle(
                          color: Color(0xFF240F00),
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incid",
                          style:
                              TextStyle(color: Color(0xFF737373), fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            bodyWidget: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      child: Image.asset("assets/slide2.png"),
                      height: 300,
                    ),
                  ),
                ],
              ),
            ),
            footer: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/gradient-box.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 40, horizontal: 25),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Buy Insurance Plans? "),
                              Text(
                                "Get Insured",
                                style: TextStyle(
                                  color: Color(0xFFF58634),
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  heightFactor: Platform.isIOS ? 2 : 1,
                )
              ],
            ),
          ),
          PageViewModel(
            titleWidget: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: Image.asset("assets/logo.png"),
                      height: 90,
                    ),
                    Text(
                      "Get Compensated",
                      style: TextStyle(
                          color: Color(0xFF240F00),
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incid",
                          style:
                              TextStyle(color: Color(0xFF737373), fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            bodyWidget: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      child: Image.asset("assets/slide3.png"),
                      height: 300,
                    ),
                  ),
                ],
              ),
            ),
            footer: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/gradient-box.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                    heightFactor: Platform.isIOS ? 2 : 1,
                    child: Card(
                      color: Colors.white,
                      margin:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 25),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Create a policy? "),
                                Text(
                                  " Get Covered",
                                  style: TextStyle(
                                    color: Color(0xFFF58634),
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          PageViewModel(
            titleWidget: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: Image.asset("assets/logo.png"),
                      height: 90,
                    ),
                    Text(
                      "Live Your Best Life",
                      style: TextStyle(
                          color: Color(0xFF240F00),
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incid",
                      style: TextStyle(color: Color(0xFF737373), fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            bodyWidget: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      child: Image.asset("assets/slide4.png"),
                      height: 300,
                    ),
                  ),
                ],
              ),
            ),
            footer: Stack(
              children: <Widget>[
                Align(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                        child: Text(
                          "Create an Account",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signup(),
                            ),
                          );
                        },
                        color: Color(0xFFF58634),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Color(0xFFF58634)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        },
                        color: Colors.white,
                      )
                    ],
                  ),
                  heightFactor: Platform.isIOS ? 2 : 1,
                )
              ],
            ),
          ),
        ],
        done: Text(''),
        onDone: () {},
      ),
    );
  }
}
