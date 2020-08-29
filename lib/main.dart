import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:ecommerce_flutter/src/views/home.dart';
import 'package:ecommerce_flutter/src/views/product_list.dart';
import 'package:ecommerce_flutter/src/views/login.dart';
import 'package:ecommerce_flutter/src/views/register.dart';
import 'package:ecommerce_flutter/src/views/category_list.dart';
import 'package:ecommerce_flutter/src/views/notifications.dart';
import 'package:ecommerce_flutter/src/views/user.dart';

//StoreProvider it passes our Redux Store to our tree of widgets.
//StoreConnector gets the Store from StoreProvider, reads a piece of data from our store and passes that data to its builder function, then whenever that data changes, rebuilds itself.

void main() async {
  await Redux.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   initialRoute: '/',
    //   home: StoreProvider<AppState>(
    //     store: Redux.store,
    //     child: MyHomePage(title: 'Flutter Demo Home Page'),
    //   ),
    // );
    return StoreProvider<AppState>(
      store: Redux.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto'),
        title: 'Shop',
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/product-list': (context) => ProductList(title: 'Product List'),
          '/category-list': (context) => CategoryList(),
          '/notifications': (context) => Notifications(title: 'Notifications'),
          '/user': (context) => User(title: 'User'),
          '/login': (context) => Login(),
          '/register': (context) => Register(),
        },
      ),
    );
  }
}
