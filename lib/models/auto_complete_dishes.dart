class AutoCompleteDishesModel {
  final String title;
  AutoCompleteDishesModel({required this.title});
  factory AutoCompleteDishesModel.fromMap(Map<String, dynamic> json) {
    return AutoCompleteDishesModel(title: json['title']);
  }
}
