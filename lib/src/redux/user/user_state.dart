import 'package:meta/meta.dart';

import 'package:ecommerce_flutter/src/models/i_user.dart';

@immutable
class UserState {
  final bool isError;
  final String errorMessage;
  final bool isLoading;
  final bool isSuccess;
  final IUser user;
  final String token;

  UserState({
    this.isError,
    this.errorMessage,
    this.isLoading,
    this.isSuccess,
    this.user,
    this.token,
  });

  //factory constructor will be later used to fill the initial main state.
  factory UserState.initial() => UserState(
        isError: false,
        errorMessage: null,
        isSuccess: false,
        isLoading: false,
        user: null,
        token: null,
      );

  //copyWith method will be later used to get a copy of our UserState to update this piece of the main state.
  UserState copyWith({
    @required bool isError,
    @required String errorMessage,
    @required bool isLoading,
    @required bool isSuccess,
    @required IUser user,
    @required String token,
  }) {
    return UserState(
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }
}
