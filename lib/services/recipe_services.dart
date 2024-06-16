import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_suggester/custom_widgets/show_shackbar.dart';
import 'package:food_suggester/models/auto_complete_dishes.dart';
import 'package:food_suggester/models/cooking_steps_model.dart';
import 'package:food_suggester/models/food_item_model.dart';
import 'package:food_suggester/models/recipe_information_model.dart';
import 'package:food_suggester/models/recipes_by_ingredients_model.dart';
import 'package:http/http.dart' as http;

class RecipeServices {
  final apiKey = '193a7e93c26742828a3c7a811048501b';
  final autoCompleteBaseUri =
      'https://api.spoonacular.com/recipes/autocomplete';

  // auto complete recipe search
  // this function will get called every time user types something
  Future<List<AutoCompleteDishesModel>> autoComplete(
      String dish) async {
    try {
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
    } catch (e) {
      log('autoComplete');
      //
      return [];
    }
  }

  Future<List<FoodItemModel>> getFoodItems(
      String food) async {
    try {
      const getRecipesBaseUri =
          'https://api.spoonacular.com/recipes/complexSearch';
      log('getfooditem called');
      log('food $food');
      final response = await http.get(
        Uri.parse('$getRecipesBaseUri?apiKey=$apiKey&query=$food&number=20'),
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
    } catch (e) {
      log('getFoodItems');

      return [];
    }
  }

  Future<String> getSummaryById(int id, ) async {
    try {
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
    } catch (e) {
      log('getSummaryById');

      return '';
    }
  }

  Future<RecipeInformationModel?> getRecipeInformation(
      int id, ) async {
    try {
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
    } catch (e) {
      log('getRecipeInformation $e');

      return null;
    }
  }

  Future<Uint8List?> getImage(int id, ) async {
    try {
      final baseUri =
          'https://api.spoonacular.com/recipes/${id.toString()}/ingredientWidget.png?apiKey=$apiKey&measure=metric';
      final image = await http.get(Uri.parse(baseUri));

      if (image.statusCode == 200) {
        return image.bodyBytes;
      } else {
        log('some error at api call');
        return null;
      }
    } catch (e) {
      log('getImage');

      return null;
    }
  }

  Future<List<CookingStepsModel>> getCookingSetps(
      int id, ) async {
    try {
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
    } catch (e) {
      log('getCookingSetps');

      return [];
    }
  }

  Future<List<RecipesByIngredientsModel>> getRecipesbyIngredients(
      String ingredients) async {
    try {
      final response = await http.get(
          Uri.parse(
              'https://api.spoonacular.com/recipes/findByIngredients?apiKey=$apiKey&ingredients=$ingredients&ranking=2&number=10'),
          headers: {
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        log(response.body);
        final result = jsonDecode(response.body) as List;
        final listOfRecipes =
            result.map((e) => RecipesByIngredientsModel.fromMap(e)).toList();
        return listOfRecipes;
      } else {
        log('some error');
        log('${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('getRecipesbyIngredients');

      return [];
    }
  }
}
