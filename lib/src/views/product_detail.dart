import 'package:ecommerce_flutter/src/models/Favorite.dart';
import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:ecommerce_flutter/src/redux/cart/cart_actions.dart';
import 'package:ecommerce_flutter/src/redux/favorite/favorite_actions.dart';
import 'package:ecommerce_flutter/src/redux/favorite/favorite_state.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  ProductPage({@required this.product});

  final formatter = new NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          product.name,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: Stack(
              children: <Widget>[
                Icon(Icons.shopping_cart),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: new Text(
                      '1',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            color: Color.fromRGBO(146, 127, 191, 1),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: product.id,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(product.images[0]['url']),
                ),
              ),
              //Name
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              //Price
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: Text(
                  product.price != null
                      ? formatter.format(product.price)
                      : "Contact",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(196, 187, 240, 1),
                  ),
                ),
              ),
              //Review count - Sold - Favorite
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Review count: " +
                        formatter.format(product.ratingCount)),
                    Text("Sold: " + formatter.format(product.sold)),

                    Container(
                      child: StoreConnector<AppState, FavoriteState>(
                        distinct: true,
                        converter: (store) => store.state.favoriteState,
                        builder: (context, favoriteState) {
                          return favoriteState.favoriteList.product
                                      .where((iproduct) =>
                                          iproduct.id == product.id)
                                      .toList()
                                      .length >
                                  0
                              ? FlatButton(
                                  onPressed: () {
                                    Redux.store.dispatch(
                                      FavoriteActions(
                                              token: Redux
                                                  .store.state.userState.token,
                                              product: product)
                                          .deleteFavoriteAction,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Color.fromRGBO(196, 187, 240, 1),
                                    ),
                                  ),
                                )
                              : FlatButton(
                                  onPressed: () {
                                    Redux.store.dispatch(
                                      FavoriteActions(
                                              token: Redux
                                                  .store.state.userState.token,
                                              product: product)
                                          .addFavoriteAction,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.favorite_border,
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),

                    // FlatButton(
                    //   onPressed: null,
                    //   child: Container(
                    //     padding: EdgeInsets.all(4),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       border: Border.all(),
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(50),
                    //       ),
                    //     ),
                    //     child: StoreConnector<AppState, Favorite>(
                    //         distinct: true,
                    //         converter: (store) =>
                    //             store.state.favoriteState.favoriteList,
                    //         builder: (context, favoriteList) {
                    //           return favoriteList.product
                    //                       .where((iproduct) =>
                    //                           iproduct.id == product.id)
                    //                       .toList()
                    //                       .length >
                    //                   0
                    //               ? Icon(
                    //                   Icons.favorite,
                    //                   color: Color.fromRGBO(196, 187, 240, 1),
                    //                 )
                    //               : Icon(Icons.favorite_border);
                    //         }),
                    //   ),
                    // )
                  ],
                ),
              ),
              //Product Detail
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Detail",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(79, 59, 120, 0.8),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "General",
                                style: TextStyle(
                                  // color: Color.fromRGBO(146, 127, 191, 1),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "SKU: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.sku != null
                                  ? Text(product.sku)
                                  : Text(""),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Category: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.categoryId != null
                                  ? Text(product.categoryId.toString())
                                  : Text(""),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Brand: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.brandId != null
                                  ? Text(product.brandId.toString())
                                  : Text(""),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Configuration",
                                style: TextStyle(
                                  // color: Color.fromRGBO(196, 187, 240, 1),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "CPU: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.cpu != null
                                  ? Text(product.cpu)
                                  : Text(""),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "GPU: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.gpu != null
                                  ? Flexible(child: Text(product.gpu))
                                  : Text(""),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "OS: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.os != null ? Text(product.os) : Text(""),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "RAM: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.ram != null
                                  ? Flexible(child: Text(product.ram))
                                  : Text(""),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Storage: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.storage != null
                                  ? Text(product.storage)
                                  : Text(""),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "New Features: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.newFeature != null
                                  ? Flexible(child: Text(product.newFeature))
                                  : Text(""),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Display",
                                style: TextStyle(
                                  // color: Color.fromRGBO(196, 187, 240, 1),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Display: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.display != null
                                  ? Text(product.display)
                                  : Text(""),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Display Resolution: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.displayResolution != null
                                  ? Text(product.displayResolution)
                                  : Text(""),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Display Screen: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.displayScreen != null
                                  ? Text(product.displayScreen)
                                  : Text(""),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Camera",
                                style: TextStyle(
                                  // color: Color.fromRGBO(196, 187, 240, 1),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Camera: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.camera != null
                                  ? Text(product.camera)
                                  : Text(""),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Video: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.video != null
                                  ? Text(product.video)
                                  : Text(""),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Connectivity",
                                style: TextStyle(
                                  // color: Color.fromRGBO(196, 187, 240, 1),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Wifi: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.wifi != null
                                  ? Text(product.wifi)
                                  : Text(""),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Bluetooth: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.bluetooth != null
                                  ? Text(product.bluetooth)
                                  : Text(""),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Ports: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.ports != null
                                  ? Text(product.ports)
                                  : Text(""),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "Physical Details",
                                style: TextStyle(
                                  // color: Color.fromRGBO(196, 187, 240, 1),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Size: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.size != null
                                  ? Text(product.size)
                                  : Text(""),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Weight: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.weight != null
                                  ? Text(product.weight)
                                  : Text(""),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Material: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.material != null
                                  ? Text(product.material)
                                  : Text(""),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Battery Capacity: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              product.ports != null
                                  ? Text(product.batteryCapacity)
                                  : Text(""),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      product.description != null ? product.description : "",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              //Review
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Review",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(79, 59, 120, 0.8),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            print("See more");
                          },
                          child: Container(
                            child: Text("See more >"),
                          ),
                        ),
                      ],
                    ),
                    // Text(
                    //   "No review at the moment. Be the first one ",
                    //   style: TextStyle(),
                    // ),
                    //Review
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    child: Text("Username"),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star_border),
                                      Icon(Icons.star_border),
                                      Icon(Icons.star_border),
                                      Icon(Icons.star_border),
                                      Icon(Icons.star_border),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text("Review text...."),
                                  ),
                                  Text(
                                    "Date",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey[300],
                      ),
                    ),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    child: Text("Username"),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star_border),
                                      Icon(Icons.star_border),
                                      Icon(Icons.star_border),
                                      Icon(Icons.star_border),
                                      Icon(Icons.star_border),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Text("Review text...."),
                                  ),
                                  Text(
                                    "Date",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //End Reviews
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Redux.store
              .dispatch(CartActions().addCartAction(Redux.store, product, 1));
        },
        icon: Icon(Icons.add_shopping_cart),
        label: Text("Add to cart"),
        backgroundColor: Color.fromRGBO(79, 59, 120, 1),
      ),
    );
  }
}
