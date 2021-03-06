class Address {
  int id;
  bool isPrimary;
  String locate;
  int userId;
  String phoneNumber;
  String insertedAt;
  String updatedAt;

  Address.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    isPrimary = json['is_primary'];
    locate = json['locate'];
    userId = json['user_id'];
    phoneNumber = json['phone_number'];
    insertedAt = json['inserted_at'];
    updatedAt = json['updated_at'];
  }

  static List<Address> listFromJson(List<dynamic> json) {
    return json == null
        ? List<Address>()
        : json.map((value) => Address.fromJson(value)).toList();
  }
}
