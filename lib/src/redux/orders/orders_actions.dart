import 'dart:convert';
import 'dart:io';
import 'package:redux/redux.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_flutter/src/models/Order.dart';
import 'package:ecommerce_flutter/src/redux/orders/orders_state.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

@immutable
class SetOrdersStateAction {
  final OrdersState ordersState;

  SetOrdersStateAction(this.ordersState);
}

class OrderActions {
  String token;
  int page;
  int size;
  int orderId;

  OrderActions({
    this.token,
    this.page,
    this.size,
    this.orderId,
  });

  Future<void> getAllOrdersAction(Store<AppState> store, String status) async {
    store.dispatch(
        SetOrdersStateAction(OrdersState(isLoading: true, orders: [])));

    String token = store.state.userState.token;

    String url = status != null
        ? '$backendUrl/orders?status=$status'
        : '$backendUrl/orders';

    try {
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];

        store.dispatch(
          SetOrdersStateAction(
            OrdersState(
              isLoading: false,
              isSuccess: true,
              //totalPages: jsonData['count'],
              orders: Order.listFromJson(jsonData['entries']),
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
      store.dispatch(
          SetOrdersStateAction(OrdersState(isLoading: false, isError: true)));
    }
  }

  Future<void> getByIdOrderAction(Store<AppState> store) async {
    store.dispatch(SetOrdersStateAction(OrdersState(isLoading: true)));

    String token = store.state.userState.token;

    try {
      final response = await http.get(
        '$backendUrl/orders/$orderId',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];

        store.dispatch(
          SetOrdersStateAction(
            OrdersState(
              isLoading: false,
              isSuccess: true,
              order: Order.fromJson(jsonData),
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
      store.dispatch(
          SetOrdersStateAction(OrdersState(isLoading: false, isError: true)));
    }
  }
}
