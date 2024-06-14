import 'package:flutter/material.dart';
import 'package:food_suggester/custom_widgets/item_image_card.dart';
import 'package:food_suggester/models/cooking_steps_model.dart';

class StepCard extends StatelessWidget {
  const StepCard({
    super.key,
    required this.number,
    required this.height,
    required this.instructions,
    required this.equipmentsImageUrl,
    required this.ingredientsImageUrl,
  });
  final int number;
  final String instructions;
  final double height;
  final List<EquipmentForEachStepModel> equipmentsImageUrl;
  final List<IngredientsForEachStepModel> ingredientsImageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 18,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 18,
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlue[100],
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step $number:',
            style: const TextStyle(
              fontSize: 22.5,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: height * 0.3,
            ),
            child: SingleChildScrollView(
              child: Text(
                instructions,
                softWrap: true,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          (equipmentsImageUrl.isNotEmpty)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Equipments',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: height * 0.16,
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: equipmentsImageUrl.length,
                        itemBuilder: (context, index) {
                          return ImageCard(
                            imageUrl: equipmentsImageUrl[index].image,
                            name: equipmentsImageUrl[index].name,
                          );
                        },
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          (ingredientsImageUrl.isNotEmpty)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: height * 0.16,
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: ingredientsImageUrl.length,
                        itemBuilder: (context, index) {
                          return ImageCard(
                              imageUrl: ingredientsImageUrl[index].image,
                              name: ingredientsImageUrl[index].name);
                        },
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
