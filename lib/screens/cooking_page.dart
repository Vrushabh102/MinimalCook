import 'package:flutter/material.dart';
import 'package:food_suggester/custom_widgets/cooking_step_card.dart';
import 'package:food_suggester/models/cooking_steps_model.dart';

class CookingPage extends StatelessWidget {
  const CookingPage({super.key, required this.model});

  final List<CookingStepsModel> model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: model.length,
        itemBuilder: (context, index) {
          return StepCard(
            height: MediaQuery.of(context).size.height,
            number: model[index].number,
            instructions: model[index].instructions,
            equipmentsImageUrl: model[index].equipment,
            ingredientsImageUrl: model[index].ingredients,
          );
        },
      ),
    );
  }
}
