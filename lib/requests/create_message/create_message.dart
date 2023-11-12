import 'dart:convert';

import 'package:evently_sprint/requests/create_message/request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreateMessage implements AbstractCreateMessage {
  CreateMessage(
      {required this.id,
      required this.text,
      required this.chatId,
      required this.postId});

  final int id;
  final String text;
  final int? chatId;
  final int? postId;

  @override
  Future createMessage() async {
    await dotenv.load();
    String? api = dotenv.env['SERVER_API'];
    var url = Uri.http(api.toString(), 'messages');

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
        body: jsonEncode({
          'user2Id': id,
          'text': text,
          'chatId': chatId,
          'user_id': userId,
          'postId': postId
        }),
      );

      final dynamic responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return responseData;
      }
    }
  }
}
