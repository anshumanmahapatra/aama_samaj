class LengthModel {
  final int length;

  LengthModel({required this.length});

  factory LengthModel.fromJson(Map json) {
    return LengthModel(length: json['length']);
  }
}
