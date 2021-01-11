import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_flutter/src/models/Cart.dart';
import 'package:ecommerce_flutter/src/redux/products/products_state.dart';
import 'package:ecommerce_flutter/src/widgets/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:ecommerce_flutter/src/redux/products/products_actions.dart';
import 'package:ecommerce_flutter/src/views/product_detail.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

class ProductList extends StatefulWidget {
  ProductList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool typing = false;
  int page = 1;

  final formatter = new NumberFormat("#,###");

  Widget projectWidget() {
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
              child: StoreConnector<AppState, ProductsState>(
                distinct: true,
                converter: (store) => store.state.productsState,
                onInitialBuild: Redux.store.dispatch(ProductActions()
                    .getMoreProductsAction(Redux.store, page, 20)),
                builder: (context, productState) {
                  return Container(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!productState.isLoading &&
                            scrollInfo is ScrollEndNotification &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          setState(() {
                            page += 1;
                          });
                        }
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.count(
                              physics: ClampingScrollPhysics(),
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              childAspectRatio: 1 / 1.55,
                              children: productState.products.map((product) {
                                return Stack(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.grey[300]),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Hero(
                                            tag: product.id,
                                            child: AspectRatio(
                                              aspectRatio: 1 / 1,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.fitHeight,
                                                      image: NetworkImage(
                                                          product.images[0]
                                                              ['url']),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 8,
                                            ),
                                            child: Text(
                                              product.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          product.discountPrice != null
                                              ? Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 15,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      AutoSizeText(
                                                        formatter.format(product
                                                            .discountPrice),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color.fromRGBO(
                                                              146, 127, 191, 1),
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                      product.price != null
                                                          ? AutoSizeText(
                                                              formatter.format(
                                                                  product
                                                                      .price),
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 12,
                                                              ),
                                                              maxLines: 1,
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                )
                                              : Text(
                                                  (product.price != null
                                                      ? formatter
                                                          .format(product.price)
                                                      : "Contact"),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromRGBO(
                                                        146, 127, 191, 1),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
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
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                          StoreConnector<AppState, bool>(
                            distinct: true,
                            converter: (store) =>
                                store.state.productsState.isLoading,
                            builder: (context, isLoading) {
                              if (isLoading)
                                return LinearProgressIndicator(
                                  backgroundColor:
                                      Color.fromRGBO(196, 187, 240, 0.5),
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color.fromRGBO(146, 127, 191, 1),
                                  ),
                                );
                              else
                                return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: StoreConnector<AppState, Cart>(
              distinct: true,
              converter: (store) => store.state.cartState.cart,
              builder: (context, cart) {
                return Stack(
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
                );
              },
            ),
            color: Color.fromRGBO(146, 127, 191, 1),
          ),
        ],
      ),
      body: projectWidget(),
      bottomNavigationBar: bottomNavigationWidget(context, 1),
    );
  }
}
