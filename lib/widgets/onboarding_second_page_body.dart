import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viez/generated/l10n.dart';

class OnboardingSecondPageBody extends StatefulWidget {
  final Function(bool active, double? selectedHeight, double? selectedWeight) setButtonContent;

  const OnboardingSecondPageBody({Key? key, required this.setButtonContent}) : super(key: key);

  @override
  State<OnboardingSecondPageBody> createState() => _OnboardingSecondPageBodyState();
}

class _OnboardingSecondPageBodyState extends State<OnboardingSecondPageBody> {
  final _heightFormKey = GlobalKey<FormState>();
  final _weightFormKey = GlobalKey<FormState>();
  double? _parsedHeight;
  double? _parsedWeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitle(S.of(context).heightLabel),
            _buildSubTitle(S.of(context).onboardingHeightQuestionSubtitle),
            const SizedBox(height: 16.0),
            _buildForm(_heightFormKey, 'cm', S.of(context).onboardingHeightExampleHint, validateHeight),
            const SizedBox(height: 32.0),
            _buildTitle(S.of(context).weightLabel),
            _buildSubTitle(S.of(context).onboardingWeightQuestionSubtitle),
            const SizedBox(height: 16.0),
            _buildForm(_weightFormKey, 'kg', S.of(context).onboardingWeightExampleHint, validateWeight),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange,
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

  Widget _buildForm(GlobalKey<FormState> formKey, String labelText, String hintText, String? Function(String?) validator) {
    return Form(
      key: formKey,
      child: TextFormField(
        onChanged: (text) => _onFormFieldChanged(formKey, text),
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          fillColor: Colors.lightBlue[50],
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.teal),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }

  void _onFormFieldChanged(GlobalKey<FormState> formKey, String text) {
    if (formKey.currentState!.validate()) {
      double? parsedValue = double.tryParse(text);
      if (formKey == _heightFormKey) {
        _parsedHeight = parsedValue;
      } else if (formKey == _weightFormKey) {
        _parsedWeight = parsedValue;
      }
      checkCorrectInput();
    }
  }

  String? validateHeight(String? value) {
    if (value == null) return S.of(context).onboardingWrongHeightLabel;
    if (value.isEmpty || !RegExp(r'^[0-9]').hasMatch(value)) {
      return S.of(context).onboardingWrongHeightLabel;
    } else {
      return null;
    }
  }

  String? validateWeight(String? value) {
    if (value == null) return S.of(context).onboardingWrongWeightLabel;
    if (value.isEmpty || !RegExp(r'^[0-9]').hasMatch(value)) {
      return S.of(context).onboardingWrongHeightLabel;
    } else {
      return null;
    }
  }

  void checkCorrectInput() {
    if (_parsedHeight != null && _parsedWeight != null) {
      widget.setButtonContent(true, _parsedHeight, _parsedWeight);
    } else {
      widget.setButtonContent(false, null, null);
    }
  }
}
