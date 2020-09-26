import 'dart:convert';
import 'package:ecommerce_flutter/src/redux/favorite/favorite_actions.dart';
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
  String token;
  int page;
  int size;

  ProductActions({
    this.token,
    this.page,
    this.size,
  });

  Future<void> getAllProductsAction(Store<AppState> store) async {
    store.dispatch(SetProductsStateAction(ProductsState(isLoading: true)));

    try {
      final response = await http
          .get('https://rocky-sierra-70366.herokuapp.com/api/products');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];

        store.dispatch(
          SetProductsStateAction(
            ProductsState(
              isLoading: false,
              isSuccess: true,
              //totalPages: jsonData['count'],
              products: Product.listFromJson(jsonData['entries']),
            ),
          ),
        );

        store.dispatch(FavoriteActions().getAllFavoriteAction(store));
      }
    } catch (error) {
      print(error);
      store.dispatch(SetProductsStateAction(
          ProductsState(isLoading: false, isError: true)));
    }
  }
}
