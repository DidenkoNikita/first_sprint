import 'package:evently_sprint/requests/registration/abstract_registration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Registration implements AbstractRegistration {
  Registration({
    required this.user,
    required this.navigatorKey,
  });

  final Map<dynamic, dynamic> user;
  final GlobalKey<NavigatorState> navigatorKey;
  var url = Uri.http('192.168.1.94:3000', 'signup_remember_me');

  @override
  Future registration() async {
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

      print('User id: $id');
      print('Access Token: $accessToken');
      print('Refresh Token: $refreshToken');

      // Теперь мы можем использовать navigatorKey для перехода на HomePage
      navigatorKey.currentState?.pushReplacementNamed('/');
    } else {
      print('Ошибка при запросе: ${response.statusCode}');
    }
  }
}
