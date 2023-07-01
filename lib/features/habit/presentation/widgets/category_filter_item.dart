import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';

import '../../domain/entities/category_entity.dart';

class CategoryFilterItem extends StatelessWidget {
  const CategoryFilterItem(
      {super.key,
      this.c,
      required this.onTap,
      required this.isSelected,
      this.text});

  final CategoryEntity? c;
  final Function()? onTap;
  final bool isSelected;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onTap: onTap,
        child: AnimatedContainer(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              color: isSelected
                  ? context.colorScheme.primary.withOpacity(0.1)
                  : Colors.white,
              border: !isSelected
                  ? null
                  : Border.all(color: context.colorScheme.primary),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1))
              ],
              borderRadius: BorderRadius.circular(30)),
          duration: const Duration(milliseconds: 200),
          child: Row(
            children: [
              if (c?.icon != null) ...[
                Image.asset(c!.icon!, width: 20, height: 20),
                const SizedBox(
                  width: 10,
                ),
              ],
              Text(
                text ?? c?.name ?? 'all'.tr(),
                style: context.textTheme.labelMedium!.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
