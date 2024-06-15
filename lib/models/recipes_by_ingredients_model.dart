class RecipesByIngredientsModel {
  final String image;
  final int id;
  final List<MissedIngredients> missingIngredients;
  final int missedIngredientCount;
  final List<UnusedIngredients> unusedIngredients;
  final List<UsedIngredients> usedIngredients;
  final String title;

  RecipesByIngredientsModel({
    required this.image,
    required this.missedIngredientCount,
    required this.id,
    required this.missingIngredients,
    required this.unusedIngredients,
    required this.usedIngredients,
    required this.title,
  });

  factory RecipesByIngredientsModel.fromMap(Map<String, dynamic> json) {
    // for missedIngredientsList
    List missedIngreList = json['missedIngredients'];
    final List<MissedIngredients> missedIngredientsList =
        missedIngreList.map((e) => MissedIngredients.fromMap(e)).toList();

    // for missedIngredientsList
    List unusedIngreList = json['missedIngredients'];
    final List<UnusedIngredients> unusedIngredientsList =
        unusedIngreList.map((e) => UnusedIngredients.fromMap(e)).toList();

    // for missedIngredientsList
    List usedIngreList = json['missedIngredients'];
    final List<UsedIngredients> usedIngredientsList =
        usedIngreList.map((e) => UsedIngredients.fromMap(e)).toList();

    return RecipesByIngredientsModel(
      image: json['image'],
      id: json['id'],
      missedIngredientCount: json['missedIngredientCount'],
      missingIngredients: missedIngredientsList,
      unusedIngredients: unusedIngredientsList,
      usedIngredients: usedIngredientsList,
      title: json['title'],
    );
  }
}

class MissedIngredients {
  final String image;
  final String name;

  MissedIngredients({required this.image, required this.name});

  factory MissedIngredients.fromMap(Map<String, dynamic> json) {
    return MissedIngredients(image: json['image'], name: json['name']);
  }
}

class UnusedIngredients {
  final String image;
  final String name;

  UnusedIngredients({required this.image, required this.name});

  factory UnusedIngredients.fromMap(Map<String, dynamic> json) {
    return UnusedIngredients(image: json['image'], name: json['name']);
  }
}

class UsedIngredients {
  final String image;
  final String name;

  UsedIngredients({required this.image, required this.name});

  factory UsedIngredients.fromMap(Map<String, dynamic> json) {
    return UsedIngredients(image: json['image'], name: json['name']);
  }
}
