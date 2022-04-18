import 'dart:convert';

import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/menssage_response.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late User userTo;

  Future<List<Mensaje>> getChats(String id) async {
    final resp = await http
        .get(Uri.parse('${Enviroment.apiurl}/menssage/$id'), headers: {
      'Content-Type': 'application/json',
      'x-token': await StorageService().getValue("token")
    });
    print(resp.body);
    if (resp.statusCode == 200) {
      final data = menssageResponseFromJson(resp.body);
      return data.mensajes;
    } else {
      return [];
    }
  }
}
