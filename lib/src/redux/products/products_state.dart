import 'package:meta/meta.dart';

import 'package:ecommerce_flutter/src/models/i_product.dart';

@immutable
class ProductsState {
  final bool isError;
  final bool isLoading;
  final int count;
  final List<IProduct> products;

  ProductsState({
    this.isError,
    this.isLoading,
    this.count,
    this.products,
  });

  //factory constructor will be later used to fill the initial main state.
  factory ProductsState.initial() => ProductsState(
        isError: false,
        isLoading: false,
        count: null,
        products: const [],
      );

  //copyWith method will be later used to get a copy of our ProductsState to update this piece of the main state.
  ProductsState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required int count,
    @required List<IProduct> products,
  }) {
    return ProductsState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      count: count ?? this.count,
      products: products ?? this.products,
    );
  }
}
