import 'package:ecommerce_flutter/src/redux/vouchers/vouchers_actions.dart';
import 'package:ecommerce_flutter/src/views/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ecommerce_flutter/src/models/Voucher.dart';
import 'package:ecommerce_flutter/src/redux/favorite/favorite_actions.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:intl/intl.dart';

class VoucherList extends StatefulWidget {
  // static String get routeName => '@routes/home-page';

  VoucherList({Key key}) : super(key: key);

  @override
  _VoucherListState createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Voucher List",
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
  final dateF = new DateFormat('dd/MM/yyyy');

  return FutureBuilder(
    future: Redux.store
        .dispatch(new VoucherActions().getAllVoucherAction(Redux.store)),
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
                child: StoreConnector<AppState, List<Voucher>>(
                  distinct: true,
                  converter: (store) => store.state.vouchersState.vouchers,
                  builder: (context, vouchers) {
                    if (vouchers != null)
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: vouchers.map((voucher) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 16,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'CODE: ${voucher.code}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Category: ${voucher.category.name}',
                                              style: TextStyle(),
                                            ),
                                            SizedBox(
                                              height: 10,
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
                                    ),
                                    Text(
                                      'Discount: ${voucher.value.toString()}%',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    else
                      return Container();
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
