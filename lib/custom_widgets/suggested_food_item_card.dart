import 'package:flutter/material.dart';

class SuggestedFoodItemCard extends StatelessWidget {
  const SuggestedFoodItemCard({
    super.key,
    required this.title,
    required this.imageUrl,
    this.missedIngredientsCount,
    required this.id,
  });
  final String title;
  final String imageUrl;
  final int id;
  final int? missedIngredientsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.grey[800],
      ),
      child: Column(
        children: [
          ClipRRect(
            // height: height * 0.3,
            // width: width ,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                    height: 120,
                    child: Center(
                        child: Text(
                      'Image Not found',
                      style: TextStyle(fontSize: 16),
                    )));
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16, top: 7),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16),
                  ),
                  missedIngredientsCount != null
                      ? Text(
                          '$missedIngredientsCount missding ingredients',
                          style: const TextStyle(fontSize: 12),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
