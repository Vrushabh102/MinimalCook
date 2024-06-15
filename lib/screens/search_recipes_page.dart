import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_suggester/colors.dart';
import 'package:food_suggester/custom_widgets/food_item_container.dart';
import 'package:food_suggester/models/auto_complete_dishes.dart';
import 'package:food_suggester/models/food_item_model.dart';
import 'package:food_suggester/screens/show_recipe_info_page.dart';
import 'package:food_suggester/services/recipe_services.dart';
import 'package:food_suggester/styles/text_input_decoration.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  final controller = TextEditingController();
  List<AutoCompleteDishesModel> dishes = [];
  List<FoodItemModel> foodItems = [];
  bool showSuggestions = false;
  bool showFoodItems = false;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.text.isNotEmpty) {
        setState(() {
          onChanged(controller.text);
          showSuggestions = true;
          showFoodItems = false;
        });
      } else if (controller.text.isEmpty) {
        setState(() {
          showSuggestions = false;
          showFoodItems = false;
        });
      }
    });
    super.initState();
  }

  Future<void> onChanged(String dish) async {
    log('on changed called');
    // fetch autocorrect suggestions
    final list = await RecipeServices().autoComplete(dish);
    if (list.isNotEmpty && showSuggestions == true) {
      dishes.clear();
      dishes.addAll(list);
      log("autocomplete dishes${dishes.length}");
      for (var element in dishes) {
        log(element.title);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 18, top: 30),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'for recipes',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: TextField(
                  controller: controller,
                  cursorColor: shakaYellow,
                  decoration: textInputDecoration('Dish name', context),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        showSuggestions = false;
                        showFoodItems = true;
                      });
                    }
                  },
                ),
              ),

              // suggestion widget for autocorrect
              Offstage(
                offstage: !showSuggestions,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    itemCount: dishes.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: width * 0.8,
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              controller.text = dishes[index].title;
                              showSuggestions = false;
                              dishes.clear();
                            });
                          },
                          contentPadding:
                              const EdgeInsets.only(left: 20, right: 10),
                          title: Text(dishes[index].title),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              (showFoodItems)
                  ? FutureBuilder(
                      future: RecipeServices().getFoodItems(controller.text),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: shakaYellow,
                            ),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('Try correcting name'),
                          );
                        } else {
                          List<FoodItemModel>? checklist = snapshot.data;
                          if (checklist != null) {
                            for (var element in checklist) {
                              log(element.imageUrl);
                              log(element.title);
                              log(element.id.toString());
                            }
                          } else {
                            log('result is not as expected');
                          }
                          List<FoodItemModel>? list = snapshot.data;
                          foodItems.clear();
                          foodItems.addAll(list as List<FoodItemModel>);
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: height * 0.72,
                            ),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 6,
                                mainAxisExtent: 240,
                              ),
                              itemCount: foodItems.length,
                              itemBuilder: (context, index) {
                                final foodItem = foodItems[index];
                                log('foodItem ${foodItems.length}');
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShowRecipeInfo(
                                          showMissedIngredients: false,
                                          imageUrl: foodItem.imageUrl,
                                          title: foodItem.title,
                                          id: foodItem.id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: foodItemBox(context, foodItem.imageUrl,
                                      foodItem.title, foodItem.id),
                                );
                              },
                            ),
                          );
                        }
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
