import 'package:ecommerce_flutter/src/models/Address.dart';
import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:ecommerce_flutter/src/models/Voucher.dart';

class Order {
  int id;
  int discount;
  int total;
  String status;
  String orderDate;
  int userId;
  int voucherId;
  int addressId;
  Address address;
  Voucher voucher;
  List<ProductInOrder> productList;

  Order.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    discount = json['discount'];
    total = json['total'];
    status = json['status'];
    orderDate = json['order_date'];
    address = Address.fromJson(json['address']);
    productList = ProductInOrder.listFromJson(json['lines']);
    voucher =
        json['voucher'] != null ? Voucher.fromJson(json['voucher']) : null;
  }

  static List<Order> listFromJson(List<dynamic> json) {
    return json == null
        ? List<Order>()
        : json.map((value) => Order.fromJson(value)).toList();
  }
}

class ProductInOrder {
  Product product;
  int discount;
  int price;
  int quantity;

  ProductInOrder.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    product = Product.fromJson(json['product']);
    price = json['price'];
    discount = json['discount'];
    quantity = json['quantity'];
  }

  static List<ProductInOrder> listFromJson(List<dynamic> json) {
    return json == null
        ? List<ProductInOrder>()
        : json.map((value) => ProductInOrder.fromJson(value)).toList();
  }
}
