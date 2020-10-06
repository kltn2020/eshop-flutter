import 'package:meta/meta.dart';

import 'package:ecommerce_flutter/src/models/Order.dart';

@immutable
class OrdersState {
  final bool isError;
  final bool isLoading;
  final bool isSuccess;
  final int totalItems;
  final int totalPages;
  final List<Order> orders;
  final Order order;

  OrdersState({
    this.isError,
    this.isLoading,
    this.isSuccess,
    this.totalItems,
    this.totalPages,
    this.orders,
    this.order,
  });

  //factory constructor will be later used to fill the initial main state.
  factory OrdersState.initial() => OrdersState(
        isError: null,
        isSuccess: null,
        isLoading: false,
        totalItems: null,
        totalPages: null,
        orders: const [],
        order: null,
      );

  //copyWith method will be later used to get a copy of our OrdersState to update this piece of the main state.
  OrdersState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required bool isSuccess,
    @required int totalItems,
    @required int totalPages,
    @required List<Order> orders,
    @required Order order,
  }) {
    return OrdersState(
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      orders: orders ?? this.orders,
      order: order ?? this.order,
    );
  }
}
