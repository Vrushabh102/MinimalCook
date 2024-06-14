import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:food_suggester/services/recipe_services.dart';
import 'package:food_suggester/styles/text_input_decoration.dart';

class SuggestFood extends StatefulWidget {
  const SuggestFood({super.key});

  @override
  State<SuggestFood> createState() => _SuggestFoodState();
}

class _SuggestFoodState extends State<SuggestFood> {
  final controller = TextEditingController();
  List<String> ingredients = [];
  bool isVisible = false;
  Uint8List? imageMemory;
  bool showImageOrNot = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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
                controller: controller,
                decoration: textInputDecoration('Select ingredients'),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      log(controller.text);
                      ingredients.add(controller.text);
                      controller.clear();
                    });
                    log(ingredients.length.toString());
                  }
                },
              ),
            ),
            (showImageOrNot)
                ? SizedBox(
                    height: height * 0.5,
                    child: Image.memory(imageMemory as Uint8List),
                  )
                : const CircularProgressIndicator()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showImage();
      }),
    );
  }

  showImage() async {
    Uint8List? image = await RecipeServices().getImage(664147);
    if (image != null) {
      setState(() {
        showImageOrNot = true;
        imageMemory = image;
      });
    }
  }
}
