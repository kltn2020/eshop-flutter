import 'package:ecommerce_flutter/src/models/Cart.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ecommerce_flutter/src/views/search_product.dart';

class AppBarWithSearch extends StatefulWidget with PreferredSizeWidget {
  // static String get routeName => '@routes/home-page';

  AppBarWithSearch({Key key}) : super(key: key);

  @override
  _AppBarWithSearchState createState() => _AppBarWithSearchState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return new Size.fromHeight(55.0);
  }
}

class _AppBarWithSearchState extends State<AppBarWithSearch> {
  //bool typing = false;
  //final searchController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    //searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      // title: typing
      //     ? TextField(
      //         decoration: InputDecoration(
      //           border: OutlineInputBorder(),
      //           filled: true,
      //           fillColor: Colors.white,
      //           hintText: 'Search',
      //         ),
      //         controller: searchController,
      //       )
      //     : Text(
      //         "Eshop",
      //         style: TextStyle(
      //           color: Color.fromRGBO(79, 59, 120, 1),
      //           fontWeight: FontWeight.w900,
      //           fontStyle: FontStyle.italic,
      //           fontSize: 32,
      //         ),
      //       ),
      title: Text(
        "Eshop",
        style: TextStyle(
          color: Color.fromRGBO(79, 59, 120, 1),
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          fontSize: 32,
        ),
      ),
      leading: IconButton(
        //icon: Icon(typing ? Icons.done : Icons.search),
        icon: Icon(Icons.search),
        color: Color.fromRGBO(146, 127, 191, 1),
        onPressed: () {
          // setState(() {
          //   typing = !typing;
          //   if (!typing) {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => SearchProductList(
          //             search: searchController.text,
          //           ),
          //         ));
          //   }
          // });
          Navigator.pushNamed(context, '/search-product');
        },
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
          icon: StoreConnector<AppState, Cart>(
            distinct: true,
            converter: (store) => store.state.cartState.cart,
            builder: (context, cart) {
              return cart != null
                  ? Stack(
                      children: <Widget>[
                        Icon(
                          Icons.shopping_cart,
                          size: 32,
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              cart.products
                                  .fold(
                                      0,
                                      (previousValue, element) =>
                                          previousValue + element.quantity)
                                  .toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    )
                  : Container();
            },
          ),
          color: Color.fromRGBO(146, 127, 191, 1),
        ),
      ],
    );
  }
}
