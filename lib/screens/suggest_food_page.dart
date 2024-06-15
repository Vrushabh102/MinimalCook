import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_suggester/colors.dart';
import 'package:food_suggester/screens/suggested_recipes_page.dart';
import 'package:food_suggester/styles/text_input_decoration.dart';

class SuggestFood extends StatefulWidget {
  const SuggestFood({super.key});

  @override
  State<SuggestFood> createState() => _SuggestFoodState();
}

class _SuggestFoodState extends State<SuggestFood> {
  final controller = TextEditingController();
  final List<String> ingredients = [];
  bool showWarning = false;
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 25, top: 30),
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
                      'by ingredients',
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
                  cursorColor: shakaYellow,
                  controller: controller,
                  decoration: ingredientsInputDecoration(
                      'Enter ingredients ex: milk,sugar'),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        log(controller.text);
                        ingredients.add(controller.text);
                        controller.clear();
                        checkToShowRecipesOrnot();
                        if (ingredients.length >= 4) {
                          showWarning = false;
                        }
                      });
                      log(ingredients.length.toString());
                    }
                  },
                ),
              ),
              (ingredients.isNotEmpty)
                  ? Center(
                      child: Container(
                        width: width * 0.9,
                        margin: const EdgeInsets.only(
                          top: 20,
                        ),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: dynamicIngredients(),
                      ),
                    )
                  : const SizedBox(),
              (showWarning)
                  ? const Center(
                      child: Text('Please enter aleast 5 ingredients'))
                  : const SizedBox()
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: width * 0.9,
        child: FloatingActionButton(
            backgroundColor: shakaYellow,
            onPressed: () {
              checkToShowRecipesOrnot();
              if (ingredients.length >= 5) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SuggestedRecipes(ingredients: ingredients);
                  },
                ));
              }
            },
            child: const Text(
              'Show Recipes',
              style: TextStyle(color: shakaBlue),
            )),
      ),
    );
  }

  Wrap dynamicIngredients() {
    return Wrap(
      runSpacing: 6,
      spacing: 6,
      children: List.generate(
        ingredients.length,
        (index) => Chip(
          color: MaterialStatePropertyAll(
            Theme.of(context).brightness == Brightness.light
                ? lightBodyColor
                : darkBodyColor,
          ),
          label: Text(ingredients[index]),
          onDeleted: () {
            setState(() {
              ingredients.removeAt(index);
            });
          },
        ),
      ),
    );
  }

  void checkToShowRecipesOrnot() {
    if (ingredients.length <= 4) {
      setState(() {
        showWarning = true;
      });
    }
  }
}
