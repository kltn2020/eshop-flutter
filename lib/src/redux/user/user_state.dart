import 'package:meta/meta.dart';

import 'package:ecommerce_flutter/src/models/i_product.dart';

@immutable
class UserState {
  final bool isError;
  final bool isLoading;
  final bool isSuccess;
  final int totalItems;
  final int totalPages;
  final IUser user;

  UserState({
    this.isError,
    this.isLoading,
    this.isSuccess,
    this.totalItems,
    this.totalPages,
    this.user,
  });

  //factory constructor will be later used to fill the initial main state.
  factory UserState.initial() => UserState(
        isError: null,
        isSuccess:null,
        isLoading: false,
        totalItems: null,
        totalPages:null,
        user: null,
      );

  //copyWith method will be later used to get a copy of our UserState to update this piece of the main state.
  UserState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required bool isSuccess,
    @required int totalItems,
    @required int totalPages,
    @required IUser user,
  }) {
    return UserState(
      isError: isError ?? this.isError,
      isSuccess: isSuccess??this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      totalPages: totalPages??this.totalPages,
      totalItems: totalItems??this.totalItems,
      user: user ?? this.user,
    );
  }
}
