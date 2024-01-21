import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:viez/entity/user_gender_selection_entity.dart';
import 'package:viez/generated/l10n.dart';

class OnboardingFirstPageBody extends StatefulWidget {
  final Function(bool active, UserGenderSelectionEntity? gender, DateTime? birthday) setPageContent;

  const OnboardingFirstPageBody({Key? key, required this.setPageContent}) : super(key: key);

  @override
  State<OnboardingFirstPageBody> createState() => _OnboardingFirstPageBodyState();
}

class _OnboardingFirstPageBodyState extends State<OnboardingFirstPageBody> {
  final _dateInput = TextEditingController();
  DateTime? _selectedDate;

  bool _maleSelected = false;
  bool _femaleSelected = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(S.of(context).genderLabel),
            _buildSubTitle(S.of(context).onboardingGenderQuestionSubtitle),
            const SizedBox(height: 16.0),
            _buildGenderChoiceChips(),
            const SizedBox(height: 32.0),
            _buildSectionTitle(S.of(context).ageLabel),
            _buildSubTitle(S.of(context).onboardingBirthdayQuestionSubtitle),
            const SizedBox(height: 16.0),
            _buildDateFormField(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  Widget _buildSubTitle(String subtitle) {
    return Text(
      subtitle,
      style: const TextStyle(
        fontSize: 16,
        fontStyle: FontStyle.italic,
        color: Colors.teal,
      ),
    );
  }

  Widget _buildGenderChoiceChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ChoiceChip(
          label: Text(S.of(context).genderMaleLabel),
          selected: _maleSelected,
          onSelected: (bool selected) => _selectGender(UserGenderSelectionEntity.genderMale),
          backgroundColor: Colors.blueGrey[100],
          selectedColor: Colors.blue,
          labelStyle: TextStyle(color: _maleSelected ? Colors.white : Colors.black),
        ),
        ChoiceChip(
          label: Text(S.of(context).genderFemaleLabel),
          selected: _femaleSelected,
          onSelected: (bool selected) => _selectGender(UserGenderSelectionEntity.genderFemale),
          backgroundColor: Colors.pink[100],
          selectedColor: Colors.pink,
          labelStyle: TextStyle(color: _femaleSelected ? Colors.white : Colors.black),
        ),
      ],
    );
  }

  Widget _buildDateFormField() {
    return TextFormField(
      controller: _dateInput,
      readOnly: true,
      decoration: InputDecoration(
        hintText: S.of(context).onboardingEnterBirthdayLabel,
        labelText: S.of(context).onboardingEnterBirthdayLabel,
        prefixIcon: const Icon(Icons.calendar_today, color: Colors.deepPurple),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onTap: onDateInputClicked,
    );
  }

  void _selectGender(UserGenderSelectionEntity gender) {
    setState(() {
      _maleSelected = gender == UserGenderSelectionEntity.genderMale;
      _femaleSelected = gender == UserGenderSelectionEntity.genderFemale;
      checkCorrectInput();
    });
  }

  void onDateInputClicked() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _selectedDate = pickedDate;
        _dateInput.text = formattedDate;
        checkCorrectInput();
      });
    }
  }

  void checkCorrectInput() {
    UserGenderSelectionEntity? selectedGender;
    if (_maleSelected) {
      selectedGender = UserGenderSelectionEntity.genderMale;
    } else if (_femaleSelected) {
      selectedGender = UserGenderSelectionEntity.genderFemale;
    }

    if (selectedGender != null && _selectedDate != null) {
      widget.setPageContent(true, selectedGender, _selectedDate);
    } else {
      widget.setPageContent(false, null, null);
    }
  }
}
