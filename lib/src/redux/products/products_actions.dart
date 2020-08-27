import 'dart:convert';
import 'dart:io';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_flutter/src/models/i_product.dart';
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
      final response = await http.get(
          'https://rocky-sierra-70366.herokuapp.com/api/products?size=20&&page=1');

      assert(response.statusCode == 200);
      final jsonData = json.decode(response.body);

      print(jsonData);

      store.dispatch(
        SetProductsStateAction(
          ProductsState(
            isLoading: false,
            isSuccess: true,
            //totalPages: jsonData['count'],
            products: IProduct.listFromJson(jsonData.data['entries']),
          ),
        ),
      );
    } catch (error) {
      print(error);
      store.dispatch(SetProductsStateAction(
          ProductsState(isLoading: false, isError: true)));
    }
  }
}
