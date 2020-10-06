import 'package:ecommerce_flutter/src/redux/favorite/favorite_actions.dart';
import 'package:ecommerce_flutter/src/redux/favorite/favorite_state.dart';

favoriteReducer(FavoriteState prevState, SetFavoriteStateAction action) {
  final payload = action.favoriteState;
  return prevState.copyWith(
      isError: payload.isError,
      isLoading: payload.isLoading,
      isSuccess: payload.isSuccess,
      totalItems: payload.totalItems,
      totalPages: payload.totalPages,
      favoriteList: payload.favoriteList);
}
