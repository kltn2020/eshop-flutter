import 'package:ecommerce_flutter/src/views/address_checkout.dart';
import 'package:ecommerce_flutter/src/views/checkout.dart';
import 'package:ecommerce_flutter/src/views/intro.dart';
import 'package:ecommerce_flutter/src/views/order_detail.dart';
import 'package:ecommerce_flutter/src/views/order_history.dart';
import 'package:ecommerce_flutter/src/views/rating_create.dart';
import 'package:ecommerce_flutter/src/views/rating_list.dart';
import 'package:ecommerce_flutter/src/views/search_product.dart';
import 'package:ecommerce_flutter/src/views/voucher_apply.dart';
import 'package:ecommerce_flutter/src/views/voucher_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:ecommerce_flutter/src/views/home.dart';
import 'package:ecommerce_flutter/src/views/product_list.dart';
import 'package:ecommerce_flutter/src/views/login.dart';
import 'package:ecommerce_flutter/src/views/register.dart';
import 'package:ecommerce_flutter/src/views/confirm_email.dart';
import 'package:ecommerce_flutter/src/views/category_list.dart';
import 'package:ecommerce_flutter/src/views/notifications.dart';
import 'package:ecommerce_flutter/src/views/user.dart';
import 'package:ecommerce_flutter/src/views/account_info.dart';
import 'package:ecommerce_flutter/src/views/account_setting.dart';
import 'package:ecommerce_flutter/src/views/address_create.dart';
import 'package:ecommerce_flutter/src/views/address_list.dart';
import 'package:ecommerce_flutter/src/views/cart.dart';
import 'package:ecommerce_flutter/src/views/favorite_list.dart';
import 'package:ecommerce_flutter/src/views/payment_checkout.dart';
import 'package:ecommerce_flutter/src/views/help_center.dart';

//StoreProvider it passes our Redux Store to our tree of widgets.
//StoreConnector gets the Store from StoreProvider, reads a piece of data from our store and passes that data to its builder function, then whenever that data changes, rebuilds itself.

void main() async {
  await Redux.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: Redux.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Barlow',
          primaryColor: Color.fromRGBO(79, 59, 120, 1),
          textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: 1.0,
                fontSizeDelta: 2.0,
              ),
        ),
        title: 'Shop',
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/intro': (context) => Intro(),
          '/product-list': (context) => ProductList(title: 'Product List'),
          '/category-list': (context) => CategoryList(),
          '/notifications': (context) => Notifications(title: 'Notifications'),
          '/user': (context) => User(title: 'User'),
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          '/confirm-email': (context) => ConfirmEmail(),
          '/favorite-list': (context) => FavoriteList(),
          '/order-history': (context) => OrderHistory(),
          '/order-detail': (context) => OrderDetail(),
          '/account-setting': (context) => AccountSetting(),
          '/account-info': (context) => AccountInfo(),
          '/address-list': (context) => AddressList(),
          '/address-create': (context) => AddressCreate(),
          '/rating-list': (context) => RatingList(),
          '/rating-create': (context) => ReviewCreate(),
          // '/address-detail': (context) => AddressDetail(),
          '/cart': (context) => CartView(),
          '/voucher-apply': (context) => VoucherApply(),
          '/voucher-list': (context) => VoucherList(),
          '/checkout': (context) => CheckOut(),
          '/address-checkout': (context) => AddressCheckout(),
          '/payment-checkout': (context) => PaymentCheckout(),
          '/help-center': (context) => HelpCenter(),
          '/search-product': (context) => SearchProductList(),
        },
      ),
    );
  }
}
