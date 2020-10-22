import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_flutter/src/models/Address.dart';
import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:ecommerce_flutter/src/models/Voucher.dart';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_flutter/src/models/Cart.dart';
import 'package:ecommerce_flutter/src/redux/cart/cart_state.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

@immutable
class SetCartStateAction {
  final CartState cartState;

  SetCartStateAction(this.cartState);
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
        'http://35.213.174.112/api/shopping/my-cart',
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
      final response = await http
          .put('http://35.213.174.112/api/shopping/$productID', headers: {
        HttpHeaders.authorizationHeader: "Bearer $token"
      }, body: {
        'quantity': '$quantity',
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);

        // Cart newCartList = store.state.cartState.cartList;

        // newCartList.product.add(product);
        print("newCartList");

        // store.dispatch(
        //   SetCartStateAction(
        //     CartState(
        //       isLoading: false,
        //       isSuccess: true,
        //       // cartList: newCartList,
        //     ),
        //   ),
        // );
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
      final response = await http
          .put('http://35.213.174.112/api/shopping/$productID', headers: {
        HttpHeaders.authorizationHeader: "Bearer $token"
      }, body: {
        'quantity': '0',
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Cart newCartList = store.state.cartState.cart;

        // print("herer");
        // newCartList.products
        //     .removeWhere((iproduct) => iproduct.product.id == product.id);

        // store.dispatch(
        //   SetCartStateAction(
        //     CartState(
        //       isLoading: false,
        //       isSuccess: true,
        //       cart: newCartList,
        //     ),
        //   ),
        // );
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

  Future<void> checkoutCartAction(
      Store<AppState> store, Address address, Voucher voucher) async {
    print("checkout-cart-action");
    store.dispatch(SetCartStateAction(
        CartState(isLoading: true, isSuccess: false, isError: false)));

    var token = store.state.userState.token;

    print(voucher.code);

    try {
      final response = voucher != null
          ? await http.post('http://35.213.174.112/api/orders',
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $token",
                "Content-Type": "application/json",
              },
              body: jsonEncode(<String, dynamic>{
                'address_id': address.id,
                'voucher_code': voucher.code,
              }))
          : await http.post('http://35.213.174.112/api/orders',
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $token",
                "Content-Type": "application/json",
              },
              body: jsonEncode(<String, dynamic>{
                'address_id': address.id,
              }));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Cart newCartList = store.state.cartState.cart;

        // print("herer");
        // newCartList.products
        //     .removeWhere((iproduct) => iproduct.product.id == product.id);

        store.dispatch(
          SetCartStateAction(
            CartState(
              isLoading: false,
              isSuccess: true,
              checkoutSuccessed: true,
            ),
          ),
        );
        // store.dispatch(CartActions().getAllCartAction(store));
      } else {
        throw response.body;
      }
    } catch (error) {
      print(error);
      store.dispatch(
          SetCartStateAction(CartState(isLoading: false, isError: true)));
    }
  }
}
