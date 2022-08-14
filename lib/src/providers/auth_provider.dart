import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../shared_preferences/shared_preferences.dart';

class AuthProvider {
  final _prefs = new PreferenciasUsuario();
  final baseUrl = 'https://reqres.in/api/login';
  Future<Map<String, dynamic>> login(
      String email, String password, BuildContext context) async {
    final authData = {'email': email, 'password': password};
    print(json.encode(authData));

    Map<String, String> headers = {"Content-type": "application/json"};
    final url = Uri.parse('${baseUrl}');

    final res =
        await http.post(url, body: json.encode(authData), headers: headers);

    Map<String, dynamic> decodedResp = json.decode(res.body);

    print(decodedResp);

    if (decodedResp.containsKey('token')) {
      // TODO: salvar token en el storage
      _prefs.token = decodedResp['token'];
            print('Prefs');
      print(_prefs.token);
      return {'ok': true, 'token': decodedResp['token']};
    } else {
      return {'ok': false, 'message': 'Failed login'};
    }
  }


  logout() {
    _prefs.token = '';
  }
}
