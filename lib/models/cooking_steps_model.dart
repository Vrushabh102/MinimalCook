// this class onject represents each step
class CookingStepsModel {
  final int number;
  final String instructions;
  List<IngredientsForEachStepModel> ingredients;
  List<EquipmentForEachStepModel> equipment;

  CookingStepsModel({
    required this.number,
    required this.instructions,
    required this.equipment,
    required this.ingredients,
  });

  factory CookingStepsModel.fromMap(Map<String, dynamic> json) {
    // converting json of ingredients inside the list of each step into a ingredients object
    List ingredientsJsonList = json['ingredients'];
    List<IngredientsForEachStepModel> ingredientsObjects = ingredientsJsonList
        .map((ingredientsJson) =>
            IngredientsForEachStepModel.fromMap(ingredientsJson))
        .toList();

    // converting json of equipments inside the list of each step into a equipments object
    List equipmentsJsonList = json['equipment'];
    List<EquipmentForEachStepModel> equipmentsObjects = equipmentsJsonList
        .map(
            (equipmentJson) => EquipmentForEachStepModel.fromMap(equipmentJson))
        .toList();

    return CookingStepsModel(
      number: json['number'],
      instructions: json['step'],
      ingredients: ingredientsObjects,
      equipment: equipmentsObjects,
    );
  }
}

class IngredientsForEachStepModel {
  final String name;
  final String image;

  IngredientsForEachStepModel({
    required this.name,
    required this.image,
  });

  factory IngredientsForEachStepModel.fromMap(Map<String, dynamic> json) {
    return IngredientsForEachStepModel(
      name: json['name'],
      image: json['image'],
    );
  }
}

class EquipmentForEachStepModel {
  final String name;
  final String image;

  EquipmentForEachStepModel({
    required this.name,
    required this.image,
  });

  factory EquipmentForEachStepModel.fromMap(Map<String, dynamic> json) {
    return EquipmentForEachStepModel(
      name: json['name'],
      image: json['image'],
    );
  }
}
