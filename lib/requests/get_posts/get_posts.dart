import 'dart:convert';

import 'package:evently_sprint/requests/get_posts/request.dart';
import 'package:http/http.dart' as http;

class GetPosts implements AbstractGetPosts {
  var url = Uri.http('192.168.1.94:3000', 'posts');

  @override
  Future getPosts() async {
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      var jsonResponse = json.decode(response.body);

      if (jsonResponse != null && jsonResponse['post'] is List) {
        List<Map<String, dynamic>> data =
            jsonResponse['post'].cast<Map<String, dynamic>>();
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return e;
    }
  }
}
