import 'dart:convert';

import '../../models/post_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class PostsApi {
  String baseUrl = "http://192.168.8.122:8000/api/";

  Future<List<PostModel>> getPost() async {
    String url = baseUrl + "get-posts";
    debugPrint(url);
    final response = await http
        .get(Uri.parse(baseUrl + "get-posts"), headers: <String, String>{
      'Authorization': 'Bearer 7|gExUkEk24jmHv6lRCNtMA0FYeBYl5T2DwvEoJTwS',
    });

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List result = data['data'];
      return PostModel.getPosts(result);
    } else {
      throw Exception('Sorry we could not fetch posts');
    }
  }
}
