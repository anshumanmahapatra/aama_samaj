import 'package:aama_samaj_temp_frontend/models/length_model.dart';
import 'package:aama_samaj_temp_frontend/models/vote_model.dart';
import 'package:aama_samaj_temp_frontend/services/api/comments_api.dart';
import 'package:aama_samaj_temp_frontend/services/api/downvotes_api.dart';
import 'package:aama_samaj_temp_frontend/services/api/upvotes_api.dart';

import '../services/api/post_api.dart';
import 'package:get/get.dart';

import '../models/post_model.dart';

class PostController extends GetxController {
  @override
  void onInit() {
    getPost();
    super.onInit();
  }

  Future<List<PostModel>>? postData;
  Future<VoteModel>? checkHasUpvoted;
  Future<VoteModel>? checkHasDownvoted;
  Future<LengthModel>? upvotesLength;
  Future<LengthModel>? downvotesLength;
  Future<LengthModel>? commentsLength;

  getPost() {
    postData = PostsApi().getPost();
  }

  getUpvotesLength(int postId) {
    upvotesLength = UpvotesApi().getUpvotesLength(postId);
  }

  checkUpvoted(int postId, int userId) {
    checkHasUpvoted = UpvotesApi().checkIfUpvoted(postId, userId);
  }

  getDownvotesLength(int postId) {
    downvotesLength = DownvotesApi().getDownvotesLength(postId);
  }

  checkDownvoted(int postId, int userId) {
    checkHasDownvoted = DownvotesApi().checkIfDownvoted(postId, userId);
  }

  getCommentsLength(int postId) {
    commentsLength = CommentsApi().getCommentsLength(postId);
  }
}
