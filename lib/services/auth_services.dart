import 'dart:convert';

import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import 'package:chat_app/models/login_response.dart';

class AuthServices with ChangeNotifier {
  late User user;
  bool _autenticated = false;
  bool get autenticated => this._autenticated;
  set autenticated(bool value) {
    this._autenticated = value;
    notifyListeners();
  }

  Future login(String email, String password) async {
    autenticated = true;
    LoginResponse loginResponse;
    final data = {"email": email, "password": password};
    print(Uri.parse('${Enviroment.apiurl}/user/login'));
    final resp = await http.post(Uri.parse('${Enviroment.apiurl}/user/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    if (resp.statusCode == 200) {
      loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;
      autenticated = false;
      return loginResponse;
    }
  }
}
