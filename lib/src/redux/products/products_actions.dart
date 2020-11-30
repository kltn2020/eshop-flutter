import 'dart:convert';
import 'dart:io';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:ecommerce_flutter/src/redux/products/products_state.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

@immutable
class SetProductsStateAction {
  final ProductsState productsState;

  SetProductsStateAction(this.productsState);
}

class ProductActions {
  Future<void> getAllProductsAction(
      Store<AppState> store, int page, int size) async {
    store.dispatch(SetProductsStateAction(ProductsState(isLoading: true)));

    try {
      var token = store.state.userState.token;

      final response = await http.get(
        'http://35.213.174.112/api/products',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];

        store.dispatch(
          SetProductsStateAction(
            ProductsState(
              isLoading: false,
              isSuccess: true,
              products: Product.listFromJson(jsonData['entries']),
            ),
          ),
        );
      }
    } catch (error) {
      store.dispatch(SetProductsStateAction(
          ProductsState(isLoading: false, isError: true)));
    }
  }

  Future<void> getContentBaseRecommendAction(
      Store<AppState> store, int page, int size) async {
    store.dispatch(SetProductsStateAction(ProductsState(isLoading: true)));

    try {
      var token = store.state.userState.token;

      final response = await http.get(
        'http://35.213.174.112/api/products/content_based_recommend?size=10',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];

        store.dispatch(
          SetProductsStateAction(
            ProductsState(
              isLoading: false,
              isSuccess: true,
              recommendContentProducts:
                  Product.listFromJson(jsonData['entries']),
            ),
          ),
        );
      }
    } catch (error) {
      store.dispatch(SetProductsStateAction(
          ProductsState(isLoading: false, isError: true)));
    }
  }

  Future<void> getCollaborativeRecommendAction(
      Store<AppState> store, int page, int size) async {
    store.dispatch(SetProductsStateAction(ProductsState(isLoading: true)));

    try {
      var token = store.state.userState.token;

      final response = await http.get(
        'http://35.213.174.112/api/products/collaborative_recommend',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];

        store.dispatch(
          SetProductsStateAction(
            ProductsState(
              isLoading: false,
              isSuccess: true,
              recommendContentProducts:
                  Product.listFromJson(jsonData['entries']),
            ),
          ),
        );
      }
    } catch (error) {
      store.dispatch(SetProductsStateAction(
          ProductsState(isLoading: false, isError: true)));
    }
  }
}
