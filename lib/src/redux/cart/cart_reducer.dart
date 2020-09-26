import 'package:ecommerce_flutter/src/redux/cart/cart_actions.dart';
import 'package:ecommerce_flutter/src/redux/cart/cart_state.dart';

cartReducer(CartState prevState, SetCartStateAction action) {
  final payload = action.cartState;
  print("cart-reducer");
  return prevState.copyWith(
    isError: payload.isError,
    isLoading: payload.isLoading,
    isSuccess: payload.isSuccess,
    totalItems: payload.totalItems,
    totalPages: payload.totalPages,
    cart: payload.cart,
  );
}