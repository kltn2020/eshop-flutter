import 'package:meta/meta.dart';

import 'package:ecommerce_flutter/src/models/Cart.dart';

@immutable
class CartState {
  final bool isError;
  final bool isLoading;
  final bool isSuccess;
  final int totalItems;
  final int totalPages;
  final Cart cart;

  CartState({
    this.isError,
    this.isLoading,
    this.isSuccess,
    this.totalItems,
    this.totalPages,
    this.cart,
  });

  //factory constructor will be later used to fill the initial main state.
  factory CartState.initial() => CartState(
        isError: null,
        isSuccess: null,
        isLoading: false,
        totalItems: null,
        totalPages: null,
        cart: null,
      );

  //copyWith method will be later used to get a copy of our CartState to update this piece of the main state.
  CartState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required bool isSuccess,
    @required int totalItems,
    @required int totalPages,
    @required Cart cart,
  }) {
    return CartState(
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      cart: cart ?? this.cart,
    );
  }
}
