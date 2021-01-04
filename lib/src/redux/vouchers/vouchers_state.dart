import 'package:meta/meta.dart';

import 'package:ecommerce_flutter/src/models/Voucher.dart';

@immutable
class VouchersState {
  final bool isError;
  final bool isLoading;
  final bool isSuccess;
  final int totalItems;
  final int totalPages;
  final List<Voucher> vouchers;
  final Voucher voucher;

  VouchersState({
    this.isError,
    this.isLoading,
    this.isSuccess,
    this.totalItems,
    this.totalPages,
    this.vouchers,
    this.voucher,
  });

  //factory constructor will be later used to fill the initial main state.
  factory VouchersState.initial() => VouchersState(
        isError: null,
        isSuccess: null,
        isLoading: false,
        totalItems: null,
        totalPages: null,
        vouchers: const [],
        voucher: null,
      );

  //copyWith method will be later used to get a copy of our VouchersState to update this piece of the main state.
  VouchersState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required bool isSuccess,
    @required int totalItems,
    @required int totalPages,
    @required List<Voucher> vouchers,
    @required Voucher voucher,
  }) {
    return VouchersState(
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      vouchers: vouchers ?? this.vouchers,
      voucher: voucher ?? this.voucher,
    );
  }
}
