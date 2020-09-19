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
  // String phoneNumber;
  // String locate;
  // bool isPrimary;

  AddressesActions({
    this.token,
    // this.phoneNumber,
    // this.locate,
    // this.isPrimary,
  });

  Future<void> getAllAddressesAction(Store<AppState> store) async {
    print("get-addresses-action");

    store.dispatch(SetAddressesStateAction(AddressesState(isLoading: true)));
    try {
      final response = await http.get(
        'https://rocky-sierra-70366.herokuapp.com/api/address',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);
        store.dispatch(
          SetAddressesStateAction(
            AddressesState(
              isLoading: false,
              isSuccess: true,
              //totalPages: jsonData['count'],
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
      final response = await http.post(
          'https://rocky-sierra-70366.herokuapp.com/api/address',
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
          body: jsonEncode(<String, dynamic>{
            'locate': locate,
            'phone_number': phoneNumber,
            'is_primary': isPrimary,
          }));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);

        // print(store.state.addressesState.addressesList.product.length);

        // Address newAddressesList = store.state.addressesState.addressesList;

        // newAddressesList.product.add(product);
        // print("newAddressesList");

        store.dispatch(
          SetAddressesStateAction(
            AddressesState(
              isLoading: false,
              isSuccess: true,
              // addresses: newAddressesList,
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

  Future<void> deleteAddressesAction(Store<AppState> store) async {
    print("delete-addresses-action");
    store.dispatch(SetAddressesStateAction(AddressesState(isLoading: true)));

    // String productID = product.id.toString();

    try {
      final response = await http.delete(
        'https://rocky-sierra-70366.herokuapp.com/api/address',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print(jsonData);

        // Addresses newAddressesList = store.state.addressesState.addressesList;

        // newAddressesList.product
        //     .removeWhere((iproduct) => iproduct.id == product.id);
        // print("newAddressesList");

        store.dispatch(
          SetAddressesStateAction(
            AddressesState(
              isLoading: false,
              isSuccess: true,
              // addressesList: newAddressesList,
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
