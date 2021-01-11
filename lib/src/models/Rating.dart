class Rating {
  int id;
  num point;
  String content;
  String insertedAt;
  String updatedAt;
  String userEmail;

  Rating.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    point = json['point'];
    content = json['content'];
    insertedAt = json['insertedAt'];
    updatedAt = json['updatedAt'];
    userEmail = json['user']['email'];
  }

  static List<Rating> listFromJson(List<dynamic> json) {
    return json == null
        ? List<Rating>()
        : json.map((value) => Rating.fromJson(value)).toList();
  }
}

class Reply {
  int id;
}
