import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';

import '../utils/constants.dart';

class IconPackWidget extends StatelessWidget {
  const IconPackWidget({super.key, required this.name, this.initialValue = 0});
  final String name;
  final int initialValue;
  @override
  Widget build(BuildContext context) {
    return FormBuilderField<int>(
      name: name,
      initialValue: initialValue,
      builder: (field) {
        return GridView.builder(
            itemCount: Constants.habitIcons.length,
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              final icon = Constants.habitIcons[index];
              final isSelected = field.value == index;
              return Material(
                type: MaterialType.transparency,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onTap: () {
                    field.didChange(index);
                  },
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                        color: isSelected
                            ? context.colorScheme.primary.withOpacity(0.2)
                            : null,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(8.0),
                    duration: 200.ms,
                    child: Image.asset(
                      icon.path,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
