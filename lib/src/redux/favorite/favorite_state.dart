import 'package:meta/meta.dart';

import 'package:ecommerce_flutter/src/models/Favorite.dart';

@immutable
class FavoriteState {
  final bool isError;
  final bool isLoading;
  final bool isSuccess;
  final int totalItems;
  final int totalPages;
  final Favorite favoriteList;

  FavoriteState({
    this.isError,
    this.isLoading,
    this.isSuccess,
    this.totalItems,
    this.totalPages,
    this.favoriteList,
  });

  //factory constructor will be later used to fill the initial main state.
  factory FavoriteState.initial() => FavoriteState(
        isError: null,
        isSuccess: null,
        isLoading: false,
        totalItems: null,
        totalPages: null,
        favoriteList: null,
      );

  //copyWith method will be later used to get a copy of our FavoriteState to update this piece of the main state.
  FavoriteState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required bool isSuccess,
    @required int totalItems,
    @required int totalPages,
    @required Favorite favoriteList,
  }) {
    return FavoriteState(
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      favoriteList: favoriteList ?? this.favoriteList,
    );
  }
}
