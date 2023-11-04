import 'dart:convert';
import 'package:evently_sprint/requests/upload_avatar/abstract_upload_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UploadAvatar implements AbstractUploadAvatar {
  UploadAvatar({required this.image});

  final String image;

  @override
  Future uploadAvatar() async {
    await dotenv.load();
    String? api = dotenv.env['SERVER_API'];
    var url = Uri.http(api.toString(), 'upload_avatar_mobile');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');

    if (userId == null) {
      return null;
    } else {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'file': image, 'user_id': userId}),
      );
      final dynamic responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return responseData;
      } else {
        debugPrint('Ошибка при запросе: ${response.statusCode}');
        return null;
      }
    }
  }
}
