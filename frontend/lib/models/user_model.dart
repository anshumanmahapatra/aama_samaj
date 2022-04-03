class UserModel {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String serviceProvider;
  final String imageUrl;
  final String address;
  final int points;
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.serviceProvider,
    required this.imageUrl,
    required this.address,
    required this.points,
    required this.isAdmin,
  });

  factory UserModel.fromJson(Map json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'].toString(),
      serviceProvider: json['service_provider'],
      imageUrl: json['image_url'],
      address: json['address'],
      points: json['points'],
      isAdmin: json['is_admin'],
    );
  }
}
