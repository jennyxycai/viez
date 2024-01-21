import 'package:flutter/material.dart';
import 'package:viez/generated/l10n.dart';

class OnboardingOverviewPageBody extends StatelessWidget {
  final String calorieGoalDayString;
  final String carbsGoalString;
  final String fatGoalString;
  final String proteinGoalString;
  final Function(bool active) setButtonActive;
  final double? totalKcalCalculated;

  const OnboardingOverviewPageBody({
    Key? key,
    required this.setButtonActive,
    this.totalKcalCalculated,
    required this.calorieGoalDayString,
    required this.carbsGoalString,
    required this.fatGoalString,
    required this.proteinGoalString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).onboardingOverviewLabel,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16.0),
            _buildCalorieGoalCard(context, calorieGoalDayString),
            const SizedBox(height: 32.0),
            Text(S.of(context).onboardingYourMacrosGoalLabel,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16.0),
            _buildMacroGoalsRow(context, carbsGoalString, fatGoalString, proteinGoalString),
          ],
        ),
      ),
    );
  }

  Widget _buildCalorieGoalCard(BuildContext context, String calorieGoal) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text(
                calorieGoal,
                style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                S.of(context).onboardingKcalPerDayLabel,
                style: const TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMacroGoalsRow(BuildContext context, String carbs, String fat, String protein) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildMacroGoalCard(context, S.of(context).carbsLabel, carbs, Colors.orange),
        _buildMacroGoalCard(context, S.of(context).fatLabel, fat, Colors.blue),
        _buildMacroGoalCard(context, S.of(context).proteinLabel, protein, Colors.green),
      ],
    );
  }

  Widget _buildMacroGoalCard(BuildContext context, String label, String value, Color color) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text('$value g', style: TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.bold)),
              Text(label, style: TextStyle(fontSize: 16, color: color.withOpacity(0.7))),
            ],
          ),
        ),
      ),
    );
  }
}