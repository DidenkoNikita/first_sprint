import 'dart:convert';

import 'package:evently_sprint/requests/create_comment/request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateComment implements AbstractCreateComment {
  CreateComment({required this.text, required this.postId});

  final String text;
  final int postId;

  @override
  Future createComment() async {
    await dotenv.load();
    String? api = dotenv.env['SERVER_API'];
    var url = Uri.http(api.toString(), 'comments');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');
    final String? accessToken = prefs.getString('accessToken');
    debugPrint(text);
    debugPrint(postId.toString());
    if (userId == null || accessToken == null) {
      return null;
    } else {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({'text': text, 'user_id': userId, 'post_id': postId}),
      );

      final dynamic responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return responseData;
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
