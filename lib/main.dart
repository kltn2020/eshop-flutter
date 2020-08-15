import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:ecommerce_flutter/src/containers/home.dart';
import 'package:ecommerce_flutter/src/containers/product_list.dart';

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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
          '/product-list': (context) => ProductList(title: 'Product List'),
          // '/settings': (context) => Settings(),
        },
      ),
    );
  }
}
