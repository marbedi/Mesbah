import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/category_entity.dart';

import '../gen/assets.gen.dart';

class Constants {
  static const String habitsKey = 'habits';
  static final categoryList = [
    CategoryEntity(
      id: '0',
      name: 'hygiene'.tr(),
      icon: Assets.icons.bathtub.path,
    ),
    CategoryEntity(
        id: '1',
        name: 'health'.tr(),
        icon: Assets.icons.fitness.path,
        subCategory: [
          CategoryEntity(id: '1.1', name: 'nutrition'.tr()),
          CategoryEntity(id: '1.2', name: 'sleep'.tr()),
          CategoryEntity(id: '1.3', name: 'sport'.tr()),
        ]),
    CategoryEntity(
        id: '2',
        name: 'work_effort'.tr(),
        icon: Assets.icons.workEffortIcon.path,
        subCategory: [
          CategoryEntity(id: '2.1', name: 'job'.tr()),
          CategoryEntity(id: '2.2', name: 'education'.tr()),
          CategoryEntity(id: '2.3', name: 'skill'.tr()),
        ]),
    CategoryEntity(
        id: '3',
        name: 'relationships'.tr(),
        icon: Assets.icons.relationIcon.path,
        subCategory: [
          CategoryEntity(id: '3.1', name: 'with_god'.tr()),
          CategoryEntity(id: '3.2', name: 'with_yourself'.tr()),
          CategoryEntity(id: '3.3', name: 'with_other'.tr()),
          CategoryEntity(id: '3.4', name: 'with_environment'.tr()),
        ]),
    CategoryEntity(
      id: '4',
      icon: Assets.icons.television.path,
      name: 'entertainment'.tr(),
    ),
  ];

  static final List<Color> backgroundColors = [
    const Color(0xffB9BFD4),
    const Color(0xffA5C8E4),
    const Color(0xff9ABDB5),
    const Color(0xffDEA785),
    const Color(0xffF3EFEC),
    const Color(0xffC4C2B2)
  ];
  static final habitStatusFilter = [
    'all'.tr(),
    'doing'.tr(),
    'done'.tr(),
  ];
  static final habitIcons = [...Assets.icons.habit.values];
  static Color getRandomColor() {
    final random = Random();
    final randomIndex = random.nextInt(backgroundColors.length);
    return backgroundColors[randomIndex];
  }

  static final List<String> weekDays = [
    'saturday'.tr(),
    'sunday'.tr(),
    'monday'.tr(),
    'tuesday'.tr(),
    'wednesday'.tr(),
    'thursday'.tr(),
    'friday'.tr(),
  ];
}
