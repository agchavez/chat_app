// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.img,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.id,
    this.online = false,
  });

  String img;
  String email;
  String name;
  int phoneNumber;
  String id;
  bool online;

  factory User.fromJson(Map<String, dynamic> json) => User(
        img: json["img"],
        email: json["email"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        id: json["id"],
        online: json["online"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "email": email,
        "name": name,
        "phoneNumber": phoneNumber,
        "id": id,
        "online": online,
      };
}
