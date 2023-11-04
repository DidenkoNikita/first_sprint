import 'package:evently_sprint/requests/login/abstract_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Login implements AbstractLogin {
  Login({
    required this.context,
    required this.user,
    required this.navigatorKey,
  });

  final context;
  final Map<String, dynamic> user;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Future login() async {
    await dotenv.load(fileName: ".env");
    String? api = dotenv.env['SERVER_API'];
    print('url $api');
    var url = Uri.http(api.toString(), 'login_remember_me');

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'user': user}),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      int id = responseData['id'];
      String accessToken = responseData['accessToken'];
      String refreshToken = responseData['refreshToken'];

      prefs.setInt('userId', id);
      prefs.setString('accessToken', accessToken);
      prefs.setString('refreshToken', refreshToken);
      navigatorKey.currentState?.pushNamed('/');
    } else {
      debugPrint('Ошибка при запросе: ${response.statusCode}');
    }
  }
}
