import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_flutter/src/models/User.dart';
import 'package:ecommerce_flutter/src/redux/user/user_state.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

//ParseJWT
Map<String, dynamic> parseJwtPayLoad(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

Map<String, dynamic> parseJwtHeader(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[0]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

//Error Handle
class ErrorMessage {
  String message;
  int status;

  ErrorMessage({
    this.message,
    this.status,
  });

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    if (json != null)
      return ErrorMessage(message: json['message'], status: json['status']);
    else
      return null;
  }
}

class ErrorDetail {
  String email;
  String password;
  String passwordConfirmation;

  ErrorDetail({
    this.email,
    this.password,
    this.passwordConfirmation,
  });

  factory ErrorDetail.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return ErrorDetail(
        email: json['email'] != null ? json['email'][0] : null,
        password: json['password'] != null ? json['password'][0] : null,
        passwordConfirmation: json['password_confirmation'] != null
            ? json['password_confirmation'][0]
            : null,
      );
    } else
      return null;
  }
}

class ErrorRegisterMessage {
  String message;
  int status;
  ErrorDetail errors;

  ErrorRegisterMessage({
    this.message,
    this.status,
    this.errors,
  });

  factory ErrorRegisterMessage.fromJson(Map<dynamic, dynamic> json) {
    if (json != null) {
      print(json['errors']);
      return ErrorRegisterMessage(
          message: json['message'],
          status: json['status'],
          errors: ErrorDetail.fromJson(json['errors']));
    } else
      return null;
  }
}

@immutable
class SetUserStateAction {
  final UserState userState;

  SetUserStateAction(this.userState);
}

class UserActions {
  String email;
  String password;
  String passwordConfirmation;

  UserActions({
    this.email,
    this.password,
    this.passwordConfirmation,
  });

  Future<void> loginAction(Store<AppState> store) async {
    store.dispatch(SetUserStateAction(UserState(
      isLoading: true,
      isError: false,
      errorMessage: "",
      isSuccess: false,
    )));
    try {
      print("Login");
      print(email);
      print(password);
      final response = await http.post(
        'http://35.213.174.112/api/auth/login',
        body: {
          'email': '$email',
          'password': '$password',
        },
      );
      final statusCode = response.statusCode;
      print('Response Status code: $statusCode');
      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        store.dispatch(
          SetUserStateAction(
            UserState(
              isLoading: false,
              isSuccess: true,
              user: User.fromJson(parseJwtPayLoad(jsonData['token'])),
              token: jsonData['token'],
            ),
          ),
        );
      }
      if (response.statusCode > 400) {
        print("its herer");
        final jsonData = json.decode(response.body);
        print(jsonData['error']);
        store.dispatch(
          SetUserStateAction(
            UserState(
              isLoading: false,
              isError: true,
              errorMessage: ErrorMessage.fromJson(jsonData['error']).message,
            ),
          ),
        );
      }
    } catch (error) {
      print("Error time:");
      print(error);
      store.dispatch(
          SetUserStateAction(UserState(isLoading: false, isError: true)));
    }
  }

  Future<void> resigterAction(Store<AppState> store) async {
    store.dispatch(SetUserStateAction(UserState(
      isLoading: true,
      isError: false,
      isSuccess: false,
      errorMessage: "",
    )));

    try {
      final response = await http.post(
        'http://35.213.174.112/api/auth/register',
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );
      final statusCode = response.statusCode;
      print('Response Status code: $statusCode');

      // assert(response.statusCode == 200, response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        print(response.body);

        store.dispatch(
          SetUserStateAction(
            UserState(
              isLoading: false,
              isSuccess: true,
            ),
          ),
        );
      } else
        throw response.body;
    } catch (error) {
      print(error);
      final jsonData = json.decode(error);

      print(ErrorRegisterMessage.fromJson(jsonData['error']).errors);

      var detailError = ErrorRegisterMessage.fromJson(jsonData['error']).errors;

      store.dispatch(
        SetUserStateAction(
          UserState(
              isLoading: false,
              isError: true,
              errorMessage: detailError.email != null
                  ? 'Email ${detailError.email}'
                  : detailError.password != null
                      ? 'Password ${detailError.password}'
                      : 'Password ${detailError.passwordConfirmation}'),
        ),
      );
    }
  }

  Future<void> confirmEmailAction(
      Store<AppState> store, String tokenCode, String confirmEmail) async {
    print('confirm-email');

    store.dispatch(SetUserStateAction(UserState(
      isLoading: true,
      isError: false,
      errorMessage: "",
      isSuccess: false,
    )));

    try {
      final response = await http.post(
        'http://35.213.174.112/api/auth/confirm',
        body: {
          'email': '$confirmEmail',
          'token': '$tokenCode',
        },
      );

      if (response.statusCode == 200) {
        print(response.body);

        store.dispatch(
          SetUserStateAction(
            UserState(
              isLoading: false,
              isSuccess: true,
            ),
          ),
        );
      }
      if (response.statusCode > 400) {
        final jsonData = json.decode(response.body);

        print(jsonData['error']);

        store.dispatch(
          SetUserStateAction(
            UserState(
              isLoading: false,
              isError: true,
              errorMessage: ErrorMessage.fromJson(jsonData['error']).message,
            ),
          ),
        );
      }
    } catch (error) {
      print("Error time:");
      print(error);
      store.dispatch(
          SetUserStateAction(UserState(isLoading: false, isError: true)));
    }
  }

  void resetStateAction(Store<AppState> store) {
    store.dispatch(SetUserStateAction(
      UserState(
        isError: false,
        errorMessage: "",
        isSuccess: false,
      ),
    ));
  }

  void logoutAction(Store<AppState> store) {
    print("logout");
    store.dispatch(SetUserStateAction(
      UserState(
        token: "",
        isError: false,
        errorMessage: "",
        isSuccess: false,
        isLoading: false,
        user: null,
      ),
    ));
  }
}
