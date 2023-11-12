import 'dart:convert';

import 'package:evently_sprint/requests/message_is_read/request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MessageIsRead implements AbstractMessageIsRead {
  MessageIsRead({required this.id, required this.userId});

  final int id;
  final int userId;

  @override
  Future messageIsRead() async {
    await dotenv.load();
    String? api = dotenv.env['SERVER_API'];
    var url = Uri.http(api.toString(), 'message_is_read');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? idUser = prefs.getInt('userId');
    final String? accessToken = prefs.getString('accessToken');

    try {
      if (idUser == null || accessToken == null) {
        return null;
      } else {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode({
            'user_id': idUser,
            'id': id,
            'userId': userId,
          }),
        );
        final dynamic responseData = json.decode(response.body);

        if (response.statusCode == 200) {
          return responseData;
        }
      }
    } catch (e) {
      return e;
    }
  }
}
