import 'dart:convert';

import 'package:evently_sprint/requests/get_user/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class GetUser implements AbstractGetUser {
  @override
  Future getUser() async {
    await dotenv.load();
    String? api = dotenv.env['SERVER_API'];
    var url = Uri.http(api.toString(), 'user');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');
    final String? accessToken = prefs.getString('accessToken');
    if (userId == null || accessToken == null) {
      return null;
    } else {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({'user_id': userId}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else if (response.statusCode == 201) {
        final String responseData = json.decode(response.body);
        final accessToken = responseData;
        prefs.setString('accessToken', accessToken);
      } else {
        debugPrint('Ошибка при запросе: ${response.statusCode}');
        return null;
      }
    }
  }
}
