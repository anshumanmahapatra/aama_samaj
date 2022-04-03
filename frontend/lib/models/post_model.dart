class PostModel {
  final int id;
  final String imageUrl;
  final String userImageUrl;
  final String userName;
  final String category;
  final String address;
  final String description;
  final int isPoll;
  final String created;
  final String updated;
  final int userId;
  final int isUpdated;
  final String progress;

  PostModel(
      {required this.id,
      required this.imageUrl,
      required this.userImageUrl,
      required this.userName,
      required this.category,
      required this.address,
      required this.description,
      required this.isPoll,
      required this.created,
      required this.updated,
      required this.userId,
      required this.isUpdated,
      required this.progress});

  factory PostModel.fromJson(Map json) {
    return PostModel(
      id: json['post']['id'],
      imageUrl: json['post']['image_url'] ?? "",
      userImageUrl: json['user']['image_url'] ?? "https://images4.alphacoders.com/476/thumb-350-47698.png",
      userName: json['user']['name'],
      category: json['post']['category'],
      address: json['post']['address'],
      description: json['post']['description'],
      isPoll: json['post']['is_poll'],
      created: json['post']['created_at'],
      updated: json['post']['updated_at'],
      userId: json['post']['user_id'],
      isUpdated: json['post']['is_updated'],
      progress: json['post']['progress'],
    );
  }

  static List<PostModel> getPosts(List data) {
    return data.map((e) => PostModel.fromJson(e)).toList();
  }
}
