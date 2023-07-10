import 'package:flutter/material.dart';
import 'package:mesbah/common/extensions/context.dart';

class TitledWidget extends StatelessWidget {
  const TitledWidget({super.key, required this.child, required this.title});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.labelMedium,
        ),
        const SizedBox(
          height: 5,
        ),
        child
      ],
    );
  }
}
