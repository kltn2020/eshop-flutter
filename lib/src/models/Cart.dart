import 'package:ecommerce_flutter/src/models/Product.dart';

class ProductInCart {
  Product product;
  int quantity;
  bool check;

  ProductInCart(this.product, this.quantity, this.check);

  ProductInCart.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    product = Product.fromJson(json['product']);
    quantity = json['quantity'];
    check = json['active'];
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

  Cart(this.id, this.products, this.insertedAt, this.updatedAt);

  Cart.clone(Cart cart)
      : this(cart.id, cart.products, cart.insertedAt, cart.updatedAt);

  Cart.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    products = ProductInCart.listFromJson(json['items']);
    insertedAt = json['inserted_at'];
    updatedAt = json['updated_at'];
  }
}
