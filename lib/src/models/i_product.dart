class IProduct {
  int id;
  String title;
  int price;

  IProduct.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
    price = json['price'];
  }

  static List<IProduct> listFromJson(List<dynamic> json) {
    return json == null
        ? List<IProduct>()
        : json.map((value) => IProduct.fromJson(value)).toList();
  }
}
