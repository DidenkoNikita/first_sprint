import 'dart:convert';

import 'package:evently_sprint/requests/get_user_list/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetUserList implements AbstractGetUserList {
  @override
  Future getUserList() async {
    await dotenv.load();
    String? api = dotenv.env['SERVER_API'];
    var url = Uri.http(api.toString(), 'user_list');

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

      final dynamic responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        dynamic filteredUsers =
            responseData.where((user) => user['id'] != userId).toList();
        return filteredUsers;
      } else if (response.statusCode == 201) {
        final accessToken = responseData;
        prefs.setString('accessToken', accessToken);
      } else {
        debugPrint('Ошибка при запросе: ${response.statusCode}');
        return null;
      }
    }
  }
}
