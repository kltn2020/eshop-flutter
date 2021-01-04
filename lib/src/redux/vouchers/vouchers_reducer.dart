import 'package:ecommerce_flutter/src/redux/vouchers/vouchers_actions.dart';
import 'package:ecommerce_flutter/src/redux/vouchers/vouchers_state.dart';

vouchersReducer(VouchersState prevState, SetVouchersStateAction action) {
  final payload = action.vouchersState;
  return prevState.copyWith(
    isError: payload.isError,
    isLoading: payload.isLoading,
    isSuccess: payload.isSuccess,
    totalItems: payload.totalItems,
    totalPages: payload.totalPages,
    vouchers: payload.vouchers,
    voucher: payload.voucher,
  );
}
