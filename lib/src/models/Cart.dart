import 'package:ecommerce_flutter/src/models/Product.dart';

class ProductInCart {
  Product product;
  int quantity;

  ProductInCart.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    product = Product.fromJson(json['product']);
    quantity = json['quantity'];
  }

  static List<ProductInCart> listFromJson(List<dynamic> json) {
    return json == null
        ? List<ProductInCart>()
        : json.map((value) => ProductInCart.fromJson(value)).toList();
  }
}

class Cart {
  int id;
  List<ProductInCart> products;
  String insertedAt;
  String updatedAt;

  Cart.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    products = ProductInCart.listFromJson(json['items']);
    insertedAt = json['inserted_at'];
    updatedAt = json['updated_at'];
  }

  // static List<Cart> listFromJson(List<dynamic> json) {
  //   return json == null
  //       ? List<Cart>()
  //       : json.map((value) => Cart.fromJson(value)).toList();
  // }
}
