class IUser {
  int id;
  String email;
  String role;
  String token;

  IUser.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    email = json['email'];
    role = json['role'];
  }

  static List<IUser> listFromJson(List<dynamic> json) {
    return json == null
        ? List<IUser>()
        : json.map((value) => IUser.fromJson(value)).toList();
  }
}
