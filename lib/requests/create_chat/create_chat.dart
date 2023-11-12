import 'dart:convert';

import 'package:evently_sprint/requests/create_chat/request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreateChat implements AbstractCreateChat {
  CreateChat({required this.id});

  final int id;

  @override
  Future createChat() async {
    await dotenv.load();
    String? api = dotenv.env['SERVER_API'];
    var url = Uri.http(api.toString(), 'chats');

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
          'user1Id': userId,
          'user2Id': id,
        }),
      );

      final dynamic responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        return responseData;
      }
    }
  }
}
