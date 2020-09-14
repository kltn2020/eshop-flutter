import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:ecommerce_flutter/src/redux/products/products_actions.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

class User extends StatefulWidget {
  User({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
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
      case 2:
        Navigator.pushReplacementNamed(context, '/notifications');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Username",
          style: TextStyle(
            color: Color.fromRGBO(79, 59, 120, 1),
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: Icon(Icons.shopping_cart),
            color: Color.fromRGBO(146, 127, 191, 1),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Order",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/order-history');
                  },
                  child: Text(
                    "View order history",
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),

            /* Order Status line */
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.assignment,
                          size: 32,
                          color: Colors.amber[600],
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            color: Colors.amber[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.sync,
                          size: 32,
                          color: Colors.blue,
                        ),
                        Text(
                          "Processing",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.check,
                          size: 32,
                          color: Colors.green,
                        ),
                        Text(
                          "Completed",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.cancel,
                          size: 32,
                          color: Colors.redAccent,
                        ),
                        Text(
                          "Cancelled",
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 200,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.favorite_border,
                      color: Colors.redAccent,
                    ),
                    title: Text("Favorite List"),
                    onTap: () => {
                      Navigator.pushNamed(context, '/favorite-list'),
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.black,
                    ),
                    title: Text("Account Setting"),
                    onTap: () => {
                      Navigator.pushNamed(context, '/account-setting'),
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.help,
                      color: Colors.blueAccent,
                    ),
                    title: Text("Help Center"),
                  ),
                ],
              ),
            ),
          ],
        ),
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
        currentIndex: 3,
        selectedItemColor: Colors.purple[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
