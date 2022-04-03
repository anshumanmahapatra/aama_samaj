class VoteModel {
  final bool isVoted;

  VoteModel({required this.isVoted});

  factory VoteModel.fromUpvoteJson(Map json) {
    return VoteModel(isVoted: json['is_upvoted']);
  }

  factory VoteModel.fromDownvoteJson(Map json) {
    return VoteModel(isVoted: json['is_downvoted']);
  }
}
