import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';

class TitledDropDown<T> extends StatelessWidget {
  final String name;
  final String title;
  final T? initial;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged? onChanged;
  final Color? titleColor;
  final Color? outlineColor;
  final double? space;
  final double? outlineHeightSize;
  final double? titleSize;
  final bool isDense;
  final FormFieldValidator<T?>? validator;

  const TitledDropDown(
      {Key? key,
      required this.name,
      required this.title,
      required this.items,
      this.onChanged,
      this.initial,
      this.titleColor,
      this.outlineColor,
      this.space = 5,
      this.outlineHeightSize,
      this.validator,
      this.titleSize,
      this.isDense = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: context.textTheme.labelMedium),
        SizedBox(
          height: space,
        ),
        outlineHeightSize != null
            ? SizedBox(
                height: outlineHeightSize,
                child: FormBuilderDropdown(
                  initialValue: initial,
                  name: name,
                  items: items,
                  onChanged: onChanged,
                ),
              )
            : FormBuilderDropdown<T>(
                initialValue: initial,
                name: name,
                isDense: false,
                items: items,
                onChanged: onChanged,
                validator: validator,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                ),
              ),
      ],
    );
  }
}
