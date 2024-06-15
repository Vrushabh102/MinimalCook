import 'package:flutter/material.dart';
import 'package:food_suggester/colors.dart';
import 'package:food_suggester/screens/search_recipes_page.dart';
import 'package:food_suggester/screens/suggest_food_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: width * 0.9,
              child: Image.asset('assets/images/fridge.png'),
            ),
            Column(
              children: [
                Container(
                  height: height * 0.09,
                  width: width * 0.82,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: shakaYellow,
                    ),
                    borderRadius: BorderRadius.circular(
                      40,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(0),
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).brightness == Brightness.light
                                ? lightBodyColor
                                : darkBodyColor)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecipesPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Get recipes',
                      style: TextStyle(
                          color: shakadarkerYellow,
                          fontSize: 15,
                          letterSpacing: 0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: height * 0.09,
                  width: width * 0.82,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                      backgroundColor: MaterialStatePropertyAll(shakaYellow),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuggestFood(),
                        ),
                      );
                    },
                    child: Text(
                      'Search Food with Ingredients',
                      style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : Colors.black,
                          fontSize: 15,
                          letterSpacing: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
