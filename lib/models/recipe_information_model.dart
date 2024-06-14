class RecipeInformationModel {
  final int readyInMinutes;
  final bool vegetarian;
  final int servings;
  final bool vegan;

  RecipeInformationModel({
    required this.readyInMinutes,
    required this.vegetarian,
    required this.vegan,
    required this.servings,
  });

  factory RecipeInformationModel.fromMap(Map<String, dynamic> json) {
    return RecipeInformationModel(
      readyInMinutes: json['readyInMinutes'],
      vegetarian: json['vegetarian'],
      vegan: json['vegan'],
      servings: json['servings'],
    );
  }
}
