import 'dart:convert';
import 'dart:io';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_flutter/src/models/Address.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:ecommerce_flutter/src/redux/addresses/addresses_state.dart';

@immutable
class SetAddressesStateAction {
  final AddressesState addressesState;

  SetAddressesStateAction(this.addressesState);
}

class AddressesActions {
  String token;

  AddressesActions({
    this.token,
  });

  Future<void> getAllAddressesAction(Store<AppState> store) async {
    print("get-addresses-action");

    String token = store.state.userState.token;

    store.dispatch(SetAddressesStateAction(AddressesState(isLoading: true)));
    try {
      final response = await http.get(
        '$backendUrl/address',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        store.dispatch(
          SetAddressesStateAction(
            AddressesState(
              isLoading: false,
              isSuccess: true,
              addresses: Address.listFromJson(jsonData['data']),
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
      store.dispatch(SetAddressesStateAction(
          AddressesState(isLoading: false, isError: true)));
    }
  }

  Future<void> addAddressesAction(Store<AppState> store, String token,
      String phoneNumber, String locate, bool isPrimary) async {
    print("add-addresses-action");
    store.dispatch(SetAddressesStateAction(AddressesState(isLoading: true)));

    print(jsonEncode(<String, dynamic>{
      'locate': locate,
      'phone_number': phoneNumber,
      'is_primary': isPrimary,
    }));

    try {
      final response = await http.post('$backendUrl/address',
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            "Content-Type": "application/json",
          },
          body: jsonEncode(<String, dynamic>{
            'locate': locate,
            'phone_number': phoneNumber,
            'is_primary': isPrimary,
          }));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // print(jsonData);

        var newAddressesList =
            new List<Address>.from(store.state.addressesState.addresses)
              ..add(Address.fromJson(jsonData['data']));

        store.dispatch(
          SetAddressesStateAction(
            AddressesState(
              isLoading: false,
              isSuccess: true,
              addresses: newAddressesList,
            ),
          ),
        );
      } else {
        throw response.body;
      }
    } catch (error) {
      print(error);
      store.dispatch(SetAddressesStateAction(
          AddressesState(isLoading: false, isError: true)));
      throw (AddressErrorMessage.fromJson(json.decode(error)));
    }
  }

  Future<void> updateAddressesAction(Store<AppState> store, int id,
      String token, String phoneNumber, String locate, bool isPrimary) async {
    print("update-addresses-action");
    store.dispatch(SetAddressesStateAction(AddressesState(isLoading: true)));

    print(jsonEncode(<String, dynamic>{
      'locate': locate,
      'phone_number': phoneNumber,
      'is_primary': isPrimary,
    }));

    try {
      final response = await http.put('$backendUrl/address/$id',
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
            "Content-Type": "application/json",
          },
          body: jsonEncode(<String, dynamic>{
            'locate': locate,
            'phone_number': phoneNumber,
            'is_primary': isPrimary,
          }));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);

        //Clone array
        var newAddressesList =
            new List<Address>.from(store.state.addressesState.addresses);
        //Set all address isPrimary to false if new info have isPrimary = true
        if (isPrimary)
          newAddressesList.forEach((element) {
            element.isPrimary = false;
          });
        //Find item with id and replace it with new info
        newAddressesList[
                newAddressesList.indexWhere((element) => element.id == id)] =
            Address.fromJson(jsonData['data']);

        store.dispatch(
          SetAddressesStateAction(
            AddressesState(
              isLoading: false,
              isSuccess: true,
              addresses: newAddressesList,
            ),
          ),
        );
      } else {
        throw response.body;
      }
    } catch (error) {
      print(error);
      store.dispatch(SetAddressesStateAction(
          AddressesState(isLoading: false, isError: true)));
    }
  }

  Future<void> deleteAddressesAction(Store<AppState> store, int id) async {
    print("delete-addresses-action");
    store.dispatch(SetAddressesStateAction(AddressesState(isLoading: true)));

    String token = store.state.userState.token;
    try {
      final response = await http.delete(
        '$backendUrl/address/$id',
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);

        var newAddressesList =
            new List<Address>.from(store.state.addressesState.addresses)
              ..removeWhere((element) => element.id == id);

        store.dispatch(
          SetAddressesStateAction(
            AddressesState(
              isLoading: false,
              isSuccess: true,
              addresses: newAddressesList,
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
      store.dispatch(SetAddressesStateAction(
          AddressesState(isLoading: false, isError: true)));
    }
  }
}

class AddressErrorMessage {
  String code;
  String message;
  String status;

  AddressErrorMessage({
    this.code,
    this.message,
    this.status,
  });

  factory AddressErrorMessage.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return AddressErrorMessage(
        code: json['code'] != null ? json['code'] : null,
        message: json['message'] != null ? json['message'] : null,
        status: json['status'] != null ? json['status'] : null,
      );
    } else
      return null;
  }
}
