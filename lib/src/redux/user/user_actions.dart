import 'dart:convert';
import 'dart:io';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_flutter/src/models/i_user.dart';
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
    store.dispatch(SetUserStateAction(UserState(isLoading: true)));
    try {
      print("Login");
      final response = await http.post(
        'https://rocky-sierra-70366.herokuapp.com/api/auth/login',
        body: {
          'email': '$email',
          'password': '$password',
        },
      );
      final statusCode = response.statusCode;
      print('Response Status code: $statusCode');
      print(response.body);

      //assert(response.statusCode == 200);
      // final jsonData = json.decode(response.body);
      // print(jsonData[]);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        store.dispatch(
          SetUserStateAction(
            UserState(
              isLoading: false,
              isSuccess: true,
              user: IUser.fromJson(parseJwtPayLoad(jsonData['token'])),
              token: jsonData['token'],
            ),
          ),
        );
      }
      if (response.statusCode > 400) {
        final jsonData = json.decode(response.body);
        store.dispatch(
          SetUserStateAction(
            UserState(
              isLoading: false,
              isError: true,
              errorMessage: jsonData['error'],
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
    // print(101112);
    // final http.Response response = await http.post(
    //   'https://jsonplaceholder.typicode.com/albums',
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'title': '$email',
    //   }),
    // );
    // if (response.statusCode == 201) {
    //   // If the server did return a 201 CREATED response,
    //   // then parse the JSON.
    //   print(response.body);
    //   //return Album.fromJson(json.decode(response.body));
    // } else {
    //   // If the server did not return a 201 CREATED response,
    //   // then throw an exception.
    //   throw Exception('Failed to load album');
    // }
  }

  Future<void> resigterAction(Store<AppState> store) async {
    store.dispatch(SetUserStateAction(UserState(isLoading: true)));

    try {
      final response = await http.post(
          'https://rocky-sierra-70366.herokuapp.com/api/auth/register',
          body: {
            'email': '$email',
            'password': '$password',
            'password_confirmation': '$passwordConfirmation',
          });
      final statusCode = response.statusCode;
      print('Response Status code: $statusCode');

      assert(response.statusCode == 200, "Something wrong");
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        store.dispatch(
          SetUserStateAction(
            UserState(
              isLoading: false,
              isSuccess: true,
              user: IUser.fromJson(parseJwtPayLoad(jsonData['token'])),
            ),
          ),
        );
      }
    } catch (error) {
      print(123);
      print(error);
      store.dispatch(
          SetUserStateAction(UserState(isLoading: false, isError: true)));
    }
  }
}
