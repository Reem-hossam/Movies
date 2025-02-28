class UserModel {
  String id;
  String name;
  String email;
  String avatar;
  String phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.phoneNumber,

  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          avatar: json['avatar'] ?? "",
          phoneNumber: json['phoneNumber'] ?? "",
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "avatar": avatar,
      "phoneNumber": phoneNumber,
    };
  }
}
