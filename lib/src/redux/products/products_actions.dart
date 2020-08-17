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

Future<void> fetchProductsAction(Store<AppState> store) async {
  store.dispatch(SetProductsStateAction(ProductsState(isLoading: true)));

  try {
    final response = await http.get(
      'http://10.0.2.2:8000/api/products?limit=5',
      headers: {
        HttpHeaders.authorizationHeader:
            "Token 21d665472f2d12c8f0e3120cca47562f9e2d5ffa4992ae796e931c0378e574aa"
      },
    );

    assert(response.statusCode == 200);
    final jsonData = json.decode(response.body);

    store.dispatch(
      SetProductsStateAction(
        ProductsState(
          isLoading: false,
          count: jsonData['count'],
          products: IProduct.listFromJson(jsonData['results']),
        ),
      ),
    );
  } catch (error) {
    print(error);
    store.dispatch(SetProductsStateAction(ProductsState(isLoading: false)));
  }
}
