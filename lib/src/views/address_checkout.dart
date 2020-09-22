import 'package:ecommerce_flutter/src/models/Address.dart';
import 'package:ecommerce_flutter/src/redux/addresses/addresses_actions.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AddressCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Shipping Address",
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
      //         InkWell(
      //           onTap: () {
      //             Navigator.pop(context, {
      //               'name': "Name 1",
      //               'number': "Number 1",
      //               'address': "Address 1",
      //             });
      //           },
      //           child: Container(
      //             width: double.infinity,
      //             decoration: BoxDecoration(
      //               border: Border.all(
      //                 color: Colors.black,
      //               ),
      //             ),
      //             child: Container(
      //               padding: EdgeInsets.symmetric(
      //                 horizontal: 16,
      //                 vertical: 16,
      //               ),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                   Text(
      //                     "Name",
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.w700,
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                   Text("Number"),
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                   Text("Address detail"),
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 20,
      //         ),
      //         InkWell(
      //           onTap: () {
      //             Navigator.pop(context, {
      //               'name': "Name 2",
      //               'number': "Number 2",
      //               'address': "Address 2",
      //             });
      //           },
      //           child: Container(
      //             width: double.infinity,
      //             decoration: BoxDecoration(
      //               border: Border.all(
      //                 color: Colors.black,
      //               ),
      //             ),
      //             child: Container(
      //               padding: EdgeInsets.symmetric(
      //                 horizontal: 16,
      //                 vertical: 16,
      //               ),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                   Text(
      //                     "Name",
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.w700,
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                   Text("Number"),
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                   Text("Address detail"),
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 20,
      //         ),
      //         InkWell(
      //           onTap: () {
      //             Navigator.pop(context, {
      //               'name': "Name 3",
      //               'number': "Number 3",
      //               'address': "Address 3",
      //             });
      //           },
      //           child: Container(
      //             width: double.infinity,
      //             decoration: BoxDecoration(
      //               border: Border.all(
      //                 color: Colors.black,
      //               ),
      //             ),
      //             child: Container(
      //               padding: EdgeInsets.symmetric(
      //                 horizontal: 16,
      //                 vertical: 16,
      //               ),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                   Text(
      //                     "Name",
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.w700,
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                   Text("Number"),
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                   Text("Address detail"),
      //                   SizedBox(
      //                     height: 10,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: projectWidget(),
    );
  }
}

Widget projectWidget() {
  return FutureBuilder(
    future: Redux.store.dispatch(new AddressesActions(
      token: Redux.store.state.userState.token,
    ).getAllAddressesAction),
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
                child: StoreConnector<AppState, List<Address>>(
                  distinct: true,
                  converter: (store) => store.state.addressesState.addresses,
                  builder: (context, addresses) {
                    return Container(
                      //padding: EdgeInsets.symmetric(vertical: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: addresses.map((address) {
                            return InkWell(
                              onTap: () {
                                Navigator.pop(context, address);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 12,
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "User ID: ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  address.userId.toString(),
                                                  // style: TextStyle(
                                                  //   fontWeight: FontWeight.w700,
                                                  // ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          address.isPrimary == true
                                              ? Text(
                                                  "PRIMARY",
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        146, 127, 191, 1),
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text("Number: "),
                                          Text(address.phoneNumber),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text("Address detail: "),
                                          Text(address.locate),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
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
    },
  );
}
