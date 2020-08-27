import 'package:ecommerce_flutter/src/redux/user/user_actions.dart';
import 'package:ecommerce_flutter/src/redux/user/user_state.dart';

userReducer(UserState prevState, SetUserStateAction action) {
  final payload = action.userState;
  print("123456789");
  print(payload);
  return prevState.copyWith(
    isError: payload.isError,
    errorMessage: payload.errorMessage,
    isLoading: payload.isLoading,
    isSuccess: payload.isSuccess,
    user: payload.user,
    token: payload.token,
  );
}
