import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/extensions/string.dart';

class SelectMonthDayField extends StatelessWidget {
  const SelectMonthDayField(
      {super.key,
      required this.name,
      this.initialValue,
      this.validator,
      this.enable = true});
  final String name;
  final List<int>? initialValue;
  final String? Function(List<int>?)? validator;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<int>>(
        initialValue: initialValue,
        validator: validator,
        builder: (field) {
          return Column(
            children: [
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: List.generate(31, (index) => index + 1).map((e) {
                  final isSelected =
                      field.value?.any((val) => e == val) ?? false;

                  return SizedBox(
                    width: 40,
                    height: 40,
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onTap: enable
                            ? () {
                                final values = field.value;
                                field.didChange(isSelected
                                    ? values
                                        ?.where((element) => element != e)
                                        .toList()
                                    : [...values ?? [], e]);
                              }
                            : null,
                        child: Ink(
                          padding: const EdgeInsets.all(8),
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
                              e.toString().toFarsiNumber(),
                              style: context.textTheme.labelSmall!
                                  .copyWith(fontSize: 12),
                            ),
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
