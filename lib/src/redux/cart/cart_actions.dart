import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_flutter/src/models/Address.dart';
import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:ecommerce_flutter/src/models/Voucher.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce_flutter/src/models/Cart.dart';
import 'package:ecommerce_flutter/src/redux/cart/cart_state.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

@immutable
class SetCartStateAction {
  final CartState cartState;

  SetCartStateAction(this.cartState);
}

class ErrorMessage {
  String message;
  int status;

  ErrorMessage({
    this.message,
    this.status,
  });

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    if (json != null)
      return ErrorMessage(message: json['message'], status: json['status']);
    else
      return null;
  }
}

class CartActions {
  String token;
  Product product;
  int page;
  int size;

  CartActions({
    this.token,
    this.product,
    this.page,
    this.size,
  });

  Future<void> checkProductInCartAction(
      Store<AppState> store, int productId, bool value) async {
    print("check-cart-action");

    var token = store.state.userState.token;

    try {
      final response = await http.put(
        '$backendUrl/shopping/$productId/toggle',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        // Cart newCart = Cart.fromJson(jsonData['data']);

        Cart newCart = store.state.cartState.cart;
        newCart.products
            .firstWhere((element) => element.product.id == productId)
            .check = value;

        store.dispatch(
          SetCartStateAction(
            CartState(
              isLoading: false,
              isSuccess: true,
              //totalPages: jsonData['count'],
              cart: newCart,
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
      final jsonData = json.decode(error);
      var errorMessage = ErrorMessage.fromJson(jsonData['error']);

      if (errorMessage.message.contains('not authenticated')) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', null);
      }

      store.dispatch(
          SetCartStateAction(CartState(isLoading: false, isError: true)));
    }
  }

  Future<void> getAllCartAction(Store<AppState> store) async {
    print("get-cart-action");

    store.dispatch(SetCartStateAction(CartState(
        isLoading: true,
        isSuccess: false,
        isError: false,
        checkoutSuccessed: false)));

    var token = store.state.userState.token;

    try {
      final response = await http.get(
        '$backendUrl/shopping/my-cart',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        Cart newCart = Cart.fromJson(jsonData['data']);

        newCart.products.removeWhere((element) => element.quantity == 0);

        store.dispatch(
          SetCartStateAction(
            CartState(
              isLoading: false,
              isSuccess: true,
              //totalPages: jsonData['count'],
              cart: newCart,
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
      final jsonData = json.decode(error);
      var errorMessage = ErrorMessage.fromJson(jsonData['error']);

      if (errorMessage.message.contains('not authenticated')) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', null);
      }

      store.dispatch(
          SetCartStateAction(CartState(isLoading: false, isError: true)));
    }
  }

  Future<void> addCartAction(
      Store<AppState> store, Product product, int quantity) async {
    print("add-cart-action");
    store.dispatch(SetCartStateAction(
        CartState(isLoading: true, isSuccess: false, isError: false)));

    var token = store.state.userState.token;

    String productID = product.id.toString();

    try {
      final response =
          await http.put('$backendUrl/shopping/$productID', headers: {
        HttpHeaders.authorizationHeader: "Bearer $token"
      }, body: {
        'quantity': '$quantity',
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        print("newCartList");

        store.dispatch(CartActions().getAllCartAction(store));
      }
    } catch (error) {
      print(error);
      store.dispatch(
          SetCartStateAction(CartState(isLoading: false, isError: true)));
    }
  }

  Future<void> deleteCartAction(Store<AppState> store, Product product) async {
    print("delete-cart-action");
    store.dispatch(SetCartStateAction(
        CartState(isLoading: true, isSuccess: false, isError: false)));

    var token = store.state.userState.token;

    String productID = product.id.toString();

    try {
      final response =
          await http.put('$backendUrl/shopping/$productID', headers: {
        HttpHeaders.authorizationHeader: "Bearer $token"
      }, body: {
        'quantity': '0',
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        store.dispatch(CartActions().getAllCartAction(store));
      } else {
        throw response.body;
      }
    } catch (error) {
      print(error);
      store.dispatch(
          SetCartStateAction(CartState(isLoading: false, isError: true)));
    }
  }

  Future<void> removeUncheckFromCart(
      Store<AppState> store, List<ProductInCart> productList) async {
    print("remove-uncheck-cart in cart");

    store.dispatch(SetCartStateAction(
        CartState(isLoading: true, isSuccess: false, isError: false)));

    var token = store.state.userState.token;

    try {
      final responses = await Future.wait(productList.map((e) {
        int productId = e.product.id;
        print(productId);
        return http.put('$backendUrl/shopping/$productId', headers: {
          HttpHeaders.authorizationHeader: "Bearer $token"
        }, body: {
          'quantity': '0',
        });
      }));

      if (responses.contains((ele) => {ele.status != 200}))
        throw ('Error when remove');
    } catch (error) {
      print(error);
      store.dispatch(
          SetCartStateAction(CartState(isLoading: false, isError: true)));
    }
  }

  Future<void> addUncheckToNewCart(
      Store<AppState> store, List<ProductInCart> productList) async {
    print("add-uncheck-cart to new-cart");

    store.dispatch(SetCartStateAction(
        CartState(isLoading: true, isSuccess: false, isError: false)));

    var token = store.state.userState.token;

    try {
      final responses = await Future.wait(productList.map((e) {
        int productId = e.product.id;
        print(productId);
        return http.put('$backendUrl/shopping/$productId', headers: {
          HttpHeaders.authorizationHeader: "Bearer $token"
        }, body: {
          'quantity': e.quantity.toString(),
        });
      }));

      if (responses.contains((ele) => {ele.status != 200}))
        throw ('Error when remove');
    } catch (error) {
      print(error);
      store.dispatch(
          SetCartStateAction(CartState(isLoading: false, isError: true)));
    }
  }

  Future<void> checkoutCartAction(
      Store<AppState> store, Address address, Voucher voucher) async {
    print("checkout-cart-action");

    store.dispatch(SetCartStateAction(
        CartState(isLoading: true, isSuccess: false, isError: false)));

    var uncheckCart = Cart.clone(store.state.cartState.cart);
    uncheckCart.products = store.state.cartState.cart.products
        .where((item) => item.check == false)
        .map((item) => item)
        .toList();

    //Remove from checkout cart
    //store.dispatch(removeUncheckFromCart(store, uncheckCart.products));

    var token = store.state.userState.token;

    try {
      final response = await http.post('$backendUrl/orders',
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            "Content-Type": "application/json",
          },
          body: jsonEncode(<String, dynamic>{
            'address_id': address != null ? address.id : '',
            'voucher_code': voucher != null ? voucher.code : '',
          }));

      if (response.statusCode == 200) {
        store.dispatch(
          SetCartStateAction(
            CartState(
              isLoading: false,
              isSuccess: true,
              checkoutSuccessed: true,
            ),
          ),
        );

        store.dispatch(addUncheckToNewCart(store, uncheckCart.products));
      } else {
        throw response.body;
      }
    } catch (error) {
      print(error);
      // store.dispatch(addUncheckToNewCart(store, uncheckCart.products));
      store.dispatch(
          SetCartStateAction(CartState(isLoading: false, isError: true)));
      throw (CheckoutErrorMessage.fromJson(json.decode(error)));
    }
  }
}

class CheckoutErrorMessage {
  String code;
  String message;
  String status;

  CheckoutErrorMessage({
    this.code,
    this.message,
    this.status,
  });

  factory CheckoutErrorMessage.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return CheckoutErrorMessage(
        code: json['code'] != null ? json['code'] : null,
        message: json['message'] != null ? json['message'] : null,
        status: json['status'] != null ? json['status'] : null,
      );
    } else
      return null;
  }
}
