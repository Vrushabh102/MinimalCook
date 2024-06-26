import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_suggester/colors.dart';
import 'package:food_suggester/custom_widgets/suggested_food_item_card.dart';
import 'package:food_suggester/models/recipes_by_ingredients_model.dart';
import 'package:food_suggester/screens/show_recipe_info_page.dart';
import 'package:food_suggester/services/recipe_services.dart';

class SuggestedRecipes extends StatefulWidget {
  const SuggestedRecipes({super.key, required this.ingredients});
  final List<String> ingredients;

  @override
  State<SuggestedRecipes> createState() => _SuggestedRecipesState();
}

class _SuggestedRecipesState extends State<SuggestedRecipes> {
  String commaSeperatedList = '';

  commaSeperate(List<String> list) {
    log('list started');
    commaSeperatedList += list[0];
    for (int i = 1; i < list.length; i++) {
      commaSeperatedList += ',${list[i]}';
    }
    log('comma list$commaSeperatedList');
    return commaSeperatedList;
  }

  @override
  Widget build(BuildContext context) {
    commaSeperate(widget.ingredients);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: RecipeServices().getRecipesbyIngredients(commaSeperatedList),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: shakaYellow,
              ));
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text('No recipes...Try adding more ingedients'),
              );
            } else {
              List<RecipesByIngredientsModel> ingredients =
                  snapshot.data as List<RecipesByIngredientsModel>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 256,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0,
                  ),
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowRecipeInfo(
                                model: ingredients[index],
                                showMissedIngredients:
                                    ingredients[index].missedIngredientCount !=
                                        0,
                                imageUrl: ingredients[index].image,
                                title: ingredients[index].title,
                                id: ingredients[index].id),
                          ),
                        );
                      },
                      child: SuggestedFoodItemCard(
                        imageUrl: ingredients[index].image,
                        id: ingredients[index].id,
                        title: ingredients[index].title,
                        missedIngredientsCount:
                            ingredients[index].missedIngredientCount == 0
                                ? null
                                : ingredients[index].missedIngredientCount,
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
