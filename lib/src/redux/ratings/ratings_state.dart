import 'package:meta/meta.dart';

import 'package:ecommerce_flutter/src/models/Rating.dart';

@immutable
class RatingState {
  final bool isError;
  final bool isLoading;
  final bool isSuccess;
  final int totalItems;
  final int totalPages;
  final List<Rating> ratingList;

  RatingState({
    this.isError,
    this.isLoading,
    this.isSuccess,
    this.totalItems,
    this.totalPages,
    this.ratingList,
  });

  //factory constructor will be later used to fill the initial main state.
  factory RatingState.initial() => RatingState(
        isError: null,
        isSuccess: null,
        isLoading: false,
        totalItems: null,
        totalPages: null,
        ratingList: null,
      );

  //copyWith method will be later used to get a copy of our RatingState to update this piece of the main state.
  RatingState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required bool isSuccess,
    @required int totalItems,
    @required int totalPages,
    @required List<Rating> ratingList,
  }) {
    return RatingState(
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      ratingList: ratingList ?? this.ratingList,
    );
  }
}
