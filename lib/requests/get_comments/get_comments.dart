import 'dart:convert';

import 'package:evently_sprint/requests/get_comments/abstract_get_comments.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GetComments implements AbstractGetComments {
  @override
  Future getComments() async {
    await dotenv.load();
    String? api = dotenv.env['SERVER_API'];
    var url = Uri.http(api.toString(), 'comments');

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      var jsonResponse = json.decode(response.body);

      if (jsonResponse != null && jsonResponse is List) {
        List<Map<String, dynamic>> data =
            jsonResponse.cast<Map<String, dynamic>>();
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return e;
    }
  }
}
