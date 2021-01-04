import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget bottomNavigationWidget(BuildContext context, int iCurrentIndex) {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/product-list');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/user');
        break;
      default:
        break;
    }
  }

  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.laptop),
        title: Text('Product'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text('User'),
      ),
    ],
    currentIndex: iCurrentIndex,
    selectedItemColor: Colors.purple[800],
    onTap: _onItemTapped,
  );
}
