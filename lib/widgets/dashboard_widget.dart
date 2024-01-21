import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:viez/widgets/macro_nutriments_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:viez/generated/l10n.dart';

class DashboardWidget extends StatefulWidget {
  final double totalKcalDaily;
  final double totalKcalLeft;
  final double totalKcalSupplied;
  final double totalKcalBurned;
  final double totalCarbsIntake;
  final double totalFatsIntake;
  final double totalProteinsIntake;
  final double totalCarbsGoal;
  final double totalFatsGoal;
  final double totalProteinsGoal;

  const DashboardWidget(
      {Key? key,
      required this.totalKcalSupplied,
      required this.totalKcalBurned,
      required this.totalKcalDaily,
      required this.totalKcalLeft,
      required this.totalCarbsIntake,
      required this.totalFatsIntake,
      required this.totalProteinsIntake,
      required this.totalCarbsGoal,
      required this.totalFatsGoal,
      required this.totalProteinsGoal})
      : super(key: key);

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  @override
  Widget build(BuildContext context) {
    double kcalLeftLabel = 0;
    double gaugeValue = 0;
    if (widget.totalKcalLeft > widget.totalKcalDaily) {
      kcalLeftLabel = widget.totalKcalDaily;
      gaugeValue = 0;
    } else if (widget.totalKcalLeft < 0) {
      kcalLeftLabel = 0;
      gaugeValue = 1;
    } else {
      kcalLeftLabel = widget.totalKcalLeft;
      gaugeValue = (widget.totalKcalDaily - widget.totalKcalLeft) /
          widget.totalKcalDaily;
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        shadowColor: Colors.deepPurple.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildCustomHeader(),
              const SizedBox(height: 20),
            CircularPercentIndicator(
              radius: 90.0,
              lineWidth: 13.0,
              animation: true,
              percent: gaugeValue,
              arcType: ArcType.FULL,
              progressColor: Theme.of(context).colorScheme.primary,
              arcBackgroundColor:
              Theme.of(context).colorScheme.primary.withAlpha(50),
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedFlipCounter(
                      duration: const Duration(milliseconds: 1000),
                      value: kcalLeftLabel.toInt(),
                      textStyle: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                          color:
                          Theme.of(context).colorScheme.onSurface,
                          letterSpacing: -1)),
                  Text(
                    S.of(context).kcalLeftLabel,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                        color:
                        Theme.of(context).colorScheme.onSurface),
                  )
                ],
              ),
              circularStrokeCap: CircularStrokeCap.round,
            ),
              const SizedBox(height: 20),
              MacroNutrientsView(
                totalCarbsIntake: widget.totalCarbsIntake,
                totalFatsIntake: widget.totalFatsIntake,
                totalProteinsIntake: widget.totalProteinsIntake,
                totalCarbsGoal: widget.totalCarbsGoal,
                totalFatsGoal: widget.totalFatsGoal,
                totalProteinsGoal: widget.totalProteinsGoal,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildCustomHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildKcalInfo('Supplied', widget.totalKcalSupplied, Icons.arrow_upward),
        _buildKcalInfo('Burned', widget.totalKcalBurned, Icons.arrow_downward),
      ],
    );
  }

  Widget _buildKcalInfo(String label, double value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        Text('$value kcal', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label),
      ],
    );
  }

  Widget _buildCircularProgressIndicator(BuildContext context, double value, double label) {
    return CircularPercentIndicator(
      radius: 100.0,
      lineWidth: 15.0,
      percent: value,
      center: Text(
        '$label kcal left',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      progressColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
