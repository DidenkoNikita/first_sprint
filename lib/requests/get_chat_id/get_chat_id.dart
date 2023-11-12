import 'dart:convert';

import 'package:evently_sprint/requests/get_chat_id/request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetChatId implements AbstractGetChatId {
  GetChatId({required this.friendId});
  final int friendId;

  @override
  Future getChatId() async {
    await dotenv.load();
    String? api = dotenv.env['SERVER_API'];
    var url = Uri.http(api.toString(), 'get_chat_id');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');
    final String? accessToken = prefs.getString('accessToken');

    try {
      if (userId == null || accessToken == null) {
        return null;
      } else {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode({'user_id': userId, 'user2Id': friendId}),
        );

        final dynamic responseData = json.decode(response.body);

        if (response.statusCode == 200) {
          return responseData;
        } else if (response.statusCode == 201) {
          final accessToken = responseData;
          prefs.setString('accessToken', accessToken);
        }
      }
    } catch (e) {
      return e;
    }
  }
}
