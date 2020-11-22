import 'package:meta/meta.dart';

import 'package:ecommerce_flutter/src/models/Product.dart';

@immutable
class ProductsState {
  final bool isError;
  final bool isLoading;
  final bool isSuccess;
  final int totalItems;
  final int totalPages;
  final List<Product> products;
  final List<Product> recommendContentProducts;

  ProductsState({
    this.isError,
    this.isLoading,
    this.isSuccess,
    this.totalItems,
    this.totalPages,
    this.products,
    this.recommendContentProducts,
  });

  //factory constructor will be later used to fill the initial main state.
  factory ProductsState.initial() => ProductsState(
        isError: null,
        isSuccess: null,
        isLoading: false,
        totalItems: null,
        totalPages: null,
        products: const [],
        recommendContentProducts: const [],
      );

  //copyWith method will be later used to get a copy of our ProductsState to update this piece of the main state.
  ProductsState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required bool isSuccess,
    @required int totalItems,
    @required int totalPages,
    @required List<Product> products,
    @required List<Product> recommendContentProducts,
  }) {
    return ProductsState(
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      products: products ?? this.products,
      recommendContentProducts:
          recommendContentProducts ?? this.recommendContentProducts,
    );
  }
}
