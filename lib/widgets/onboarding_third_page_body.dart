import 'package:flutter/material.dart';
import 'package:viez/core/ui/widgets/info_dialog.dart';
import 'package:viez/entity/user_activity_selection_entity.dart';
import 'package:viez/generated/l10n.dart';

class OnboardingThirdPageBody extends StatefulWidget {
  final Function(bool active, UserActivitySelectionEntity? selectedActivity)
      setButtonContent;

  const OnboardingThirdPageBody({Key? key, required this.setButtonContent})
      : super(key: key);

  @override
  State<OnboardingThirdPageBody> createState() =>
      _OnboardingThirdPageBodyState();
}

class _OnboardingThirdPageBodyState extends State<OnboardingThirdPageBody> {
  bool _sedentarySelected = false;
  bool _lowActiveSelected = false;
  bool _activeSelected = false;
  bool _veryActiveSelected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitle(S.of(context).activityLabel),
            _buildSubTitle(S.of(context).onboardingActivityQuestionSubtitle),
            const SizedBox(height: 16.0),
            _buildChoiceChipRow(
              label: S.of(context).palSedentaryLabel,
              isSelected: _sedentarySelected,
              onTap: () => _setSelectedChoiceChip(sedentary: true),
              description: S.of(context).palSedentaryDescriptionLabel,
            ),
            _buildChoiceChipRow(
              label: S.of(context).palLowLActiveLabel,
              isSelected: _lowActiveSelected,
              onTap: () => _setSelectedChoiceChip(lowActive: true),
              description: S.of(context).palLowActiveDescriptionLabel,
            ),
            _buildChoiceChipRow(
              label: S.of(context).palActiveLabel,
              isSelected: _activeSelected,
              onTap: () => _setSelectedChoiceChip(active: true),
              description: S.of(context).palActiveDescriptionLabel,
            ),
            _buildChoiceChipRow(
              label: S.of(context).palVeryActiveLabel,
              isSelected: _veryActiveSelected,
              onTap: () => _setSelectedChoiceChip(veryActive: true),
              description: S.of(context).palVeryActiveDescriptionLabel,
            ),
            // Repeat for other activity levels
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
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

  Widget _buildChoiceChipRow({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ChoiceChip(
            label: Text(
              label,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                onTap();
                checkCorrectInput();
              });
            },
            backgroundColor: Colors.grey[300],
            selectedColor: Colors.green,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.orange),
            onPressed: () => _showInfoDialog(context, label, description),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (context) => InfoDialog(title: title, body: body),
    );
  }
  void _setSelectedChoiceChip(
      {sedentary = false,
      lowActive = false,
      active = false,
      veryActive = false}) {
    _sedentarySelected = sedentary;
    _lowActiveSelected = lowActive;
    _activeSelected = active;
    _veryActiveSelected = veryActive;
  }

  void checkCorrectInput() {
    UserActivitySelectionEntity? selectedActivity;
    if (_sedentarySelected) {
      selectedActivity = UserActivitySelectionEntity.sedentary;
    } else if (_lowActiveSelected) {
      selectedActivity = UserActivitySelectionEntity.lowActive;
    } else if (_activeSelected) {
      selectedActivity = UserActivitySelectionEntity.active;
    } else if (_veryActiveSelected) {
      selectedActivity = UserActivitySelectionEntity.veryActive;
    }

    if (selectedActivity != null) {
      widget.setButtonContent(true, selectedActivity);
    } else {
      widget.setButtonContent(false, null);
    }
  }
}
