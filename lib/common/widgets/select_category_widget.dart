import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../features/habit/presentation/widgets/category_filter_item.dart';
import '../utils/constants.dart';

class SelectCategoryWidget extends StatelessWidget {
  const SelectCategoryWidget(
      {super.key, required this.name, this.initial = 0, this.validator});
  final String name;
  final int initial;
  final String? Function(int?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<int>(
        initialValue: initial,
        validator: validator,
        builder: (field) => SizedBox(
              width: double.infinity,
              height: 40,
              child: ListView.builder(
                itemCount: Constants.categoryList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final isSelected = field.value == index;

                  final c = Constants.categoryList[index];
                  return CategoryFilterItem(
                    c: c,
                    isSelected: isSelected,
                    onTap: () {
                      field.didChange(index);
                    },
                  ).animate().fadeIn(delay: Duration(milliseconds: 50 * index));
                },
              ),
            ),
        name: name);
  }
}
