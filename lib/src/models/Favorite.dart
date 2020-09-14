import 'package:ecommerce_flutter/src/models/Product.dart';

class Favorite {
  List<Product> product;

  Favorite.fromJson(List<dynamic> json) {
    if (json == null) return;
    product = Product.listFromJson(json);
  }

  // static List<Favorite> listFromJson(List<dynamic> json) {
  //   return json == null
  //       ? List<Favorite>()
  //       : json.map((value) => Favorite.fromJson(value)).toList();
  // }
}
