import 'package:Myinshora/apis/auth.dart';
import 'package:Myinshora/models/Gender.dart';
import 'package:Myinshora/pages/auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:Myinshora/validators/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:intl/intl.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Create account';

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
  Gender gender;
  var dateOfBirth = new DateTime.now(),
      occupation,
      firstName,
      lastName,
      email,
      password,
      phone,
      address,
      message;
  bool selected = false, loading = false, step2 = false;
  final format = DateFormat("yyyy-MM-dd");
  signupBtnNext() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        step2 = true;
      });
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xFFF58634),
          content: Text('Please Complete the form appropriately')));
    }
  }

  signupBtn() async {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var body = {
        "dateOfBirth": dateOfBirth.toString(),
        "accountType": 3,
        "lastName": lastName,
        "firstName": firstName,
        "phone": phone,
        "address": address,
        "email": email,
        "gender": gender.id,
        "occupation": occupation,
        "password": password
      };
      try {
        setState(() {
          loading = true;
        });
        var response = await register(body);
        setState(() {
          loading = false;
        });
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xFFF58634),
            content: Text(response["message"])));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      } catch (e) {
        setState(() {
          loading = false;
        });
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    // Build a Form widget using the _formKey created above.
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Text(
          "Welcome !",
          style: TextStyle(
              fontFamily: "Avenir-Demi",
              fontSize: 20,
              color: Color(0xFF240F00)),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Glad to have you with us!",
          style: TextStyle(fontFamily: "Avenir", fontSize: 15),
        ),
        Form(
            key: _formKey,
            autovalidate: true,
            child: step2 != true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF58634)),
                            ),
                            hasFloatingPlaceholder: true,
                            labelText: "First Name",
                            labelStyle: TextStyle(
                              color: Color(0xFF737373),
                              fontSize: 15,
                              fontFamily: "Avenir-Demi",
                            )),
                        validator: inputValidator,
                        initialValue: firstName,
                        onChanged: (val) => setState(() {
                          firstName = val;
                        }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFF58634)),
                            ),
                            hasFloatingPlaceholder: true,
                            labelText: "Last Name",
                            labelStyle: TextStyle(
                              color: Color(0xFF737373),
                              fontSize: 15,
                              fontFamily: "Avenir-Demi",
                            )),
                        validator: inputValidator,
                        initialValue: lastName,
                        onChanged: (val) => setState(() {
                          lastName = val;
                        }),
                      ),
                      SizedBox(
                        height: 10,
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
                          labelStyle:
                              TextStyle(color: Color(0xFF737373), fontSize: 15),
                        ),
                        validator: passwordValidator,
                        initialValue: password,
                        onChanged: (val) => setState(() {
                          password = val;
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
                          labelText: "Confirm Password",
                          labelStyle:
                              TextStyle(color: Color(0xFF737373), fontSize: 15),
                        ),
                        validator: (value) {
                          return value == password
                              ? null
                              : "Confirm Password should match password";
                        },
                        initialValue: password,
                        onChanged: (val) => setState(() {}),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                            color: Color(0xFFD8D8D8),
                            child: Text(
                              "Next",
                              style: TextStyle(color: Color(0xFF737373)),
                            ),
                            onPressed: signupBtnNext),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Select a gender",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontFamily: "Avenir", fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FutureBuilder<List<Gender>>(
                          future: fetchGenders(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Gender>> snapshot) {
                            if (!snapshot.hasData) {
                              return LinearProgressIndicator(
                                backgroundColor: Color(0xFFF58634),
                              );
                            }
                            return DropdownButton<Gender>(
                              isExpanded: true,
                              onChanged: (newVal) {
                                setState(() {
                                  gender = newVal;
                                  selected = true;
                                });
                              },
                              hint: Text(
                                  !selected ? "Select A Gender" : gender.name),
                              items: snapshot.data
                                  .map((gender) => DropdownMenuItem<Gender>(
                                      value: gender, child: Text(gender.name)))
                                  .toList(),
                            );
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFF58634)),
                              ),
                              hasFloatingPlaceholder: true,
                              labelText: "Occupation",
                              labelStyle: TextStyle(
                                color: Color(0xFF737373),
                                fontSize: 15,
                                fontFamily: "Avenir-Demi",
                              )),
                          validator: inputValidator,
                          initialValue: occupation,
                          onChanged: (val) => setState(() {
                            occupation = val;
                          }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFF58634)),
                              ),
                              hasFloatingPlaceholder: true,
                              labelText: "Address",
                              labelStyle: TextStyle(
                                color: Color(0xFF737373),
                                fontSize: 15,
                                fontFamily: "Avenir-Demi",
                              )),
                          validator: inputValidator,
                          initialValue: address,
                          onChanged: (val) => setState(() {
                            address = val;
                          }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFF58634)),
                              ),
                              hasFloatingPlaceholder: true,
                              labelText: "Phone Number",
                              labelStyle: TextStyle(
                                color: Color(0xFF737373),
                                fontSize: 15,
                                fontFamily: "Avenir-Demi",
                              )),
                          validator: phoneValidator,
                          initialValue: phone,
                          onChanged: (val) => setState(() {
                            phone = val;
                          }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Select your date of birth!",
                          style: TextStyle(fontFamily: "Avenir", fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DateTimeFormField(
                          initialValue: dateOfBirth,
                          label: "Select a date",
                          onlyDate: true,
                          onSaved: (date) {
                            setState(() {
                              dateOfBirth = date;
                            });
                          },
                        ),
                        SizedBox(
                          height: 30,
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
                                "Create Account",
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
                              padding: EdgeInsets.fromLTRB(100, 0, 100, 80),
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
                              }),
                        ),
                      ])),
      ],
    );
  }
}
