import 'package:flutter/material.dart';
import 'package:viez/core/ui/widgets/app_banner_version.dart';
import 'package:viez/core/utils/app_const.dart';
import 'package:viez/generated/l10n.dart';

class OnboardingIntroPageBody extends StatefulWidget {
  const OnboardingIntroPageBody({Key? key, required this.setPageContent})
      : super(key: key);

  final Function(bool active, bool acceptedDataCollection) setPageContent;

  @override
  State<OnboardingIntroPageBody> createState() =>
      _OnboardingIntroPageBodyState();
}

class _OnboardingIntroPageBodyState extends State<OnboardingIntroPageBody> {
  bool _acceptedPolicy = false;
  bool _acceptedDataCollection = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppConst.getVersionNumber(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AppBannerVersion(
                    versionNumber: snapshot.requireData,
                  ),
                  const SizedBox(height: 32.0),
                  Text(
                    S.of(context).appDescription,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.deepPurple),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32.0),
                  Text(
                    S.of(context).onboardingIntroDescription,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.teal),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  _customCheckboxTile(
                    context,
                    onTap: _togglePolicy,
                    title: Text.rich(
                      TextSpan(
                        text: S.of(context).readLabel,
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(
                            text: ' ${S.of(context).privacyPolicyLabel}',
                            style: const TextStyle(
                              color: Colors.orange,
                              decoration: TextDecoration.underline,
                            ),
                            // Add your recognizer here
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    value: _acceptedPolicy,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _customCheckboxTile(BuildContext context,
      {required Function() onTap,
        required Widget title,
        required bool value}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (val) => onTap(),
            activeColor: Colors.pink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Expanded(child: title),
        ],
      ),
    );
  }

  void _togglePolicy() {
    setState(() {
      _acceptedPolicy = !_acceptedPolicy;
      widget.setPageContent(_acceptedPolicy, _acceptedDataCollection);
    });
  }

  void _toggleDataCollection() {
    setState(() {
      _acceptedDataCollection = !_acceptedDataCollection;
      widget.setPageContent(_acceptedPolicy, _acceptedDataCollection);
    });
  }
}
