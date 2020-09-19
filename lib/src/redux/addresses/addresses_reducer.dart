import 'package:ecommerce_flutter/src/redux/addresses/addresses_actions.dart';
import 'package:ecommerce_flutter/src/redux/addresses/addresses_state.dart';

addressesReducer(AddressesState prevState, SetAddressesStateAction action) {
  final payload = action.addressesState;
  return prevState.copyWith(
      isError: payload.isError,
      isLoading: payload.isLoading,
      isSuccess: payload.isSuccess,
      totalItems: payload.totalItems,
      totalPages: payload.totalPages,
      addresses: payload.addresses);
}
