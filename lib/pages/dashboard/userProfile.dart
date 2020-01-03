// Create a Form widget.
import 'package:Myinshora/apis/auth.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:Myinshora/store/userMgt.dart';
import 'package:flutter/material.dart';

class TheProfile extends StatefulWidget {
  @override
  TheProfileState createState() {
    return TheProfileState();
  }
}

class TheProfileState extends State<TheProfile> {
  User userData;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    setState(() {
      loading = true;
    });
    var response = await readUser();
    setState(() {
      userData = response;
      loading = false;
    });
    return response;
  }

  @override
  void dispose() {
    super.dispose();
  }

  _saveChanges() async {
    setState(() {
      loading = !loading;
    });
    var body = {
      "firstName": userData.firstName,
      "lastName": userData.lastName,
      "email": userData.email,
      "phone": userData.phone
    };
    var response = await updateUser(body);

    await _loadUserInfo();
    Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Color(0xFFF58634),
        content: Text(response['message'])));
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return loading
        ? LinearProgressIndicator(
            backgroundColor: Color(0xFFF58634),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            // child: Form(
            //   key: _formKey,
            child: ListView(
              children: <Widget>[
                Text(
                  "First Name",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  initialValue: userData.firstName,
                  onChanged: (val) {
                    setState(() {
                      userData.firstName = val;
                    });
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your first name";
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 30),
                Text(
                  "Last Name",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  initialValue: userData.lastName,
                  onChanged: (val) {
                    setState(() {
                      userData.lastName = val;
                    });
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your last name";
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 30),
                Text(
                  "Emal Address",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  initialValue: userData.email,
                  onChanged: (val) {
                    setState(() {
                      userData.email = val;
                    });
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your email address";
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 30),
                Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  initialValue: userData.phone,
                  onChanged: (val) {
                    setState(() {
                      userData.phone = val;
                    });
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your phone number";
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  color: Color(0xFFF58634),
                  child: Text(
                    "Save Changes",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _saveChanges();
                  },
                ),
                loading
                    ? LinearProgressIndicator(
                        backgroundColor: Color(0xFFF58634),
                      )
                    : Text(""),
              ],
            ),
            // ),
          );
  }
}
