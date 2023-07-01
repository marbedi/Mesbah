import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';

import '../utils/constants.dart';

class SelectWeekDayField extends StatelessWidget {
  const SelectWeekDayField({
    super.key,
    required this.name,
    this.validator,
    this.smallSize = false,
    this.initialValue = const [
      0,
      1,
      2,
      3,
      4,
    ],
  });
  final String name;
  final List<int> initialValue;
  final String? Function(List<int>?)? validator;
  final bool smallSize;
  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<int>>(
        initialValue: initialValue,
        validator: validator,
        builder: (field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: Constants.weekDays.map((e) {
                  final isSelected = field.value!
                      .any((val) => Constants.weekDays.indexOf(e) == val);

                  return Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onTap: () {
                        final values = field.value;
                        field.didChange(isSelected
                            ? values!
                                .where((element) =>
                                    element != Constants.weekDays.indexOf(e))
                                .toList()
                            : [...values!, Constants.weekDays.indexOf(e)]);
                      },
                      child: Ink(
                        width: smallSize ? 30 : null,
                        height: smallSize ? 30 : null,
                        padding: EdgeInsets.all(smallSize ? 0 : 8),
                        decoration: BoxDecoration(
                            border: isSelected
                                ? Border.all(
                                    color: context.colorScheme.primary,
                                    width: 1)
                                : null,
                            color: isSelected
                                ? context.colorScheme.primary.withOpacity(0.1)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            smallSize ? e.characters.first : e,
                            style: context.textTheme.labelSmall!
                                .copyWith(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              if (field.errorText != null)
                Text(
                  field.errorText ?? '',
                  style: context.textTheme.labelSmall!
                      .copyWith(color: Colors.red, fontSize: 12),
                )
            ],
          );
        },
        name: name);
  }
}
