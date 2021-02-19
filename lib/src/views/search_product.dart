import 'package:auto_size_text/auto_size_text.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:ecommerce_flutter/src/models/Cart.dart';
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
  final searchController = TextEditingController();
  final formatter = new NumberFormat("#,###");

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  Widget projectWidget() {
    var listBrand = [
      'Apple',
      'Dell',
      'HP',
      'Acer',
      'Asus',
      'MSI',
      'Huawei',
    ];

    Future<void> submitSearch(String search) async {
      await Redux.store.dispatch(ProductActions()
          .getMoreSearchProductsAction(Redux.store, 1, search, widget.brandId));
    }

    final debouncer = Debouncer<String>(Duration(seconds: 1));

    // Run a search whenever the user pauses while typing.
    searchController.addListener(() => debouncer.value = searchController.text);
    debouncer.values.listen((search) => submitSearch(search));

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
                    .getMoreSearchProductsAction(Redux.store, page,
                        searchController.text, widget.brandId)),
                builder: (context, productState) {
                  if (searchController.text != '' || widget.brandId != null)
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
                                children:
                                    productState.searchProducts.map((product) {
                                  return Stack(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey[300]),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                    width:
                                                        MediaQuery.of(context)
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
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            product.discountPrice != null
                                                ? Container(
                                                    padding: EdgeInsets.all(6),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        AutoSizeText(
                                                          formatter.format(product
                                                              .discountPrice),
                                                          style: TextStyle(
                                                            fontSize: 14,
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
                                                        product.price !=
                                                                product
                                                                    .discountPrice
                                                            ? AutoSizeText(
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
                                                                  fontSize: 10,
                                                                ),
                                                                maxLines: 1,
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  )
                                                : Text(
                                                    (product.price != null
                                                        ? formatter.format(
                                                            product.price)
                                                        : "Contact"),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
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
                  else
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: SingleChildScrollView(
                        child: Column(
                          children: listBrand.map((brand) {
                            return FlatButton(
                              onPressed: () {
                                searchController.text = brand;
                              },
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  brand,
                                ),
                              ),
                            );
                          }).toList(),
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
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search',
            ),
            controller: searchController,
            // onSubmitted: (String value) async {
            //   await Redux.store.dispatch(ProductActions().getMoreProductsAction(
            //       Redux.store, page, searchController.text, widget.brandId));
            // },
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
            Redux.store.dispatch(ProductActions().cleanSearchProductsAction);
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
      ),
      body: projectWidget(),
      bottomNavigationBar: bottomNavigationWidget(context, 1),
    );
  }
}
