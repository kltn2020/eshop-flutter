class Brand {
  int id;
  String name;

  Brand.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
  }

  static List<Brand> listFromJson(List<dynamic> json) {
    return json == null
        ? List<Brand>()
        : json.map((value) => Brand.fromJson(value)).toList();
  }
}
