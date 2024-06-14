import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:food_suggester/models/auto_complete_dishes.dart';
import 'package:food_suggester/models/cooking_steps_model.dart';
import 'package:food_suggester/models/food_item_model.dart';
import 'package:food_suggester/models/recipe_information_model.dart';
import 'package:http/http.dart' as http;

class RecipeServices {
  final apiKey = '193a7e93c26742828a3c7a811048501b';
  final autoCompleteBaseUri =
      'https://api.spoonacular.com/recipes/autocomplete';

  // auto complete recipe search
  // this function will get called every time user types something
  Future<List<AutoCompleteDishesModel>> autoComplete(String dish) async {
    log('fun called');
    final response = await http.get(
      Uri.parse(
        '$autoCompleteBaseUri?apiKey=$apiKey&number=5&query=$dish',
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      List<AutoCompleteDishesModel> dishes = (result as List<dynamic>)
          .map((json) => AutoCompleteDishesModel.fromMap(json))
          .toList();
      return dishes;
    } else {
      log('some error occured ${response.statusCode}');
      log(response.body.toString());
      // return empty list
      return [];
    }
  }


  Future<List<FoodItemModel>> getFoodItems(String food) async {
  const getRecipesBaseUri = 'https://api.spoonacular.com/recipes/complexSearch';
    log('getfooditem called');
    log('food $food');
    final response = await http.get(
      Uri.parse(
          '$getRecipesBaseUri?apiKey=$apiKey&query=$food&number=10'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      log(response.body);
      final foodItemList = result['results'] as List;

      List<FoodItemModel> foodItems =
          foodItemList.map((map) => FoodItemModel.fromJson(map)).toList();
      if (foodItems.isNotEmpty) {
        return foodItems;
      } else {
        return [];
      }
    } else {
      log('some error occured ${response.statusCode}');
      log(response.body.toString());
      // return empty list
      return [];
    }
  }


  Future<String> getSummaryById(int id) async {
    final baseUri =
        'https://api.spoonacular.com/recipes/${id.toString()}/summary?apiKey=$apiKey';
    final response = await http.get(
      Uri.parse(baseUri),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      log(result['summary']);
      return result['summary'] as String;
    } else {
      log('some error');
      log('${response.statusCode}');
      return '';
    }
  }

  Future<RecipeInformationModel?> getRecipeInformation(int id) async {
    final baseUri =
        'https://api.spoonacular.com/recipes/${id.toString()}/information/?apiKey=$apiKey';
    final response = await http.get(
      Uri.parse(baseUri),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      log(response.body);
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      return RecipeInformationModel.fromMap(result);
    } else {
      log('some error');
      log('${response.statusCode}');
      return null;
    }
  }

  Future<Uint8List?> getImage(int id) async {
    final baseUri =
        'https://api.spoonacular.com/recipes/${id.toString()}/ingredientWidget.png?apiKey=$apiKey&measure=metric';
    final image = await http.get(Uri.parse(baseUri));

    if (image.statusCode == 200) {
      return image.bodyBytes;
    } else {
      log('some error at api call');
      return null;
    }
  }

  Future<List<CookingStepsModel>> getCookingSetps(int id) async {
    final baseUri =
        'https://api.spoonacular.com/recipes/${id.toString()}/analyzedInstructions?apiKey=$apiKey&stepBreakdown=true';
    final response = await http.get(
      Uri.parse(baseUri),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      List steps = result[0]['steps'];
      List<CookingStepsModel> cookingSteps =
          steps.map((json) => CookingStepsModel.fromMap(json)).toList();

      return cookingSteps;
    } else {
      log('some error');
      log('${response.statusCode}');
      return [];
    }
  }
}

// [
//     {
//         "name": "",
//         "steps": [
//             { json
//                 "number": 1,
//                 "step": "Rinse the beans thoroughly and place them in a 7-quart slow cooker along with the water, onion, garlic, and bay leaf. Cover and cook on LOW for about 8 hours, or until the beans are nice and tender.",
//                 "ingredients": [
//                     {
//                         "id": 2004,
//                         "name": "bay leaves",
//                         "localizedName": "bay leaves",
//                         "image": "https://spoonacular.com/cdn/ingredients_100x100/bay-leaves.jpg"
//                     },
//                     {
//                         "id": 11215,
//                         "name": "garlic",
//                         "localizedName": "garlic",
//                         "image": "https://spoonacular.com/cdn/ingredients_100x100/garlic.png"
//                     },
//                     {
//                         "id": 0,
//                         "name": "beans",
//                         "localizedName": "beans",
//                         "image": "https://spoonacular.com/cdn/ingredients_100x100/kidney-beans.jpg"
//                     },
//                     {
//                         "id": 11282,
//                         "name": "onion",
//                         "localizedName": "onion",
//                         "image": "https://spoonacular.com/cdn/ingredients_100x100/brown-onion.png"
//                     },
//                     {
//                         "id": 14412,
//                         "name": "water",
//                         "localizedName": "water",
//                         "image": "https://spoonacular.com/cdn/ingredients_100x100/water.png"
//                     }
//                 ],
//                 "equipment": [
//                     {
//                         "id": 404718,
//                         "name": "slow cooker",
//                         "localizedName": "slow cooker",
//                         "image": "https://spoonacular.com/cdn/equipment_100x100/slow-cooker.jpg"
//                     }
//                 ],
//                 "length": {
//                     "number": 480,
//                     "unit": "minutes"
//                 }
//             },
//             {
//                 "number": 2,
//                 "step": "Remove the bay leaf. Using a handheld immersion blender, puree the remaining ingredients to the desired texture.",
//                 "ingredients": [
//                     {
//                         "id": 2004,
//                         "name": "bay leaves",
//                         "localizedName": "bay leaves",
//                         "image": "https://spoonacular.com/cdn/ingredients_100x100/bay-leaves.jpg"
//                     }
//                 ],
//                 "equipment": [
//                     {
//                         "id": 404776,
//                         "name": "immersion blender",
//                         "localizedName": "immersion blender",
//                         "image": "https://spoonacular.com/cdn/equipment_100x100/immersion-blender.png"
//                     }
//                 ]
//             },
//             {
//                 "number": 3,
//                 "step": "Add the salt to taste.Ladle the soup into bowls.",
//                 "ingredients": [
//                     {
//                         "id": 2047,
//                         "name": "salt",
//                         "localizedName": "salt",
//                         "image": "https://spoonacular.com/cdn/ingredients_100x100/salt.jpg"
//                     },
//                     {
//                         "id": 0,
//                         "name": "soup",
//                         "localizedName": "soup",
//                         "image": ""
//                     }
//                 ],
//                 "equipment": [
//                     {
//                         "id": 404783,
//                         "name": "bowl",
//                         "localizedName": "bowl",
//                         "image": "https://spoonacular.com/cdn/equipment_100x100/bowl.jpg"
//                     },
//                     {
//                         "id": 404630,
//                         "name": "ladle",
//                         "localizedName": "ladle",
//                         "image": "https://spoonacular.com/cdn/equipment_100x100/ladle.jpg"
//                     }
//                 ]
//             },
//             {
//                 "number": 4,
//                 "step": "Drizzle with the olive oil, sprinkle with rosemary, and serve.",
//                 "ingredients": [
//                     {
//                         "id": 4053,
//                         "name": "olive oil",
//                         "localizedName": "olive oil",
//                         "image": "https://spoonacular.com/cdn/ingredients_100x100/olive-oil.jpg"
//                     },
//                     {
//                         "id": 2036,
//                         "name": "rosemary",
//                         "localizedName": "rosemary",
//                         "image": "https://spoonacular.com/cdn/ingredients_100x100/rosemary.jpg"
//                     }
//                 ],
//                 "equipment": []
//             }
//         ]
//     }
// ]