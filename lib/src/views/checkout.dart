import 'package:ecommerce_flutter/src/models/Address.dart';
import 'package:ecommerce_flutter/src/models/Cart.dart';
import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:ecommerce_flutter/src/models/Voucher.dart';
import 'package:ecommerce_flutter/src/redux/addresses/addresses_actions.dart';
import 'package:ecommerce_flutter/src/redux/cart/cart_actions.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

class CheckOut extends StatefulWidget {
  // static String get routeName => '@routes/home-page';

  CheckOut({Key key}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final formatter = new NumberFormat("#,###");

  var paymentType = "Choose type of payment";

  Address shippingAddress;
  Address primaryAddress;
  // Voucher voucher;

  _navigateAndDisplayAddressSelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    var result = await Navigator.pushNamed(context, '/address-checkout');

    if (result != null) {
      setState(() {
        shippingAddress = result;
      });
    }
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.pushNamed(context, '/payment-checkout');

    if (result != null) {
      setState(() {
        paymentType = result;
      });
    }
  }

  _checkoutCart(BuildContext context, Voucher voucher) async {
    CartActions()
        .checkoutCartAction(Redux.store,
            shippingAddress != null ? shippingAddress : primaryAddress, voucher)
        .then(
      (value) => _showMyDialog(value),
      onError: (e) {
        _showErrorDialog(e);
      },
    );
  }

