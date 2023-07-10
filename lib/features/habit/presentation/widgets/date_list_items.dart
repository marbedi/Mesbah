import 'package:flutter/material.dart';
import 'package:mesbah/common/extensions/context.dart';
import 'package:mesbah/common/extensions/string.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DateListItem extends StatelessWidget {
  const DateListItem({
    super.key,
    required this.isSelected,
    required this.isToday,
    required this.day,
    required this.onTap,
  });

  final bool isSelected;
  final bool isToday;
  final Jalali day;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
          width: 70.0,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: isSelected || isToday
                  ? Border.all(color: context.colorScheme.primary)
                  : null,
              color: isSelected
                  ? context.colorScheme.primary.withOpacity(0.1)
                  : context.colorScheme.secondaryContainer),
          duration: const Duration(milliseconds: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                day.formatter.wN,
                style: context.textTheme.labelMedium!.copyWith(
                    fontSize: 13,
                    color: isSelected ? context.colorScheme.primary : null),
              ),
              Text(
                day.day.toString().toFarsiNumber(),
                style: context.textTheme.labelLarge!.copyWith(
                    fontSize: 14,
                    color: isSelected ? context.colorScheme.primary : null),
              ),
            ],
          )),
    );
  }
}
