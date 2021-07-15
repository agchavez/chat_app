import 'dart:convert';

import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import 'package:chat_app/models/login_response.dart';

class AuthServices with ChangeNotifier {
  final storage = new StorageService();
  late User user;
  bool _autenticated = false;
  bool get autenticated => this._autenticated;
  set autenticated(bool value) {
    this._autenticated = value;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    autenticated = true;
    LoginResponse loginResponse;
    final data = {"email": email, "password": password};
    final resp = await http.post(Uri.parse('${Enviroment.apiurl}/user/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      await storage.setValue(loginResponse.token, "token");
      autenticated = false;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final token = await storage.getValue("token");
      final resp = await http.get(Uri.parse('${Enviroment.apiurl}/user/renew'),
          headers: {'Content-Type': 'application/json', "x-token": token});
      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        this.user = loginResponse.user;
        await storage.setValue(loginResponse.token, "token");
        autenticated = false;
        return true;
      } else {
        await storage.deleteValue("x-token");
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(
      String email, String password, String name, int phoneNumber) async {
    final data = {
      "email": email,
      "password": password,
      "name": name,
      "phoneNumber": phoneNumber
    };
    final resp = await http.post(Uri.parse('${Enviroment.apiurl}/user/new'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      await storage.setValue(loginResponse.token, "token");
      autenticated = false;
      return true;
    } else {
      return false;
    }
  }
}
