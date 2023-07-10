import 'package:flutter/material.dart';
import 'package:mesbah/common/extensions/context.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CircleProgress extends StatelessWidget {
  const CircleProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });
  final int currentStep;
  final int totalSteps;
  @override
  Widget build(BuildContext context) {
    return CircularStepProgressIndicator(
      totalSteps: totalSteps,
      currentStep: currentStep,
      stepSize: 10,
      selectedColor: context.colorScheme.primary,
      unselectedColor: Colors.grey[100],
      padding: 0,
      width: 40,
      height: 40,
      child: CircleAvatar(
        backgroundColor:
            currentStep == 0 ? Colors.grey[400] : context.colorScheme.primary,
        child: currentStep == 0
            ? null
            : Icon(
                Icons.check,
                color: context.colorScheme.onPrimary,
                size: 12,
              ),
      ),
    );
  }
}
