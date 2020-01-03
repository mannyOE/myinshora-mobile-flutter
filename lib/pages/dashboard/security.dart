// Create a Form widget.
import 'package:Myinshora/apis/auth.dart';
import 'package:Myinshora/models/Application.dart';
import 'package:flutter/material.dart';

class Security extends StatefulWidget {
  @override
  SecurityState createState() {
    return SecurityState();
  }
}

class SecurityState extends State<Security> {
  User userData = User();
  bool loading = false;
  String __currentPassword, __newPassword, __passwordConfirm;
  @override
  void initState() {
    super.initState();
  }

  __saveChanges() async {
    setState(() {
      loading = !loading;
    });
    var body = {
      "password": __newPassword,
      "passwordConfirm": __passwordConfirm,
      "currentPassword": __currentPassword,
    };
    var response = await updateUser(body);
    setState(() {
      loading = false;
      __passwordConfirm = "";
      __newPassword = "";
      __currentPassword = "";
    });
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
                  "Current Password",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  initialValue: __currentPassword,
                  onChanged: (val) {
                    setState(() {
                      __currentPassword = val;
                    });
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your current password";
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 30),
                Text(
                  "New Password",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  initialValue: __newPassword,
                  onChanged: (val) {
                    setState(() {
                      __newPassword = val;
                    });
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your new password";
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 30),
                Text(
                  "Confirm New Password",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  initialValue: __passwordConfirm,
                  onChanged: (val) {
                    setState(() {
                      __passwordConfirm = val;
                    });
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Confirm New Password";
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
                    __saveChanges();
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
