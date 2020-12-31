import 'package:ecommerce_flutter/src/redux/products/products_actions.dart';
import 'package:ecommerce_flutter/src/redux/products/products_state.dart';

productsReducer(ProductsState prevState, SetProductsStateAction action) {
  final payload = action.productsState;

  return prevState.copyWith(
    isError: payload.isError,
    isLoading: payload.isLoading,
    isSuccess: payload.isSuccess,
    totalItems: payload.totalItems,
    totalPages: payload.totalPages,
    products: payload.products,
    productDetail: payload.productDetail,
    recommendContentProducts: payload.recommendContentProducts,
    recommendCollabProducts: payload.recommendCollabProducts,
  );
}
