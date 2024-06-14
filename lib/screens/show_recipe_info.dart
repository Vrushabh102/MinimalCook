import 'dart:developer';

import 'package:food_suggester/colors.dart';
import 'package:food_suggester/custom_widgets/icon_info_container.dart';
import 'package:food_suggester/screens/cooking_page.dart';
import 'package:food_suggester/screens/ingredients.dart';
import 'package:food_suggester/services/recipe_services.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;
import 'package:flutter/material.dart';

class ShowRecipeInfo extends StatelessWidget {
  const ShowRecipeInfo({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.id,
  });
  final String imageUrl;
  final String title;
  final int id;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title and back button height 0.125
            SizedBox(
              // color: Colors.green,
              height: height * 0.125,
              width: width,

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Center(
                    child: SizedBox(
                      // color: Colors.amber,
                      // height: height * 0.1,
                      // width: width * 0.5,
                      width: width * 0.4,
                      child: Text(
                        title,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),

            // image
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.grey,
                  width: 2,
                ),
              ),
              height: height * 0.25,
              // width: width,
              // color: Colors.amber,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Expanded(
                      child: Center(
                          child: Text(
                    'Image Not found',
                    style: TextStyle(fontSize: 16),
                  )));
                },
              ),
            ),

            // Information
            FutureBuilder(
              future: RecipeServices().getRecipeInformation(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox();
                } else {
                  Map map = checkForFoodType(
                      snapshot.data!.vegan, snapshot.data!.vegetarian);
                  ImageIcon servesIcon =
                      checkForServings(snapshot.data!.servings);
                  return SizedBox(
                    height: height * 0.1,
                    width: width * 0.8,
                    // color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InfoContainerWithIcon(
                          data: '${snapshot.data!.readyInMinutes}min',
                          icon: const ImageIcon(
                              AssetImage('assets/icons/timer.png')),
                        ),
                        InfoContainerWithIcon(
                          data: 'serves${snapshot.data!.servings}',
                          icon: servesIcon,
                        ),
                        InfoContainerWithIcon(
                          data: map['type'],
                          icon: map['icon'],
                        ),
                      ],
                    ),
                  );
                }
              },
            ),

            // Summary
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: height * 0.22,
              ),
              child: FutureBuilder(
                future: RecipeServices().getSummaryById(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: shakaYellow,
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No Summary'),
                    );
                  } else {
                    log(snapshot.data.toString());
                    String plainSummary =
                        removeHtmlTags(snapshot.data.toString());
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Summary',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                plainSummary,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),

            // Ingredients
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder(
                    future: RecipeServices().getImage(id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text('No data'),
                        );
                      } else {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => IngredientsView(
                                          image: snapshot.data,
                                        )));
                          },
                          child: const Row(
                            children: [
                              Text(
                                'view all',
                                style: TextStyle(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline),
                              ),
                              Icon(Icons.arrow_forward_sharp)
                            ],
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
          height: 50,
          width: width * 0.9,
          child: FutureBuilder(
            future: RecipeServices().getCookingSetps(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data == null) {
                return Center(
                  child: FloatingActionButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back'),
                  ),
                );
              } else {
                return FloatingActionButton(
                  backgroundColor: shakaYellow,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CookingPage(model: snapshot.data!);
                        },
                      ),
                    );
                  },
                  child: const Text('Start cooking'),
                );
              }
            },
          )),
    );
  }

  String removeHtmlTags(String htmlText) {
    final dom.Document document = html_parser.parse(htmlText);

    // Use the document.body to get the text content without HTML tags
    return document.body?.text ?? '';
  }

  Map checkForFoodType(bool isVegan, bool isVeg) {
    if (isVegan) {
      return {
        'type': 'Vegan',
        'icon': const ImageIcon(
          color: Colors.green,
          AssetImage('assets/icons/vegan.png'),
        ),
      };
    } else if (isVeg) {
      return {
        'type': 'veg',
        'icon': const ImageIcon(
            color: Colors.green, AssetImage('assets/icons/veg.png')),
      };
    } else {
      return {
        'type': 'Non-veg',
        'icon': const ImageIcon(
            color: Colors.red, AssetImage('assets/icons/nonveg.png')),
      };
    }
  }

  ImageIcon checkForServings(int servings) {
    if (servings == 1) {
      return const ImageIcon(AssetImage('assets/icons/person.png'));
    } else if (servings == 2) {
      return const ImageIcon(AssetImage('assets/icons/two-person.png'));
    } else {
      return const ImageIcon(AssetImage('assets/icons/multi_person.png'));
    }
  }
}
