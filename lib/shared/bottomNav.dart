import 'package:Myinshora/pages/claims/All.dart';
import 'package:Myinshora/pages/dashboard/Buy.dart';
import 'package:Myinshora/pages/dashboard/Main.dart';
import 'package:Myinshora/pages/dashboard/Profile.dart';
import 'package:flutter/material.dart';

class Bottom extends BottomNavigationBar {
  Bottom({Key key, int currentIndex, BuildContext context})
      : super(
            key: key,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_membership),
                title: Text('Buy'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.developer_board),
                title: Text('Claims'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle),
                title: Text('Profile'),
              ),
            ],
            currentIndex: currentIndex,
            selectedItemColor: Color(0xFFF58634),
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Dashboard(),
                    ),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Buy(),
                    ),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Claims(),
                    ),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                  break;
                default:
              }
            });
}
