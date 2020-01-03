import 'package:flutter/material.dart';

class Navbar extends AppBar {
  Navbar(
      {Key key,
      Widget title,
      Widget leadIcon,
      Color bgColor,
      Widget bottom,
      List<Widget> actions,
      BuildContext context})
      : super(
            key: key,
            title: title,
            backgroundColor: bgColor,
            actions: actions,
            bottom: bottom,
            leading: leadIcon != null
                ? IconButton(
                    icon: leadIcon,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                : Text(""));
}
