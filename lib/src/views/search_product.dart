import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_flutter/src/redux/products/products_state.dart';
import 'package:ecommerce_flutter/src/widgets/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ecommerce_flutter/src/redux/products/products_actions.dart';
import 'package:ecommerce_flutter/src/views/product_detail.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:ecommerce_flutter/src/widgets/Appbar.dart';

class SearchProductList extends StatefulWidget {
  SearchProductList({Key key, this.search, this.brandId}) : super(key: key);

  final String search;
  final int brandId;

  @override
  _SearchProductListState createState() => _SearchProductListState();
}

class _SearchProductListState extends State<SearchProductList> {
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
                    .getMoreProductsAction(
                        Redux.store, page, widget.search, widget.brandId)),
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
                                                      Expanded(
                                                        child: AutoSizeText(
                                                          formatter.format(product
                                                              .discountPrice),
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                Color.fromRGBO(
                                                                    146,
                                                                    127,
                                                                    191,
                                                                    1),
                                                          ),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      product.price !=
                                                              product
                                                                  .discountPrice
                                                          ? Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 10,
                                                                ),
                                                                child:
                                                                    AutoSizeText(
                                                                  formatter.format(
                                                                      product
                                                                          .price),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                  maxLines: 1,
                                                                ),
                                                              ),
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
      appBar: AppBarWithSearch(),
      body: projectWidget(),
      bottomNavigationBar: bottomNavigationWidget(context, 1),
    );
  }
}