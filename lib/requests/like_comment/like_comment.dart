import 'dart:convert';

import 'package:evently_sprint/requests/like_comment/request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikeComment implements AbstractLikeComment {
  LikeComment({required this.commentId});

  final int commentId;

  @override
  Future likeComment() async {
    await dotenv.load();
    String? api = dotenv.env['SERVER_API'];
    var url = Uri.http(api.toString(), 'comments');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');
    final String? accessToken = prefs.getString('accessToken');
    if (userId == null || accessToken == null) {
      return null;
    } else {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({'comment_id': commentId, 'user_id': userId}),
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
