import 'package:flutter/material.dart';
import 'package:viez/entity/user_goal_selection_entity.dart';
import 'package:viez/generated/l10n.dart';

class OnboardingFourthPageBody extends StatefulWidget {
  final Function(bool active, UserGoalSelectionEntity? selectedGoal)
      setButtonContent;

  const OnboardingFourthPageBody({Key? key, required this.setButtonContent})
      : super(key: key);

  @override
  State<OnboardingFourthPageBody> createState() =>
      _OnboardingFourthPageBodyState();
}

class _OnboardingFourthPageBodyState extends State<OnboardingFourthPageBody> {
  bool _looseWeightSelected = false;
  bool _maintainWeightSelected = false;
  bool _gainWeightSelected = false;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle(S.of(context).goalLabel),
          _buildSubTitle(S.of(context).onboardingGoalQuestionSubtitle),
          const SizedBox(height: 16.0),
          _buildChoiceChip(
            label: S.of(context).goalLoseWeight,
            isSelected: _looseWeightSelected,
            onTap: () => _setSelectedChoiceChip(looseWeight: true),
            backgroundColor: Colors.purple[100],
            selectedColor: Colors.purple,
          ),
          _buildChoiceChip(
            label: S.of(context).goalMaintainWeight,
            isSelected: _maintainWeightSelected,
            onTap: () => _setSelectedChoiceChip(maintainWeight: true),
            backgroundColor: Colors.green[100],
            selectedColor: Colors.green,
          ),
          _buildChoiceChip(
            label: S.of(context).goalGainWeight,
            isSelected: _gainWeightSelected,
            onTap: () => _setSelectedChoiceChip(gainWeight: true),
            backgroundColor: Colors.orange[100],
            selectedColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubTitle(String subtitle) {
    return Text(
      subtitle,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.blueGrey,
        fontStyle: FontStyle.italic,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    Color? backgroundColor,
    Color? selectedColor,
  }) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          onTap();
          _checkCorrectInput();
        });
      },
      backgroundColor: backgroundColor ?? Colors.grey[300],
      selectedColor: selectedColor ?? Colors.blue,
    );
  }

  void _setSelectedChoiceChip({bool? looseWeight, bool? maintainWeight, bool? gainWeight}) {
    setState(() {
      if (looseWeight != null) {
        _looseWeightSelected = looseWeight;
        _maintainWeightSelected = !looseWeight;
        _gainWeightSelected = !looseWeight;
      }
      if (maintainWeight != null) {
        _maintainWeightSelected = maintainWeight;
        _looseWeightSelected = !maintainWeight;
        _gainWeightSelected = !maintainWeight;
      }
      if (gainWeight != null) {
        _gainWeightSelected = gainWeight;
        _looseWeightSelected = !gainWeight;
        _maintainWeightSelected = !gainWeight;
      }
      _checkCorrectInput();
    });
  }
  void _checkCorrectInput() {
    UserGoalSelectionEntity? selectedGoal;
    if (_looseWeightSelected) {
      selectedGoal = UserGoalSelectionEntity.loseWeight;
    } else if (_maintainWeightSelected) {
      selectedGoal = UserGoalSelectionEntity.maintainWeight;
    } else if (_gainWeightSelected) {
      selectedGoal = UserGoalSelectionEntity.gainWeigh;
    }

    if (selectedGoal != null) {
      widget.setButtonContent(true, selectedGoal);
    } else {
      widget.setButtonContent(false, null);
    }
  }
}
