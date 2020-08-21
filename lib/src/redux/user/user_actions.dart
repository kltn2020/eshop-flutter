import 'dart:convert';
import 'dart:io';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_flutter/src/models/i_product.dart';
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

class UserActions{
  String email;
  String password;
  String password_confirmation;

  UserActions({
    this.email;
    this.password;
    this.password_confirmation;
  });


Future<void> loginAction(Store<AppState> store) async {
  store.dispatch(SetUserStateAction(UserState(isLoading: true)));

  try {
    final response = await http.post(
      'https://rocky-sierra-70366.herokuapp.com/api/auth/login',
      body: {
        'email': $email,
        'password': $password,
      }
    );

    assert(response.statusCode == 200);
    final jsonData = json.decode(response.body);

    store.dispatch(
      SetUserStateAction(
        UserState(
          isLoading: false,
          isSuccess:true,
          count: jsonData['count'],
          user: IUser.fromJson(jsonData['results']),
        ),
      ),
    );
  } catch (error) {
    print(error);
    store.dispatch(SetUserStateAction(UserState(isLoading: false, isError:true)));
  }
}

Future<void> resigterAction(Store<AppState> store) async {
  store.dispatch(SetUserStateAction(UserState(isLoading: true)));

  try {
    final response = await http.post(
      'https://rocky-sierra-70366.herokuapp.com/api/auth/register',
      body: {
        'email': $email,
        'password': $password,
        'password_confirmation': $password_confirmation,
      }
    );

    assert(response.statusCode == 200);
    final jsonData = json.decode(response.body);

    store.dispatch(
      SetUserStateAction(
        UserState(
          isLoading: false,
          isSuccess:true,
          user: IUser.fromJson(parseJwtPayLoad(jsonData['token'])),
        ),
      ),
    );
  } catch (error) {
    print(error);
    store.dispatch(SetUserStateAction(UserState(isLoading: false, isError:true)));
  }
}

}