  Future<void> _showMyDialog(void value) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Order Successfully !!!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.greenAccent[400],
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset("assets/undraw_order_confirmed.png"),
                Text(
                  "Your order has been confirmed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                Text(
                  "You can follow & check it at order history now",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'I got it! Return to Home',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(146, 127, 191, 1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog(CheckoutErrorMessage e) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Order Error!!!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset("assets/undraw_error.png"),
                Text(
                  e.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.deepOrange,
                  ),
                ),
                e.code == "VALIDATION_FAILED"
                    ? Text(
                        'You must choose an address',
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        'You should apply a voucher',
                        textAlign: TextAlign.center,
                      ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'I will check it right now!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(146, 127, 191, 1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMissingFieldDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Order Error!!!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset("assets/undraw_error.png"),
                Text(
                  "You are missing field(s). Please recheck :)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'I will check it right now!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(146, 127, 191, 1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Voucher voucher = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Check Out",
          style: TextStyle(
            color: Color.fromRGBO(79, 59, 120, 1),
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 32,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Text(
                      "Address",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      onPressed: () {
                        _navigateAndDisplayAddressSelection(context);
                      },
                      child: StoreConnector<AppState, List<Address>>(
                        distinct: true,
                        onInit: (store) => store.dispatch(new AddressesActions()
                            .getAllAddressesAction(Redux.store)),
                        converter: (store) =>
                            store.state.addressesState.addresses,
                        builder: (context, addresses) {
                          if (addresses != null && addresses.length > 0) {
                            primaryAddress = addresses.firstWhere(
                                (element) => element.isPrimary == true);
                          }

                          if (addresses != null && primaryAddress != null) {
                            shippingAddress = primaryAddress;

                            return Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      shippingAddress != null &&
                                              shippingAddress.phoneNumber !=
                                                  null
                                          ? Text(shippingAddress.phoneNumber)
                                          : Text(
                                              'Number: ${primaryAddress.phoneNumber}',
                                            ),
                                      shippingAddress != null &&
                                              shippingAddress.locate != null
                                          ? Expanded(
                                              child: Text(
                                                  shippingAddress.locate,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2),
                                            )
                                          : Expanded(
                                              child: Text(
                                                  'Address Detail: ${primaryAddress.locate}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2),
                                            )
                                    ],
                                  ),
                                  Icon(Icons.navigate_next),
                                ],
                              ),
                            );
                          } else
                            return Container();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Cart",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                    cartWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Payment Info",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // FlatButton(
                    //   onPressed: () {
                    //     _navigateAndDisplaySelection(context);
                    //   },
                    //   child: Container(
                    //     width: double.infinity,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Text("Payment Type: "),
                    //         Row(
                    //           children: [
                    //             Text("$paymentType"),
                    //             Icon(Icons.navigate_next),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: StoreConnector<AppState, Cart>(
                        distinct: true,
                        converter: (store) => store.state.cartState.cart,
                        builder: (context, cart) {
                          var tempCart = Cart.clone(cart);
                          int cartTotal = tempCart.products
                              .where((element) => element.check == true)
                              .fold(
                                  0,
                                  (previousValue, element) =>
                                      previousValue +
                                      element.quantity *
                                          element.product.discountPrice);
                          int shippingFee = 20000;

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Voucher: ${voucher != null && voucher.code != null ? voucher.code : ''}"),
                                  Text(
                                      "Discount: ${voucher != null && voucher.value != null ? voucher.value : ''}%"),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text("Cart total: "),
                                  Text(
                                    formatter.format(cartTotal),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text("Discount total: "),
                                  Text(
                                    formatter.format(cartTotal *
                                        (voucher != null &&
                                                voucher.value != null
                                            ? voucher.value / 100
                                            : 1)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Order total: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                  Text(
                                    formatter.format(cartTotal -
                                        (cartTotal *
                                            (voucher != null &&
                                                    voucher.value != null
                                                ? voucher.value / 100
                                                : 1))),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FlatButton(
                                disabledTextColor: Colors.grey,
                                disabledColor: Colors.grey,
                                onPressed: () {
                                  (cart.products.length == 0)
                                      ? _showMissingFieldDialog()
                                      : _checkoutCart(context, voucher);
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: LinearGradient(
                                        colors: [
                                          Color.fromRGBO(146, 127, 191, 1),
                                          Color.fromRGBO(79, 59, 120, 1)
                                        ],
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Checkout",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              StoreConnector<AppState, bool>(
                                distinct: true,
                                converter: (store) =>
                                    store.state.cartState.isLoading,
                                builder: (context, isLoading) {
                                  if (isLoading == true) {
                                    return LinearProgressIndicator(
                                      backgroundColor:
                                          Color.fromRGBO(196, 187, 240, 0.5),
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                        Color.fromRGBO(146, 127, 191, 1),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductInCheckOut extends StatelessWidget {
  final Product product;
  final int quantity;

  ProductInCheckOut({
    Key key,
    this.product,
    this.quantity,
  }) : super(key: key);

  final formatter = new NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            product.images[0]['url'],
            height: 50,
            width: 50,
          ),
          // Text(
          //   product.name,
          //   overflow: TextOverflow.ellipsis,
          // ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Row(
            children: [
              Text(
                "x ",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                quantity.toString(),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Row(
            children: [
              Text(
                "= ",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                formatter.format(product.discountPrice),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget cartWidget() {
  return Container(
    child: StoreConnector<AppState, Cart>(
      distinct: true,
      converter: (store) => store.state.cartState.cart,
      builder: (context, cart) {
        return Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cart.products != null
                  ? cart.products.map((item) {
                      if (item.check)
                        return ProductInCheckOut(
                          product: item.product,
                          quantity: item.quantity,
                        );
                      else
                        return Container();
                    }).toList()
                  : [Text("There's nothing in cart")],
            ),
          ),
        );
      },
    ),
  );

  // return FutureBuilder(
  //   future: Redux.store.dispatch(CartActions().getAllCartAction),
  //   builder: (context, projectSnap) {
  //     if (projectSnap.connectionState == ConnectionState.none &&
  //         projectSnap.hasData == null) {
  //       print('project snapshot data is: ${projectSnap.data}');
  //       return Container();
  //     }
  //     if (projectSnap.connectionState == ConnectionState.waiting) {
  //       return LinearProgressIndicator(
  //         backgroundColor: Color.fromRGBO(196, 187, 240, 0.5),
  //         valueColor: new AlwaysStoppedAnimation<Color>(
  //           Color.fromRGBO(146, 127, 191, 1),
  //         ),
  //       );
  //     }
  //     return Container(
  //       child: StoreConnector<AppState, String>(
  //         distinct: true,
  //         converter: (store) => store.state.userState.token,
  //         builder: (context, token) {
  //           if (token == null) {
  //             return Center(
  //               child: Column(
  //                 children: <Widget>[
  //                   Center(
  //                     child: Text(
  //                         "No authority! Please click button below to login"),
  //                   ),
  //                   Center(
  //                     child: FlatButton(
  //                         onPressed: () {
  //                           Navigator.pushReplacementNamed(context, '/login');
  //                         },
  //                         child: Text(
  //                           "Back to Login",
  //                           style: TextStyle(color: Colors.grey),
  //                         )),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           } else {
  //             return Column(
  //               children: [
  //                 StoreConnector<AppState, bool>(
  //                     distinct: true,
  //                     converter: (store) => store.state.cartState.isLoading,
  //                     builder: (context, isLoading) {
  //                       if (isLoading == true) {
  //                         return LinearProgressIndicator(
  //                           backgroundColor: Color.fromRGBO(196, 187, 240, 0.5),
  //                           valueColor: new AlwaysStoppedAnimation<Color>(
  //                             Color.fromRGBO(146, 127, 191, 1),
  //                           ),
  //                         );
  //                       } else {
  //                         return Container();
  //                       }
  //                     }),
  //                 Container(
  //                   child: StoreConnector<AppState, Cart>(
  //                     distinct: true,
  //                     converter: (store) => store.state.cartState.cart,
  //                     builder: (context, cart) {
  //                       return Container(
  //                         child: SingleChildScrollView(
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: cart.products != null
  //                                 ? cart.products.map((item) {
  //                                     return ProductInCheckOut(
  //                                       product: item.product,
  //                                       quantity: item.quantity,
  //                                     );
  //                                   }).toList()
  //                                 : [Text("There's nothing in cart")],
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             );
  //           }
  //         },
  //       ),
  //     );
  //   },
  // );
}
