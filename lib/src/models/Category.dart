class Category {
  int id;
  String name;

  Category.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
  }

  static List<Category> listFromJson(List<dynamic> json) {
    return json == null
        ? List<Category>()
        : json.map((value) => Category.fromJson(value)).toList();
  }
}
