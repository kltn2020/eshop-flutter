import 'package:ecommerce_flutter/src/models/Favorite.dart';
import 'package:ecommerce_flutter/src/models/Order.dart';
import 'package:ecommerce_flutter/src/redux/favorite/favorite_actions.dart';
import 'package:ecommerce_flutter/src/redux/orders/orders_actions.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

class OrderDetail extends StatefulWidget {
  // static String get routeName => '@routes/home-page';
  final int orderId;

  OrderDetail({Key key, this.orderId}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final formatter = new NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Order Detail",
          style: TextStyle(
            color: Color.fromRGBO(79, 59, 120, 1),
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: projectWidget(widget.orderId),
    );
  }
}

Widget projectWidget(int id) {
  final formatter = new NumberFormat("#,###");
  final dateF = new DateFormat('dd/MM/yyyy');

  return FutureBuilder(
    future: Redux.store.dispatch(OrderActions(orderId: id).getByIdOrderAction),
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
                child: StoreConnector<AppState, Order>(
                  distinct: true,
                  converter: (store) => store.state.ordersState.order,
                  builder: (context, order) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: SingleChildScrollView(
                        child:
                            //Order Container
                            Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 8,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    dateF.format(
                                        DateTime.parse(order.orderDate)),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Status: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        order.status.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: getStatusColor(order.status),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Voucher: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Phone number: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        order.address.phoneNumber,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Address: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        order.address.locate,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Billing",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                //Cart
                                Column(
                                  children:
                                      order.productList.map((productInOrder) {
                                    return Container(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            productInOrder.product.images[0]
                                                ['url'],
                                            height: 50,
                                            width: 50,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  productInOrder.product.name,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  formatter.format(
                                                      productInOrder.price),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "x" +
                                                formatter.format(
                                                    productInOrder.quantity),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            formatter.format(
                                                productInOrder.price -
                                                    productInOrder.discount),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                //End Cart
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Sum:",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          formatter.format(
                                              order.total + order.discount),
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Discount:",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "- " +
                                              formatter.format(order.discount),
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total:",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          formatter.format(order.total),
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromRGBO(
                                                146, 127, 191, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //End Order Container
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

Color getStatusColor(String status) {
  if (status == 'processing') {
    return Colors.amber[600];
  } else if (status == 'shipping') {
    return Colors.blue;
  } else if (status == 'completed') {
    return Colors.green;
  } else {
    return Colors.redAccent;
  }
}

// Widget projectWidget() {
//   final formatter = new NumberFormat("#,###");

//   return FutureBuilder(
//     future: Redux.store.dispatch(
//         new FavoriteActions(token: Redux.store.state.userState.token)
//             .getAllFavoriteAction),
//     builder: (context, projectSnap) {
//       if (projectSnap.connectionState == ConnectionState.none &&
//           projectSnap.hasData == null) {
//         print('project snapshot data is: ${projectSnap.data}');
//         return Container();
//       }
//       if (projectSnap.connectionState == ConnectionState.waiting) {
//         return LinearProgressIndicator(
//           backgroundColor: Color.fromRGBO(196, 187, 240, 0.5),
//           valueColor: new AlwaysStoppedAnimation<Color>(
//             Color.fromRGBO(146, 127, 191, 1),
//           ),
//         );
//       }
//       return Container(
//         child: StoreConnector<AppState, String>(
//           distinct: true,
//           converter: (store) => store.state.userState.token,
//           builder: (context, token) {
//             if (token == null) {
//               return Center(
//                 child: Column(
//                   children: <Widget>[
//                     Center(
//                       child: Text(
//                           "No authority! Please click button below to login"),
//                     ),
//                     Center(
//                       child: FlatButton(
//                           onPressed: () {
//                             Navigator.pushReplacementNamed(context, '/login');
//                           },
//                           child: Text(
//                             "Back to Login",
//                             style: TextStyle(color: Colors.grey),
//                           )),
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               return Container(
//                 child: StoreConnector<AppState, Favorite>(
//                   distinct: true,
//                   converter: (store) => store.state.favoriteState.favoriteList,
//                   builder: (context, favoriteList) {
//                     return Container(
//                       padding: EdgeInsets.symmetric(vertical: 32),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: favoriteList.product.map((product) {
//                             print(product);
//                             return Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 16,
//                               ),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: InkWell(
//                                       onTap: () {
//                                         // Navigator.push(
//                                         //     context,
//                                         //     MaterialPageRoute(
//                                         //       builder: (context) => ProductPage(
//                                         //         product: product,
//                                         //       ),
//                                         //     ));
//                                       },
//                                       child: Container(
//                                         padding:
//                                             EdgeInsets.symmetric(horizontal: 8),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               product.name,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 18,
//                                               ),
//                                             ),
//                                             product.discountPrice > 0
//                                                 ? Row(
//                                                     children: [
//                                                       Text(
//                                                         formatter.format(product
//                                                             .discountPrice),
//                                                         style: TextStyle(
//                                                           fontSize: 20,
//                                                           color: Color.fromRGBO(
//                                                               146, 127, 191, 1),
//                                                           fontWeight:
//                                                               FontWeight.w900,
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 5,
//                                                       ),
//                                                       Text(
//                                                         formatter.format(
//                                                             product.price),
//                                                         style: TextStyle(
//                                                           fontSize: 16,
//                                                           color: Colors.grey,
//                                                           decoration:
//                                                               TextDecoration
//                                                                   .lineThrough,
//                                                         ),
//                                                       )
//                                                     ],
//                                                   )
//                                                 : Text(
//                                                     formatter
//                                                         .format(product.price),
//                                                     style: TextStyle(
//                                                       fontSize: 20,
//                                                       color: Color.fromRGBO(
//                                                           146, 127, 191, 1),
//                                                       fontWeight:
//                                                           FontWeight.w900,
//                                                     ),
//                                                   ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   FlatButton(
//                                     onPressed: () {
//                                       print("Add to cart");
//                                     },
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal: 16,
//                                         vertical: 8,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1,
//                                           color: Colors.black,
//                                         ),
//                                         borderRadius: BorderRadius.circular(50),
//                                         color: Color.fromRGBO(196, 187, 240, 1),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           "Add to cart",
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             }
//           },
//         ),
//       );
//     },
//   );
// }
