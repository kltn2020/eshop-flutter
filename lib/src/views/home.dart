import 'package:ecommerce_flutter/src/models/Cart.dart';
import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:ecommerce_flutter/src/redux/cart/cart_actions.dart';
import 'package:ecommerce_flutter/src/redux/favorite/favorite_actions.dart';
import 'package:ecommerce_flutter/src/redux/products/products_actions.dart';
import 'package:ecommerce_flutter/src/views/product_detail.dart';
import 'package:ecommerce_flutter/src/widgets/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

import '../animations/fade_animation.dart';
import '../widgets/CategoryItem.dart';

class HomePage extends StatefulWidget {
  // static String get routeName => '@routes/home-page';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool typing = false;

  final formatter = new NumberFormat("#,###");

  List bannerAdSlider = [
    "assets/banner1.jpg",
    "assets/banner2.jpg",
    "assets/banner3.jpg",
    "assets/banner4.jpg",
    "assets/banner5.jpg",
    "assets/banner6.jpg",
    "assets/banner7.jpg",
    "assets/banner8.jpg"
  ];

  Widget projectWidget() {
    return FutureBuilder(
      future: Future.wait(<Future>[
        Redux.store.dispatch(CartActions().getAllCartAction(Redux.store)),
        Redux.store.dispatch(
            FavoriteActions(token: Redux.store.state.userState.token)
                .getAllFavoriteAction),
        Redux.store.dispatch(
            ProductActions().getAllProductsAction(Redux.store, 1, 20)),
      ]),
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
                  child: StoreConnector<AppState, List<Product>>(
                    distinct: true,
                    converter: (store) => store.state.productsState.products,
                    builder: (context, products) {
                      return Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GridView.count(
                                physics: ClampingScrollPhysics(),
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                childAspectRatio: 1 / 1.55,
                                children: products.map((product) {
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
                                              ),
                                            ),
                                            product.discountPrice != null
                                                ? Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 15,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
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
                                                        ),
                                                        product.price != null
                                                            ? Text(
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
                                                                  fontSize: 12,
                                                                ),
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
                                                      fontSize: 18,
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
      },
    );
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
      body: Container(
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // banner ad slider

                    Padding(
                      padding: EdgeInsets.all(16),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          autoPlay: false,
                        ),
                        items: bannerAdSlider.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image(
                                    image: AssetImage(i),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),

                    // banner ad slider

                    SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 24,
                              color: Color.fromRGBO(54, 59, 78, 1),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/category-list');
                            },
                            child: Text("See more >"),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: <Widget>[
                          CategoryItem(
                            icon: Icons.computer,
                            size: 70,
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            padding: EdgeInsets.all(10),
                            backgroundColor: Color.fromRGBO(196, 187, 240, 1),
                            name: "Laptop",
                          ),
                          CategoryItem(
                            icon: Icons.mouse,
                            size: 70,
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            padding: EdgeInsets.all(10),
                            backgroundColor: Color.fromRGBO(196, 187, 240, 1),
                            name: "Mouse",
                          ),
                          CategoryItem(
                            icon: Icons.keyboard,
                            size: 70,
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            padding: EdgeInsets.all(10),
                            backgroundColor: Color.fromRGBO(196, 187, 240, 1),
                            name: "Keyboard",
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Daily discover",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromRGBO(54, 59, 78, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    projectWidget(),
                  ],
                ),
              ),
            );
          }
        },
      )),
      bottomNavigationBar: bottomNavigationWidget(context, 0),
    );
  }
}
