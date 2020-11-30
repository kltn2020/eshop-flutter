import 'dart:convert';
import 'dart:io';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_flutter/src/models/Voucher.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';
import 'package:ecommerce_flutter/src/redux/vouchers/vouchers_state.dart';

@immutable
class SetVouchersStateAction {
  final VouchersState vouchersState;

  SetVouchersStateAction(this.vouchersState);
}

class VoucherActions {
  Future<void> checkVoucherAction(
      Store<AppState> store, String voucherCode) async {
    store.dispatch(SetVouchersStateAction(VouchersState(isLoading: true)));

    String token = store.state.userState.token;

    print("check-voucher");
    try {
      final response = await http.get(
        'http://35.213.174.112/api/vouchers/check/$voucherCode',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];

        print(jsonData);
        store.dispatch(
          SetVouchersStateAction(
            VouchersState(
              isLoading: false,
              isSuccess: true,
              //totalPages: jsonData['count'],
              //vouchers: Voucher.listFromJson(jsonData['entries']),
              voucher: Voucher.fromJson(jsonData),
            ),
          ),
        );
      } else {
        throw response.body;
      }
    } catch (error) {
      print(error);
      store.dispatch(SetVouchersStateAction(
          VouchersState(isLoading: false, isError: true)));
    }
  }
}
