import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_flutter/src/redux/cart/cart_actions.dart';
import 'package:ecommerce_flutter/src/views/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ecommerce_flutter/src/models/Favorite.dart';
import 'package:ecommerce_flutter/src/redux/favorite/favorite_actions.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:intl/intl.dart';

class FavoriteList extends StatefulWidget {
  // static String get routeName => '@routes/home-page';

  FavoriteList({Key key}) : super(key: key);

  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Favorite List",
          style: TextStyle(
            color: Color.fromRGBO(79, 59, 120, 1),
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: projectWidget(),
    );
  }
}

void _showToast(BuildContext context) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Added to cart'),
    ),
  );
}

Widget projectWidget() {
  final formatter = new NumberFormat("#,###");

  return FutureBuilder(
    future: Redux.store
        .dispatch(new FavoriteActions().getAllFavoriteAction(Redux.store)),
    builder: (context, projectSnap) {
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        print('project snapshot data is: ${projectSnap.data}');
        return Container();
      }
      if (projectSnap.connectionState == ConnectionState.waiting) {
        return LinearProgressIndicator(
          backgroundColor: Color.fromRGBO(196, 187, 240, 0.5),
          valueColor: new AlwaysStoppedAnimation<Color>(
            Color.fromRGBO(146, 127, 191, 1),
          ),
        );
      }
      return Container(
        child: StoreConnector<AppState, String>(
          distinct: true,
          converter: (store) => store.state.userState.token,
          builder: (context, token) {
            if (token == null) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                          "No authority! Please click button below to login"),
                    ),
                    Center(
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: Text(
                            "Back to Login",
                            style: TextStyle(color: Colors.grey),
                          )),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                child: StoreConnector<AppState, Favorite>(
                  distinct: true,
                  onInit: (store) {
                    Redux.store.dispatch(FavoriteActions(
                            token: Redux.store.state.userState.token)
                        .getAllFavoriteAction);
                  },
                  converter: (store) => store.state.favoriteState.favoriteList,
                  builder: (context, favoriteList) {
                    if (favoriteList != null)
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: favoriteList.product.map((product) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 16,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductPage(
                                                  product: product,
                                                ),
                                              ));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                ),
                                                maxLines: 3,
                                              ),
                                              product.discountPrice > 0
                                                  ? Row(
                                                      children: [
                                                        AutoSizeText(
                                                          formatter.format(product
                                                                  .discountPrice) +
                                                              ' VND',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Color.fromRGBO(
                                                                    146,
                                                                    127,
                                                                    191,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                          maxLines: 1,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                          child: AutoSizeText(
                                                            formatter.format(
                                                                product.price),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Text(
                                                      formatter.format(
                                                          product.price),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Color.fromRGBO(
                                                            146, 127, 191, 1),
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        Redux.store.dispatch(CartActions()
                                            .addCartAction(
                                                Redux.store, product, 1)
                                            .then(
                                          (value) => _showToast(context),
                                          onError: (e) {
                                            print(e);
                                          },
                                        ));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color:
                                              Color.fromRGBO(196, 187, 240, 1),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Add to cart",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    else
                      return Container();
                  },
                ),
              );
            }
          },
        ),
      );
    },
  );
}
