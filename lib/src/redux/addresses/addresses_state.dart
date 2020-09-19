import 'package:meta/meta.dart';

import 'package:ecommerce_flutter/src/models/Address.dart';

@immutable
class AddressesState {
  final bool isError;
  final bool isLoading;
  final bool isSuccess;
  final int totalItems;
  final int totalPages;
  final List<Address> addresses;

  AddressesState({
    this.isError,
    this.isLoading,
    this.isSuccess,
    this.totalItems,
    this.totalPages,
    this.addresses,
  });

  //factory constructor will be later used to fill the initial main state.
  factory AddressesState.initial() => AddressesState(
        isError: null,
        isSuccess: null,
        isLoading: false,
        totalItems: null,
        totalPages: null,
        addresses: const [],
      );

  //copyWith method will be later used to get a copy of our AddressesState to update this piece of the main state.
  AddressesState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required bool isSuccess,
    @required int totalItems,
    @required int totalPages,
    @required List<Address> addresses,
  }) {
    return AddressesState(
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      addresses: addresses ?? this.addresses,
    );
  }
}
