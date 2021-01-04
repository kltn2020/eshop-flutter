class Category {
  int id;
  String name;
  String insertedAt;
  String updatedAt;

  Category.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    insertedAt = json['inserted_at'];
    updatedAt = json['updated_at'];
  }

  static List<Category> listFromJson(List<dynamic> json) {
    return json == null
        ? List<Category>()
        : json.map((value) => Category.fromJson(value)).toList();
  }
}
