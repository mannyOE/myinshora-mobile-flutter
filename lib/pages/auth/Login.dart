import 'package:Myinshora/apis/auth.dart';
import 'package:Myinshora/pages/dashboard/Main.dart';
import 'package:flutter/material.dart';
import 'package:Myinshora/validators/auth.dart';
import 'package:Myinshora/pages/auth/Signup.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Login';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            appTitle,
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Avenir-Medium",
                color: Color(0xFF240F00),
                letterSpacing: 3),
          ),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = new FocusNode();
  var email, password, message;
  bool loading = false;

  signupBtn() async {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      var body = {"email": email, "password": password};
      setState(() {
        loading = true;
      });
      try {
        var response = await login(body);
        setState(() {
          loading = false;
        });
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xFFF58634),
            content: Text(response['message'])));
        if (response['data'] != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(),
            ),
          );
        }
      } catch (e) {
        setState(() {
          loading = false;
        });
        print(e);
        setState(() {
          message = "Failed to Login";
        });
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xFFF58634), content: Text(message)));
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xFFF58634),
          content: Text('Please Complete the form appropriately')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "Welcome back!",
                style: TextStyle(
                    fontFamily: "Avenir-Demi",
                    fontSize: 20,
                    color: Color(0xFF240F00)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Glad to see you again!",
                style: TextStyle(fontFamily: "Avenir", fontSize: 15),
              ),
              SizedBox(
                height: 35,
              ),
              TextFormField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF58634)),
                    ),
                    hasFloatingPlaceholder: true,
                    labelText: "Email Address",
                    labelStyle: TextStyle(
                      color: Color(0xFF737373),
                      fontSize: 15,
                      fontFamily: "Avenir-Demi",
                    )),
                validator: emailValidator,
                initialValue: email,
                onChanged: (val) => setState(() {
                  email = val;
                }),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF58634)),
                  ),
                  hasFloatingPlaceholder: true,
                  labelText: "Password",
                  labelStyle: TextStyle(color: Color(0xFF737373), fontSize: 15),
                ),
                validator: passwordValidator,
                initialValue: password,
                onChanged: (val) => setState(() {
                  password = val;
                }),
              ),
              SizedBox(
                height: 100,
              ),
              loading
                  ? LinearProgressIndicator(
                      backgroundColor: Color(0xFFF58634),
                    )
                  : Text(""),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                    color: Color(0xFFD8D8D8),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Color(0xFF737373)),
                    ),
                    onPressed: signupBtn),
              ),
              Align(
                heightFactor: 1.3,
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  elevation: 0,
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                  child: Text(
                    "Create an account",
                    style: TextStyle(color: Color(0xFFF58634)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signup(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
