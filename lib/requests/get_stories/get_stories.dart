import 'dart:convert';

import 'package:evently_sprint/requests/get_stories/reguest.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GetStories implements AbstractGetStories {
  @override
  Future getStories() async {
    try {
      await dotenv.load();
      String? api = dotenv.env['SERVER_API'];
      var url = Uri.http(api.toString(), 'stories');
      
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      var jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
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
