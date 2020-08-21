import 'package:ecommerce_flutter/src/redux/user/user_actions.dart';
import 'package:ecommerce_flutter/src/redux/user/user_state.dart';

userReducer(UserState prevState, SetUserStateAction action) {
  final payload = action.userState;
  return prevState.copyWith(
      isError: payload.isError,
      isLoading: payload.isLoading,
      isSuccess: payload.isSuccess,
      user: payload.user;
}
