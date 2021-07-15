// To parse this JSON data, do
//
//     final getUserResponse = getUserResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/user_model.dart';

GetUserResponse getUserResponseFromJson(String str) =>
    GetUserResponse.fromJson(json.decode(str));

String getUserResponseToJson(GetUserResponse data) =>
    json.encode(data.toJson());

class GetUserResponse {
  GetUserResponse({
    required this.user,
  });

  List<User> user;

  factory GetUserResponse.fromJson(Map<String, dynamic> json) =>
      GetUserResponse(
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
      };
}
