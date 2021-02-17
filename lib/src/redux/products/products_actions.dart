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
        '$backendUrl/products',
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

  Future<void> getProductDetailAction(Store<AppState> store, int id) async {
    store.dispatch(SetProductsStateAction(ProductsState(isLoading: true)));

    try {
      var token = store.state.userState.token;

      final response = await http.get(
        '$backendUrl/products/$id',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];

        store.dispatch(
          SetProductsStateAction(
            ProductsState(
              isLoading: false,
              isSuccess: true,
              productDetail: Product.fromJson(jsonData),
            ),
          ),
        );
      }
    } catch (error) {
      store.dispatch(SetProductsStateAction(
          ProductsState(isLoading: false, isError: true)));
    }
  }

  Future<void> getMoreProductsAction(Store<AppState> store, int page) async {
    store.dispatch(SetProductsStateAction(ProductsState(isLoading: true)));

    print("begin-get-more");

    try {
      var token = store.state.userState.token;

      final response = await http.get(
        '$backendUrl/products?page=$page',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];

        var oldProductsList = store.state.productsState.products;
        var newProductsListData = Product.listFromJson(jsonData['entries']);

        var newProductList = [...oldProductsList, ...newProductsListData];

        store.dispatch(
          SetProductsStateAction(
            ProductsState(
              isLoading: false,
              isSuccess: true,
              products: page == 1 ? newProductsListData : newProductList,
            ),
          ),
        );
      }
    } catch (error) {
      store.dispatch(SetProductsStateAction(
          ProductsState(isLoading: false, isError: true)));
    }
  }

  Future<void> getMoreSearchProductsAction(
      Store<AppState> store, int page, String search, int brandId) async {
    store.dispatch(SetProductsStateAction(ProductsState(isLoading: true)));

    print("begin-get-more-search");

    try {
      var token = store.state.userState.token;
      final response = await http.get(
        '$backendUrl/products?page=$page&&search_terms=${search != null ? search : ''}${brandId != null ? '&&brand_id=$brandId' : ''}',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];

        var oldProductsList = store.state.productsState.searchProducts;
        var newProductsListData = Product.listFromJson(jsonData['entries']);

        var newProductList = [...oldProductsList, ...newProductsListData];

        store.dispatch(
          SetProductsStateAction(
            ProductsState(
              isLoading: false,
              isSuccess: true,
              searchProducts: page == 1 ? newProductsListData : newProductList,
            ),
          ),
        );
      }
    } catch (error) {
      store.dispatch(SetProductsStateAction(
          ProductsState(isLoading: false, isError: true)));
    }
  }

  void cleanSearchProductsAction(Store<AppState> store) {
    store.dispatch(SetProductsStateAction(ProductsState(searchProducts: [])));
  }

  Future<void> getContentBaseRecommendAction(
      Store<AppState> store, int id, int size) async {
    store.dispatch(SetProductsStateAction(ProductsState(isLoading: true)));

    print('get-content-base');
    try {
      var token = store.state.userState.token;

      final response = await http.get(
        '$backendUrl/products/content_based_recommend?size=$size&&product_id=$id',
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
      Store<AppState> store, int id, int size) async {
    store.dispatch(SetProductsStateAction(ProductsState(isLoading: true)));
    print('get-collab-recommend');

    try {
      var token = store.state.userState.token;

      final response = await http.get(
        '$backendUrl/products/collaborative_recommend?size=$size&&product_id=$id',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];

        store.dispatch(
          SetProductsStateAction(
            ProductsState(
              isLoading: false,
              isSuccess: true,
              recommendCollabProducts:
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
