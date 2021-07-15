import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/getUser_response.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/storage_service.dart';

class UserService with ChangeNotifier {
  final storage = new StorageService();

  Future<List<User>> getUser() async {
    try {
      final token = await storage.getValue("token");
      final resp = await http.get(
          Uri.parse('${Enviroment.apiurl}/user/?limit=10'),
          headers: {'Content-Type': 'application/json', 'x-token': token});
      final usersRespose = getUserResponseFromJson(resp.body);

      return usersRespose.user;
    } catch (e) {
      return [];
    }
  }
}
