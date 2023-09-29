import 'dart:convert';

import 'package:evently_sprint/requests/get_stories/reguest.dart';
import 'package:http/http.dart' as http;

class GetStories implements AbstractGetStories {
  var url = Uri.http('192.168.1.94:3000', 'stories');

  @override
  Future getStories() async {
    try {
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
