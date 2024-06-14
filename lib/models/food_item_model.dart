class FoodItemModel {
  final String imageUrl;
  final String title;
  final int id;

  FoodItemModel({
    required this.imageUrl,
    required this.title,
    required this.id,
  });

  factory FoodItemModel.fromJson(Map<String, dynamic> json) {
    return FoodItemModel(
      imageUrl: json['image'],
      title: json['title'],
      id: json['id'],
    );
  }
}
