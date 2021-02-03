import 'package:ecommerce_flutter/src/models/Voucher.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:ecommerce_flutter/src/redux/vouchers/vouchers_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';

class VoucherApply extends StatelessWidget {
  final dateF = new DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Apply Voucher",
          style: TextStyle(
            color: Color.fromRGBO(79, 59, 120, 1),
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Column(
        children: [
          // Container(
          //   margin: EdgeInsets.all(32),
          //   child: TextField(
          //     controller: null,
          //     onSubmitted: (value) {
          //       print(value);
          //       Redux.store.dispatch(new VoucherActions()
          //           .checkVoucherAction(Redux.store, value));
          //     },
          //     decoration: InputDecoration(
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(50)),
          //       ),
          //     ),
          //   ),
          // ),
          // FlatButton(
          //   onPressed: () {
          //     // Redux.store.dispatch(
          //     //     new VoucherActions().checkVoucherAction(Redux.store, value));
          //   },
          //   child: Container(
          //     height: 50,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(50),
          //       gradient: LinearGradient(colors: [
          //         Color.fromRGBO(146, 127, 191, 1),
          //         Color.fromRGBO(79, 59, 120, 1)
          //       ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          //     ),
          //     child: Center(
          //       child: Text(
          //         "Check coder",
          //         style: TextStyle(
          //             color: Colors.white, fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ),
          // ),
          // projectWidget(),
          StoreConnector<AppState, bool>(
            distinct: true,
            converter: (store) => store.state.vouchersState.isLoading,
            builder: (context, isLoading) {
              if (isLoading) {
                return LinearProgressIndicator();
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          StoreConnector<AppState, bool>(
            distinct: true,
            converter: (store) => store.state.vouchersState.isError,
            builder: (context, isError) {
              // if (isError != null) {
              //   return Text("Something's wrong");
              // } else {
              //   return SizedBox.shrink();
              // }
              return Container();
            },
          ),

          StoreConnector<AppState, List<Voucher>>(
            distinct: true,
            converter: (store) => store.state.vouchersState.vouchers,
            onInit: (store) => store.dispatch(
                new VoucherActions().getAllVoucherAction(Redux.store)),
            builder: (context, vouchers) {
              if (vouchers != null) {
                return SingleChildScrollView(
                  child: Column(
                    children: vouchers.map(
                      (voucher) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 8,
                          ),
                          padding: EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context, voucher);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Voucher code: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(voucher.code),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Category: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(voucher.category.name),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Discount: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(voucher.value.toString()),
                                    Text("%"),
                                  ],
                                ),
                                Text(
                                  'Exp: ${dateF.format(DateTime.parse(voucher.validTo))}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                );
              } else {
                return Container(
                  child: Text("No data"),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

// Widget projectWidget() {
//   return FutureBuilder(
//     // future: Redux.store
//     //     .dispatch(new VoucherActions().getAllVouchersAction(Redux.store)),
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
//                 child: StoreConnector<AppState, List<Voucher>>(
//                   distinct: true,
//                   converter: (store) => store.state.vouchersState.vouchers,
//                   builder: (context, vouchers) {
//                     return Container(
//                       padding: EdgeInsets.symmetric(vertical: 32),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: vouchers.map((voucher) {
//                             print(voucher);
//                             return Container();
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
