import 'package:flutter/material.dart';
import 'package:viez/core/ui/widgets/dynamic_ont_logo.dart';
import 'package:viez/generated/l10n.dart';

class AppBannerVersion extends StatelessWidget {
  final String versionNumber;

  const AppBannerVersion({Key? key, required this.versionNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 70, child: DynamicOntLogo()),
        Text(S.of(context).appTitle,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.w600)),
        Text(
          S.of(context).appVersionName(versionNumber),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.7)),
        )
      ],
    );
  }
}
