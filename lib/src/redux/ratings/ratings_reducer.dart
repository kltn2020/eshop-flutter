import 'package:ecommerce_flutter/src/redux/ratings/ratings_actions.dart';
import 'package:ecommerce_flutter/src/redux/ratings/ratings_state.dart';

ratingsReducer(RatingState prevState, SetRatingStateAction action) {
  final payload = action.ratingState;
  return prevState.copyWith(
    isError: payload.isError,
    isLoading: payload.isLoading,
    isSuccess: payload.isSuccess,
    totalItems: payload.totalItems,
    totalPages: payload.totalPages,
    ratingList: payload.ratingList,
  );
}
