

import 'package:flutter/material.dart';

class MacroNutrientsView extends StatelessWidget {
  final double totalCarbsIntake;
  final double totalFatsIntake;
  final double totalProteinsIntake;
  final double totalCarbsGoal;
  final double totalFatsGoal;
  final double totalProteinsGoal;

  const MacroNutrientsView({
    Key? key,
    required this.totalCarbsIntake,
    required this.totalFatsIntake,
    required this.totalProteinsIntake,
    required this.totalCarbsGoal,
    required this.totalFatsGoal,
    required this.totalProteinsGoal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildMacroNutrientCard(context, 'Carbs', totalCarbsIntake, totalCarbsGoal),
        _buildMacroNutrientCard(context, 'Fats', totalFatsIntake, totalFatsGoal),
        _buildMacroNutrientCard(context, 'Proteins', totalProteinsIntake, totalProteinsGoal),
      ],
    );
  }

  Widget _buildMacroNutrientCard(BuildContext context, String nutrient, double intake, double goal) {
    return Expanded(
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(nutrient, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text('$intake g', style: Theme.of(context).textTheme.titleLarge),
              Text('/ $goal g', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
