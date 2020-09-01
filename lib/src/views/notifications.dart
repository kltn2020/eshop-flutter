import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ecommerce_flutter/src/models/i_product.dart';
import 'package:ecommerce_flutter/src/redux/products/products_actions.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  //Search
  bool typing = false;

  //Bottom Navigation
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/product-list');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/user');
        break;
      default:
    }
  }

  //Tabs

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: typing
              ? TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search',
                  ),
                )
              : Text(
                  "Eshop",
                  style: TextStyle(
                    color: Color.fromRGBO(79, 59, 120, 1),
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    fontSize: 32,
                  ),
                ),
          leading: IconButton(
            icon: Icon(typing ? Icons.done : Icons.search),
            color: Color.fromRGBO(146, 127, 191, 1),
            onPressed: () {
              setState(() {
                typing = !typing;
              });
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              color: Color.fromRGBO(146, 127, 191, 1),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                  child: Text(
                "New voucher",
                style: TextStyle(color: Colors.black),
              )),
              Tab(
                  child: Text(
                "Order Notification",
                style: TextStyle(color: Colors.black),
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //List voucher
            ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Voucher 1",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Discount: %"),
                          Text("Category: Laptop"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("start date"),
                          Text(" - "),
                          Text("end date"),
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 5,
                        indent: 20,
                        endIndent: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Icon(Icons.directions_transit),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.laptop),
              title: Text('Product'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text('Notification'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('User'),
            ),
          ],
          currentIndex: 2,
          selectedItemColor: Colors.purple[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
