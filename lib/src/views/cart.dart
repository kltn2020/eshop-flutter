import 'package:ecommerce_flutter/src/models/Cart.dart';
import 'package:ecommerce_flutter/src/redux/cart/cart_actions.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

class CartView extends StatefulWidget {
  // static String get routeName => '@routes/home-page';

  CartView({Key key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool selectAllCheck = false;
  bool productCheck = false;
  int productCount = 0;

  var applyVoucher;

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.pushNamed(context, '/voucher-apply');

    setState(() {
      applyVoucher = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Cart",
          style: TextStyle(
            color: Color.fromRGBO(79, 59, 120, 1),
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      // body: Container(
      //   padding: EdgeInsets.symmetric(
      //     horizontal: 0,
      //     vertical: 32,
      //   ),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Row(
      //           children: [
      //             Checkbox(
      //               activeColor: Theme.of(context).primaryColor,
      //               value: selectAllCheck,
      //               onChanged: (bool value) {
      //                 setState(() {
      //                   selectAllCheck = value;
      //                 });
      //               },
      //             ),
      //             Text("Check all"),
      //           ],
      //         ),
      //         ...items
      //             .map(
      //               (item) => ProductInCart(
      //                 title: item,
      //                 check: selectAllCheck,
      //                 onChecked: (bool value) {
      //                   setState(
      //                     () {
      //                       selectAllCheck = value;
      //                     },
      //                   );
      //                 },
      //                 number: productCount,
      //                 onAdd: () {
      //                   setState(
      //                     () {
      //                       productCount++;
      //                     },
      //                   );
      //                 },
      //                 onSubtract: () {
      //                   setState(
      //                     () {
      //                       productCount--;
      //                     },
      //                   );
      //                 },
      //                 onDelete: () {
      //                   setState(
      //                     () {
      //                       productCount = 0;
      //                     },
      //                   );
      //                 },
      //               ),
      //             )
      //             .toList(),
      //       ],
      //     ),
      //   ),
      // ),
      body: projectWidget(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: 10000000",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _navigateAndDisplaySelection(context);
                },
                child: Text(
                  applyVoucher == null ? "Apply Voucher >" : applyVoucher.code,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/checkout"),
        tooltip: 'Click to checkout',
        child: Text("Buy"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ProductInCart extends StatelessWidget {
  final String imageURL;
  final String title;
  final int price;
  final bool check;
  final Function onChecked;
  final int number;
  final Function onAdd;
  final Function onSubtract;
  final Function onDelete;

  ProductInCart({
    Key key,
    this.imageURL,
    this.title,
    this.price,
    this.check,
    this.onChecked,
    this.number,
    this.onAdd,
    this.onSubtract,
    this.onDelete,
  }) : super(key: key);

  final formatter = new NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                value: check,
                onChanged: onChecked,
              ),
              Image.network(
                imageURL,
                height: 50,
                width: 50,
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      formatter.format(price),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: onDelete)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: onSubtract),
              SizedBox(
                width: 30,
              ),
              Text(number.toString()),
              SizedBox(
                width: 30,
              ),
              IconButton(
                  icon: Icon(Icons.add_circle_outline), onPressed: onAdd),
            ],
          )
        ],
      ),
    );
  }
}

Widget projectWidget() {
  return FutureBuilder(
    future: Redux.store.dispatch(CartActions().getAllCartAction),
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
              return Column(
                children: [
                  StoreConnector<AppState, bool>(
                      distinct: true,
                      converter: (store) => store.state.cartState.isLoading,
                      builder: (context, isLoading) {
                        if (isLoading == true) {
                          return LinearProgressIndicator(
                            backgroundColor: Color.fromRGBO(196, 187, 240, 0.5),
                            valueColor: new AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(146, 127, 191, 1),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                  Container(
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
                                      return ProductInCart(
                                        imageURL: item.product.images[0]['url'],
                                        title: item.product.name,
                                        price: item.product.price,
                                        check: false,
                                        number: item.quantity,
                                        onAdd: () {
                                          Redux.store.dispatch(
                                            CartActions().addCartAction(
                                                Redux.store,
                                                item.product,
                                                item.quantity + 1),
                                          );
                                        },
                                        onSubtract: () {
                                          Redux.store.dispatch(
                                            CartActions().addCartAction(
                                                Redux.store,
                                                item.product,
                                                item.quantity - 1),
                                          );
                                        },
                                        onDelete: () {
                                          Redux.store.dispatch(
                                            CartActions().deleteCartAction(
                                                Redux.store, item.product),
                                          );
                                        },
                                      );
                                    }).toList()
                                  : [Text("There's nothing in cart")],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      );
    },
  );
}
