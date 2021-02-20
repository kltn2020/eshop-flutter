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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Address detail: "),
                                          Expanded(
                                            child: Text(address.locate,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2),
                                          ),
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
