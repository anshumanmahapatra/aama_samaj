import 'dart:convert';

import '../../models/length_model.dart';
import 'package:http/http.dart' as http;

class CommentsApi {
  String baseUrl = "http://192.168.8.122:8000/api/";

  Future<LengthModel> getCommentsLength(int postId) async {
    final response = await http.get(
        Uri.parse(baseUrl + "get-comments-length/$postId"),
        headers: <String, String>{
          'Authorization': 'Bearer 7|gExUkEk24jmHv6lRCNtMA0FYeBYl5T2DwvEoJTwS',
        });

    if (response.statusCode == 200) {
      return LengthModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Sorry we could not fetch comments length');
    }
  }
}
