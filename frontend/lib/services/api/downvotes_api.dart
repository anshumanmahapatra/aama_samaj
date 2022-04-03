import 'dart:convert';

import '../../models/length_model.dart';
import '../../models/vote_model.dart';
import 'package:http/http.dart' as http;

class DownvotesApi {
  String baseUrl = "http://192.168.8.122:8000/api/";

  Future<VoteModel> checkIfDownvoted(int postId, int userId) async {
    final response = await http.get(
        Uri.parse(baseUrl + "check-is-downvoted/$postId/$userId"),
        headers: <String, String>{
          'Authorization': 'Bearer 7|gExUkEk24jmHv6lRCNtMA0FYeBYl5T2DwvEoJTwS',
        });

    if (response.statusCode == 200) {
      return VoteModel.fromDownvoteJson(jsonDecode(response.body));
    } else {
      throw Exception('Sorry we could not fetch downvotes');
    }
  }

  Future<LengthModel> getDownvotesLength(int postId) async {
    final response = await http.get(
        Uri.parse(baseUrl + "get-downvotes-length/$postId"),
        headers: <String, String>{
          'Authorization': 'Bearer 7|gExUkEk24jmHv6lRCNtMA0FYeBYl5T2DwvEoJTwS',
        });

    if (response.statusCode == 200) {
      return LengthModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Sorry we could not fetch downvotes length');
    }
  }
}
