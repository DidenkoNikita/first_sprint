import 'dart:convert';

import 'package:evently_sprint/requests/get_token/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GetToken implements AbstractGetToken {
  var url = Uri.http('192.168.1.94:3000', 'check_remember_me');
  @override
  Future<String?> getToken() async {
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
      print('User id: $id');
      print('Access Token: $accessToken');
      return response.body;
    } else {
      print('Ошибка при запросе: ${response.statusCode}');
      return null;
    }
  }
}
