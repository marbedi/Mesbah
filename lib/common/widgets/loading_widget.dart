import 'package:flutter/material.dart';
import 'package:mesbah/common/extensions/context.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: color ?? context.colorScheme.primary,
      size: 40,
    );
  }
}
