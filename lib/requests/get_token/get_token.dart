import 'dart:convert';

import 'package:evently_sprint/requests/get_token/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetToken implements AbstractGetToken {
  @override
  Future<String?> getToken() async {
    await dotenv.load();
    String? api = dotenv.env['SERVER_API'];
    var url = Uri.http(api.toString(), 'check_remember_me');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    String? refreshToken = prefs.getString('refreshToken');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $refreshToken',
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({'user_id': userId}),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      int id = responseData['id'];
      String accessToken = responseData['accessToken'];
      prefs.setInt('userId', id);
      prefs.setString('accessToken', accessToken);
      return response.body;
    } else {
      debugPrint('Ошибка при запросе: ${response.statusCode}');
      return null;
    }
  }
}
