import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_flutter/src/models/Favorite.dart';
import 'package:ecommerce_flutter/src/redux/favorite/favorite_state.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

@immutable
class SetFavoriteStateAction {
  final FavoriteState favoriteState;

  SetFavoriteStateAction(this.favoriteState);
}

class FavoriteActions {
  String token;
  Product product;
  int page;
  int size;

  FavoriteActions({
    this.token,
    this.product,
    this.page,
    this.size,
  });

  Future<void> getAllFavoriteAction(Store<AppState> store) async {
    print("get-favorite-action");

    store.dispatch(SetFavoriteStateAction(FavoriteState(isLoading: true)));
    try {
      final response = await http.get(
        '$backendUrl/products/like',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        store.dispatch(
          SetFavoriteStateAction(
            FavoriteState(
              isLoading: false,
              isSuccess: true,
              //totalPages: jsonData['count'],
              favoriteList: Favorite.fromJson(jsonData['data']),
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
      store.dispatch(SetFavoriteStateAction(
          FavoriteState(isLoading: false, isError: true)));
    }
  }

  Future<void> addFavoriteAction(Store<AppState> store) async {
    print("add-favorite-action");
    store.dispatch(SetFavoriteStateAction(FavoriteState(isLoading: true)));

    String productID = product.id.toString();

    try {
      final response = await http.post(
        '$backendUrl/products/$productID/like',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        Favorite newFavoriteList = store.state.favoriteState.favoriteList;

        newFavoriteList.product.add(product);
        print("newFavoriteList");

        store.dispatch(
          SetFavoriteStateAction(
            FavoriteState(
              isLoading: false,
              isSuccess: true,
              favoriteList: newFavoriteList,
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
      store.dispatch(SetFavoriteStateAction(
          FavoriteState(isLoading: false, isError: true)));
    }
  }

  Future<void> deleteFavoriteAction(Store<AppState> store) async {
    print("delete-favorite-action");
    store.dispatch(SetFavoriteStateAction(FavoriteState(isLoading: true)));

    String productID = product.id.toString();

    try {
      final response = await http.delete(
        '$backendUrl/products/$productID/like',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        Favorite newFavoriteList = store.state.favoriteState.favoriteList;

        newFavoriteList.product
            .removeWhere((iproduct) => iproduct.id == product.id);

        store.dispatch(
          SetFavoriteStateAction(
            FavoriteState(
              isLoading: false,
              isSuccess: true,
              favoriteList: newFavoriteList,
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
      store.dispatch(SetFavoriteStateAction(
          FavoriteState(isLoading: false, isError: true)));
    }
  }
}
