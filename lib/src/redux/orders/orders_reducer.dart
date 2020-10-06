import 'package:ecommerce_flutter/src/redux/orders/orders_actions.dart';
import 'package:ecommerce_flutter/src/redux/orders/orders_state.dart';

ordersReducer(OrdersState prevState, SetOrdersStateAction action) {
  final payload = action.ordersState;
  return prevState.copyWith(
    isError: payload.isError,
    isLoading: payload.isLoading,
    isSuccess: payload.isSuccess,
    totalItems: payload.totalItems,
    totalPages: payload.totalPages,
    orders: payload.orders,
    order: payload.order,
  );
}
