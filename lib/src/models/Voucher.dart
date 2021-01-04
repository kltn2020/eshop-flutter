import 'package:ecommerce_flutter/src/models/Category.dart';

class Voucher {
  int id;
  String code;
  String validFrom;
  String validTo;
  String isUsed;
  int value;
  int categoryId;
  Category category;

  Voucher.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    code = json['code'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    value = json['value'];
    categoryId = json['category_id'];
    category = Category.fromJson(json['category']);
  }

  static List<Voucher> listFromJson(List<dynamic> json) {
    return json == null
        ? List<Voucher>()
        : json.map((value) => Voucher.fromJson(value)).toList();
  }
}
