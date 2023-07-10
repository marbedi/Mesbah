import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mesbah/features/habit/domain/entities/category_entity.dart';
import 'package:mesbah/features/habit/domain/entities/habit_source.dart';

import '../../features/habit/domain/entities/habit_entity.dart';
import '../../features/habit/domain/entities/reminder.dart';
import '../gen/assets.gen.dart';

const String _hygieneId = '0';
const String _healthId = '1';
const String _nutritionId = '1.1';
const String _sleepId = '1.2';

const String _fitnessId = '1.3';
const String _work = '2';
const String _job = '2.1';
const String _education = '2.2';
const String _skill = '2.3';
const String _relationships = '3';
const String _withGod = '3.1';
const String _withYourself = '3.2';
const String _withOther = '3.3';
const String _withEnvironment = '3.4';
const String _entertainment = '4';

class Constants {
  static const String habitsKey = 'habits';
  // ids

  //id
  static final defaultHabits = [
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _nutritionId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'قبل از صبحانه ساعت 4 صبح',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 7,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
        dayStep: 1,
      ),
      title: 'ناشتا',
      longDesc:
          'امام صاق (علیه السلام) فرمودند: هرگاه نماز صبح خواندی اندکی غذا بخور تا دهانت خوشبو، حرارتت خاموش، دندانها و لثه ات محکم، روزی ات جلب و اخلاقت نیکو گردد. [الدعوات، ص 140]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      categoryId: _nutritionId,
      isDefault: true, // in hatman baiad true bashe
      //  score: 0, // agar score nadarad score ro nanevisid
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 41,
      isPublic: false,
      period: Period(
          periodType: PeriodType.everyDay,
          dayStep: 3,
          weekDays: [1, 2, 3, 4, 5, 6, 7] // hame roza
          ),
      // period: Period(
      // periodType: PeriodType.aFewDaysPerMonth,
      // dayStep: 3,
      // monthDays: [1, 2, 10,5, 6, 7]
      // ),
      title: 'شام',
      desc: 'هرشب ساعت 19',
      longDesc:
          'امام رضا (علیه السلام:) هیچ یک از شما شام خوردن را ترک نکند؛ هرچند به اندازه ی لقمه ای نان یا جرعه ای آب باشد.  [کافی، ج6، ص289] ',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
      // agar goal nadard niaz be neveshtan nist
    ),
    HabitEntity(
      id: generateRandomId(10),
      categoryId: _nutritionId,
      isDefault: true, // in hatman baiad true bashe
      //  score: 0, // agar score nadarad score ro nanevisid
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad

      startDate: DateTime.now(),
      icon: 66,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
        dayStep: 2,
      ),
      //  period: Period(
      // periodType: PeriodType.aFewDaysPerMonth,
      // dayStep: 3,
      // monthDays: [1, 2, 10,5, 6, 7]
      // ),
      title: 'استفاده ازسبزیجات',
      desc: 'همراه وعده های غذایی',
      longDesc:
          'امام رضا (علیه السلام) فرمودند: من از سفرهای که در آن سبزی نباشد غذا نمیخورم. [مکارمالاخلاق، ص176]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
      // agar goal nadard niaz be neveshtan nist
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _nutritionId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: '',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 34,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
        dayStep: 1,
      ),
      title: 'پرخوری نکردن',
      longDesc:
          'رسول خدا (صلی الله علیه و آله) فرمود: دلهایتان را با پرخوری و پرنوشی نمیرانید؛ زیرا دلها مانند زراعتند که آب بسیار آنها را نابود میکند. [مکارم الاخلاق، ص149]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _nutritionId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'هر روز صبح تا قبل ساعت 8',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 41,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
        dayStep: 1,
      ),
      title: 'صبحانه',
      longDesc:
          'امام علی (علیه السلام) فرمودند: هرکه جاودانگی میخواهد (و البته برای غیر خدا جاودانگی ای نیست) باید چاشت را زود بخورد... [الدعوات، ص75، ح176]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _sleepId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'ساعت 10 و نیم شب',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 10,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
        dayStep: 1,
      ),
      title: 'زود خوابیدن شب',
      longDesc:
          'بهترین زمان برای(شروع) خواب، بعد از نماز عشاء تا قبل از نیمه شب است',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _sleepId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: '5ونیم صبح',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 3,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
        dayStep: 1,
      ),
      title: 'سحرخیزی',
      longDesc:
          'پیامبر اکرم (صلّ الله علیه و آله) فرمودند: خفتن پس از نماز بامداد روزی را منع می کند',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _sleepId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: '5ونیم صبح',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 59,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
        dayStep: 1,
      ),
      title: 'نخوابیدن در ابتدای روز(بین الطلوعین)',
      longDesc:
          'امام صادق (علیه السلام) فرمود: خواب صبحگاهان شوم است. رزق را دور و رنگ چهره را زرد و زشت میکند. [بحارالانوار، ج86، ص129]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _sleepId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'ساعت 11 و نیم قبل از ظهر',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 3,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
        dayStep: 1,
      ),
      title: 'خواب قبل از ظهر(قیلوله)',
      longDesc:
          'پیامبر اکرم (صلّی الله علیه و آله و سلّم) فرمودند: خواب قیلوله نعمت است و نیکو یاوریست بر بیداری و عبادت شب. [حلیةالمتقین، ص170]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _sleepId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: '',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 3,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
        dayStep: 1,
      ),
      title: 'نخوابیدن قبل از غروب آفتاب',
      longDesc:
          'امام باقر (علیه السلام) فرمودند: ...خواب پس از عصر مایه ی حماقت و ابلهیست... [ من لا یحضره الفقیه، ج1، ص502]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _skill,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: '',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 28,
      isPublic: false,
      period: Period(
        periodType: PeriodType.aFewDaysPerWeek,
        weekDays: [DateTime.saturday, DateTime.monday, DateTime.wednesday],
      ),
      title: 'خوشنویسی',
      longDesc:
          'پیامبر اکرم (صل  الله علیه و آله و سلم) فرمودند: خط زیبا حق را بیشتر آشکار میکند',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _skill,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: '3 روز در هفته آموزش نظری',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 28,
      isPublic: false,
      period: Period(
          periodType: PeriodType.aFewDaysPerWeek,
          weekDays: [DateTime.sunday, DateTime.tuesday, DateTime.thursday]),
      title: 'تیراندازی',
      longDesc:
          'پیامبر اکرم (صل  الله علیه و آله و سل م) فرمودند: به فرزندانتان تیراندازی آموزش دهید',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _skill,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'هر جلسه 20 لغت',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 28,
      isPublic: false,
      period: Period(
          periodType: PeriodType.aFewDaysPerWeek,
          weekDays: [DateTime.sunday, DateTime.tuesday, DateTime.thursday]),
      title: 'یادگیری واژگان عربی',
      longDesc:
          'امام صادق (علیه السلام) فرمودند: عربی را فرابگیرید؛ زیرا کلامیست که خداوند به واسطه ی آن با مردم سخن گفته است [خصال، ج2، ص258]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _fitnessId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'هر صبح 30 دقیقه',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 55,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
      ),
      title: 'نرمش روزانه',
      longDesc: '',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _fitnessId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: '',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 73,
      isPublic: false,
      period: Period(
          periodType: PeriodType.aFewDaysPerWeek, weekDays: [DateTime.friday]),
      title: 'شنا کردن',
      longDesc:
          'در دستورات دینی نسبت به شنا و آموزش آن به فرزندان تاکید شده است',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _hygieneId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'دو مرتبه در روز',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 54,
      isPublic: false,
      period: Period(periodType: PeriodType.everyDay, dayStep: 2),
      title: 'شستن ظرف',
      longDesc:
          'امام صادق (علیه السلام) شستن ظرفها را یکی از عوامل جلب روزی بیان کرده اند. [خصال، ج1، ص54]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _hygieneId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'روزی سه مرتبه',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 54,
      isPublic: false,
      period: Period(periodType: PeriodType.everyDay, dayStep: 3),
      title: 'مسواک زدن',
      longDesc:
          'امام صادق (علیه السلام): برای هر چیزی یک نوع پاکیزگی هست و مسواک زدن موجب پاکیزگی دهان است. [من لا یحضره الفقیه، ج1، ص33]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _hygieneId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'حداقل دو مرتبه',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 54,
      isPublic: false,
      period: Period(
          periodType: PeriodType.aFewDaysPerWeek,
          weekDays: [DateTime.monday, DateTime.friday]),
      title: 'حمام',
      longDesc:
          'رسول خدا (صلٌی الله عیله و آله) میفرماید: حق خدا بر هر مسلمانی این است که در هر هفته (حداقل) یک بار سر و بدنش را شست و شو دهد. [الجامع الصغیر، ج1، ص579]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _hygieneId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'حداقل دو مرتبه',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 54,
      isPublic: false,
      period: Period(
          periodType: PeriodType.aFewDaysPerWeek, weekDays: [DateTime.friday]),
      title: 'جارو زدن',
      longDesc:
          'امام صادق (علیه السلام) جارو کردن آستانه ی خانه را یکی از عوامل جلب روزی بیان کرده اند. [وسائل الشیعه، ج5، ص318] ',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _hygieneId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: '',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 54,
      isPublic: false,
      period: Period(
          periodType: PeriodType.aFewDaysPerWeek,
          weekDays: [DateTime.monday, DateTime.friday]),
      title: 'شستن لباس',
      longDesc:
          'امیرالمؤمنین (علیه السلام): شستن لباسها غم و اندوه را میبرد. [خصال، ص612]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _hygieneId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: '',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 24,
      isPublic: false,
      period: Period(
          periodType: PeriodType.aFewDaysPerWeek, weekDays: [DateTime.friday]),
      title: 'اصلاح مو',
      longDesc:
          'امام کاظم (علیه السلام): کوتاه کردن مو دیده را جلا می دهد و بر نور آن می افزاید. [بحارالانوار، ج74، ص85]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _hygieneId,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'دوشنبه یا جمعه هنگام روز',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 31,
      isPublic: false,
      period: Period(
          periodType: PeriodType.aFewDaysPerWeek, weekDays: [DateTime.friday]),
      title: 'ناخن گرفتن',
      longDesc:
          'رسول خدا (صلی الله علیه و آله) خطاب به آقایان فرمودند ناخنهایتان را بگیرید و به خانمها فرمودند ناخنهایتان را بلند بگذارید زیرا این برای شما زیباتر است. [کافی، ج6، ص491]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _withGod,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: '',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 43,
      isPublic: false,
      period: Period(periodType: PeriodType.everyDay, dayStep: 5),
      title: 'نماز اول وقت',
      longDesc:
          'امام صادق (علیه السلام) فرمودند: شیعیان ما را در اوقات نماز آزمایش کنید که چگونه بر خواندن نماز خود در موعد مقرر محافظت می کنند [بحارالانوار، ج65، ص149]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _withGod,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'تلاوت روزانه و مستمر قرآن کریم(روزی 50 آیه)',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 71,
      isPublic: false,
      period: Period(periodType: PeriodType.everyDay),
      habitGoal: const HabitGoal(
          goalType: GoalType.integer, totalStep: 1500, unit: 'آیه'),
      title: 'انس با قرآن',
      longDesc:
          'امام صادق (علیه السلام) فرمودند: قرآن عهد و فرمان خداوند با خلق خویش است؛ چه قدر شایسته است که مسلمان به فرمان آن گوش دهد و هر روز 50 آیه ی آن را بخواند [کافی، ج2، ص609]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _withGod,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'روزانه 10 دقیقه',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 51,
      isPublic: false,
      period: Period(periodType: PeriodType.everyDay),
      habitGoal: const HabitGoal(
          goalType: GoalType.integer, totalStep: 1500, unit: 'آیه'),
      title: 'انس با نهج البلاغه',
      longDesc:
          'با نهج البلاغه انس پیدا کنید؛ نهج البلاغه خیلی بیدارکننده و هوشیارکننده و خیلی قابل تدبر است',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _withGod,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'روزانه 10 دقیقه',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 6,
      isPublic: false,
      period: Period(periodType: PeriodType.everyDay),
      title: 'انس با صحیفه ی سجادیه',
      longDesc:
          'با صحیفه ی سجادیه مانوس شوید؛ پر از نغمه های معنوی است، دعا و درس است؛ هم درس اخلاق است، هم درس علم النفس است و هم درس امور اجتماعیست.',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _withYourself,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'حداقل سه روز در هفته',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 52,
      isPublic: false,
      period: Period(
          periodType: PeriodType.aFewDaysPerWeek,
          weekDays: [DateTime.sunday, DateTime.tuesday, DateTime.friday]),
      title: 'همکاری در امور منزل',
      longDesc:
          'کارهایی از قبیل همکاری در امور داخلی منزل مانند نظافت، جمع وسایل، نگهداری از فرزندان و... و امور بیرونی منزل مانند خرید که موجب تقویت حس مسئولیت پذیری در وجود انسان است.',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _withYourself,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'روزانه حداقل سه مرتبه',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 23,
      isPublic: false,
      period: Period(periodType: PeriodType.everyDay, dayStep: 3),
      title: 'شکرگزاری و سپاس',
      longDesc: 'هرکس تشکر کند از خودش تشکر کرده است [سوره لقمان آیه 12]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _withYourself,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'انجام ندادن حداقل یک گناه در روز',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 62,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
      ),
      title: 'تقوای فردی',
      longDesc:
          'امام علی (علیه السلام) فرمودند: هر روزی که در آن گناه نشود؛ همان روز، روز عید است. [مستدرک، ح6679]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _withOther,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'از بخشش کم شرمنده مباش؛ زیرا محروم ساختن از آن هم کمتر است',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 9,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
      ),
      title: 'صدقه',
      longDesc:
          'هر چیزی را که در راه خدا انفاق می کنید، خود خدا عوض آن را می دهد و او بهترین روزی دهندگان است [سوره سبأ آیه 39]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _withOther,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'فراهم آوردن امکاناتی که باعث خوشحالی خانواده می شود',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 13,
      isPublic: false,
      period: Period(
          periodType: PeriodType.aFewDaysPerWeek, weekDays: [DateTime.friday]),
      title: 'خوشحال کردن همسر و فرزندان',
      longDesc:
          'امیرالمژمنین (علیه السلام) فرمودند: ای کمیل! به خدا سوگند هر که دلی را شادمان سازد، خداوند برای او لطفی می آفریند و زمانی که مصیبتی به او می رسد، آن لطف همچون آبی به سوی او سرازیر می شود تا آن مصیبت را از بین ببرد [نهج البلاغه، حکمت257]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _withEnvironment,
      //score: 0, // agar score nadarad score ro nanevisid
      desc:
          'استفاده از وسایل نقلیه ی عمومی به جای وسیله ی نقلیه شخصی حداقل یک روز در هفته ',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 38,
      isPublic: false,
      period: Period(
          periodType: PeriodType.aFewDaysPerWeek, weekDays: [DateTime.tuesday]),
      title: 'روز بدون خودرو',
      longDesc:
          'امام صادق (علیه السلام) هوای پاک را به عنوان یکی از سه مؤلفه ی گوارا شدن زندگی بیان کرده اند [تحف العقول، ص320]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _withEnvironment,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'حداقل یک بار در ماه',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 12,
      isPublic: false,
      period: Period(periodType: PeriodType.aFewDaysPerMonth, monthDays: [1]),
      title: 'جمع آوری زباله از ظبیعت',
      longDesc:
          'پیامبر اکرم (صلّ الله علیه  و آله) برای کسی که چیز آزاردهنده ای را از راه مسلمانان بردارد، پاداشی بزرگ بیان کرده اند [بحارالانوار، ج75، ص50]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _entertainment,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'مطالعه روزانه حداقل 30 دقیقه',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 5,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
      ),
      title: 'کتابخوانی',
      longDesc:
          'امیرالمؤمنین (علیه السلام): کتاب ها بوستان های دانشمندانند [غررالحکم، ص245]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: true, // in hatman baiad true bashe
      categoryId: _entertainment,
      //score: 0, // agar score nadarad score ro nanevisid
      desc: 'حداکثر 1 ساعت و نیم در شبانه روز',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 63,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
      ),
      title: 'دنبال کردن فضای مجازی',
      longDesc: 'این کار باعث جلوگیری از اتلاف وقت و کنترل زمان بیشتر می شود',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
  ];

  static final fakeHabits = [
    HabitEntity(
      id: generateRandomId(10),
      isDefault: false, // in hatman baiad true bashe
      categoryId: _withGod,
      score: 50, // agar score nadarad score ro nanevisid
      desc: '',
      endDate: DateTime(1402, 4, 31),
      startDate: DateTime.now(),
      icon: 43,
      isPublic: false,
      period: Period(periodType: PeriodType.everyDay, dayStep: 5),
      title: 'نماز اول وقت',
      longDesc:
          'امام صادق (علیه السلام) فرمودند: شیعیان ما را در اوقات نماز آزمایش کنید که چگونه بر خواندن نماز خود در موعد مقرر محافظت می کنند [بحارالانوار، ج65، ص149]',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      isDefault: false, // in hatman baiad true bashe
      categoryId: _withGod,
      score: 0, // agar score nadarad score ro nanevisid
      desc: 'توضیحات',
      endDate: DateTime(1402, 4, 31),
      // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 5,
      isPublic: false,
      period: Period(periodType: PeriodType.everyDay, dayStep: 5),
      title: 'عادت اول',
      longDesc: 'توضیحات بلند',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
  ];
  static final habitSources = [
    HabitSource(
        link:
            'https://fapka.ir/products/33/%DA%A9%D8%AA%D8%A7%D8%A8-%D8%AA%D8%BA%D8%B0%DB%8C%D9%87-%D8%AF%D8%B1-%D8%B7%D8%A8-%D8%A7%DB%8C%D8%B1%D8%A7%D9%86%DB%8C-%D8%A7%D8%B3%D9%84%D8%A7%D9%85%DB%8C/',
        type: HabitSourceTypes.book,
        desc:
            'این کتاب از این منظر اطلاعرسانی در باب تغذیه با رعایت مزاج غذاها و تناسب آن با مزاج انسان ها، از خدمات بسیار ارزشمندی است که منجر به درمان و سلامت بشر می شود.',
        title: 'تغذیه در طب ایرانی اسلامی',
        categoryId: _nutritionId),
    HabitSource(
        link:
            'https://www.ghbook.ir/index.php?option=com_dbook&task=viewbook&book_id=16460&lang=fa',
        type: HabitSourceTypes.book,
        desc:
            'کتاب تاثیر تغذیه بر اخلاق نوشته رحمت پوریزدی است. این کتاب به تاثیر جسم بر روان میپردازد. کتاب تاثیر تغذیه بر اخلاق را انتشارات قدس قم برای مخاطبان علاقه مند به یک زندگی سالم منتشر کرده است',
        title: 'تاثیر تغذیه بر اخلاق',
        categoryId: _nutritionId),
    HabitSource(
        link: 'https://cafebazaar.ir/app/ir.maharansoft.nutritionfacts',
        desc:
            'برای تغذیه ی سالم باید بدونید که هر ماده ی غذایی چه مقدار انرژی یا کالری پروتئین، کربوهیدرات، چربی و ... دارد. با این اپلیکیشن میتونید ارزش غذایی مواد مختلف را ببینید و باهم مقایسه کنید',
        type: HabitSourceTypes.software,
        title: ' خواص و جدول ارزش غذایی',
        categoryId: _nutritionId),
    HabitSource(
        link: 'https://cafebazaar.ir/app/com.royal.Diet',
        desc:
            'یک نرم افزار کاربردی که حاوی مقالات، تحقیقات و مطالب آموزنده ی مفید تغذیه ایست. مطالب مختلفی به شما آموزش داده میشود و بایدها و نبایدهای تغذیه ای را یادآوری میکند.',
        type: HabitSourceTypes.software,
        title: ' دانستنیهای تغذیه',
        categoryId: _nutritionId),
    HabitSource(
        link:
            'https://attarkhone.com/%D8%AA%D8%BA%D8%B0%DB%8C%D9%87-%D8%B3%D8%A7%D9%84%D9%85/',
        desc: '',
        type: HabitSourceTypes.software,
        title: 'معیارهای تغذیه سالم چیست و چه اصولی در طب سنتی دارد؟',
        categoryId: _nutritionId),
    HabitSource(
        link:
            'https://taaghche.com/book/84206/%D8%B1%D8%A7%D8%B2%D9%87%D8%A7%DB%8C%DB%8C-%D8%AF%D8%B1%D8%A8%D8%A7%D8%B1%D9%87-%D8%AE%D9%88%D8%A7%D8%A8',
        desc:
            'اگر دوست دارید با پدیده عجیب خواب آشنا شوید و پاسخ پرسشهایتان را درباره خوابیدن و خواب دیدن بگیرید، این کتاب به شما کمک میکند.',
        type: HabitSourceTypes.book,
        title: 'رازهایی درباره خواب',
        categoryId: _sleepId),
    HabitSource(
        link: 'https://ketab.ir/book/51dc6b47-a0a8-4e9d-8a28-7b61c896cfb8',
        desc:
            'با توجه به این که هر انسانی تقریبا یک سوم عمر خود را در خواب میگذراند، اسلام برای آن نیز آداب و اعمال خاصی دارد. ',
        type: HabitSourceTypes.book,
        title: 'خواب از منظر قرآن روایات و علم پزشکی',
        categoryId: _sleepId),
    HabitSource(
        link:
            'http://ensani.ir/fa/article/69728/%D8%AE%D9%88%D8%A7%D8%A8-%D9%88-%D8%A7%D8%B3%D8%AA%D8%B1%D8%A7%D8%AD%D8%AA-%D8%AF%D8%B1-%D8%B3%DB%8C%D8%B1%D9%87-%D9%86%D8%A8%D9%88%D9%89-%D8%B5%D9%84%D9%89-%D8%A7%D9%84%D9%84%D9%87-%D8%B9%D9%84%DB%8C%D9%87-%D9%88%D8%A2%D9%84%D9%87-'
            '',
        desc:
            'درباره چگونگی و آداب خواب و استراحت پیامبر اکرم(صلی الله علیه وآله)روایات متعدد و متنوعی از طریق اهل بیت(علیهم السلام) و غیر آنان نقل شده است.',
        type: HabitSourceTypes.site,
        title: 'خواب و استراحت در سیره نبوی',
        categoryId: _sleepId),
    HabitSource(
        link:
            'https://taaghche.com/book/109054/%D9%85%D9%88%D9%84%D9%81%D9%87-%D9%87%D8%A7%DB%8C-%D8%A8%D9%87%D8%AF%D8%A7%D8%B4%D8%AA-%D9%88-%D8%B3%D9%84%D8%A7%D9%85%D8%AA-%D8%B1%D9%88%D8%A7%D9%86%DB%8C-%D8%AF%D8%B1-%D9%82%D8%B1%D8%A2%D9%86-%D9%88-%D8%B1%D9%88%D8%A7%DB%8C%D8%A7%D8%AA',
        desc:
            'یکی از محورهای ارزیابی سلامتی جوامع مختلف، بهداشت و سلامت روانی آن جامعه است. سلامت و بهداشت روانی نقش مهمی در تضمین پویایی و کارآمدی هر جامعه مفهوم سلامت روانی در واقع جنبه‌هایی از مفهوم کلی سلامت است.',
        type: HabitSourceTypes.book,
        title: 'مؤلفه های بهداشت و سلامت روانی در قرآن و روایات',
        categoryId: _hygieneId),
    HabitSource(
        link:
            'https://hawzah.net/fa/Magazine/View/3280/4365/35337/%D8%AC%D8%A7%DB%8C%DA%AF%D8%A7%D9%87-%D8%A8%D9%87%D8%AF%D8%A7%D8%B4%D8%AA-%D8%AF%D8%B1-%D8%A7%D8%B3%D9%84%D8%A7%D9%85',
        desc: '',
        type: HabitSourceTypes.site,
        title: 'مجموعه مطالب درباره انواع بهداشت با توجه به منابع دینی',
        categoryId: _hygieneId),
    HabitSource(
        link:
            'https://ensani.ir/fa/article/251041/%D8%A8%D9%87%D8%AF%D8%A7%D8%B4%D8%AA-%D8%A8%D8%B1%D8%A7%DB%8C-%D9%87%D9%85%D9%87-%D8%A8%D9%87%D8%AF%D8%A7%D8%B4%D8%AA-%D9%BE%D9%88%D8%B3%D8%AA-%D9%88-%D8%A7%D8%B3%D8%AA%D8%AD%D9%85%D8%A7%D9%85',
        desc: 'نوشته ی سید شفیع شکرایی',
        type: HabitSourceTypes.site,
        title: 'بهداشت برای همه/ بهداشت پوست و استحمام',
        categoryId: _hygieneId),
    HabitSource(
        link:
            'https://ensani.ir/fa/article/251739/%D8%A8%D9%87%D8%AF%D8%A7%D8%B4%D8%AA-%D8%A8%D8%B1%D8%A7%DB%8C-%D9%87%D9%85%D9%87-%D8%A8%D9%87%D8%AF%D8%A7%D8%B4%D8%AA-%D8%AF%D9%87%D8%A7%D9%86-%D9%88-%D8%AF%D9%86%D8%AF%D8%A7%D9%86',
        desc: 'نوشته ی منصور اشرفی',
        type: HabitSourceTypes.site,
        title: 'بهداشت دهان و دندان',
        categoryId: _hygieneId),
    HabitSource(
        link:
            'https://www.ketabrah.ir/%DA%A9%D8%AA%D8%A7%D8%A8-%DB%B2%DB%B0-%DA%AF%D8%A7%D9%85-%D8%A8%DB%8C-%D9%86%D8%B8%DB%8C%D8%B1-%D8%A8%D8%B1%D8%A7%DB%8C-%D9%85%D9%88%D9%81%D9%82%DB%8C%D8%AA-%D8%AF%D8%B1-%D8%AA%D8%AD%D8%B5%DB%8C%D9%84/book/21785',
        desc: 'نوشته ی نادر حاجی شمسائی',
        type: HabitSourceTypes.book,
        title: '20 گام بی نظیر برای موفقیت در تحصیل',
        categoryId: _education),
    HabitSource(
        link:
            'https://fidibo.com/book/97305-%D9%85%D9%88%D9%81%D9%82%DB%8C%D8%AA-%D8%AA%D8%AD%D8%B5%DB%8C%D9%84%DB%8C',
        desc: 'نوشته ی دکتر شکوفه موسوی',
        type: HabitSourceTypes.book,
        title: 'موفقیت تحصیلی برای دانش آموزان و دانشجویان',
        categoryId: _education),
    HabitSource(
        link: 'https://www.jmep.ir/article_100581.html',
        desc: 'نوشته ی سمیه مختار زاده بازرگانی و سعید علیزاده',
        type: HabitSourceTypes.site,
        title: 'بررسی عوامل مؤثر در گرایش انتخاب رشته تحصیلی در دانش‌آموزان',
        categoryId: _education),
    HabitSource(
        link:
            'https://yyjc.ir/book/%D8%AE%D8%B1%DB%8C%D8%AF-%DA%A9%D8%AA%D8%A7%D8%A8-%D8%B1%D9%88%D8%A7%D9%86%D8%B4%D9%86%D8%A7%D8%B3%DB%8C/%D8%AF%D8%A7%D9%86%D9%84%D9%88%D8%AF-%D8%B1%D8%A7%DB%8C%DA%AF%D8%A7%D9%86-%DA%A9%D8%AA%D8%A7%D8%A8-%D8%B4%D8%BA%D9%84-%D9%85%D9%88%D8%B1%D8%AF-%D8%B9%D9%84%D8%A7%D9%82%D9%87-pdf.html',
        desc: '',
        type: HabitSourceTypes.book,
        title: 'شغل مورد علاقه',
        categoryId: _job),
    HabitSource(
        link: 'https://esanj.ir/myers-briggs-type-indicator-mbti',
        desc: '',
        type: HabitSourceTypes.site,
        title: 'تست شخصیت شناسی MBTI',
        categoryId: _job),
    HabitSource(
        link: 'https://mostafaee.com/portfolio/holland-talent-test/',
        desc: '',
        type: HabitSourceTypes.site,
        title: 'تست هالند',
        categoryId: _job),
    HabitSource(
        link: 'https://jobinja.ir/',
        desc: 'یافتن مشاغل و حرفه های مختلف ماتناسب با نیازهای مخاطبان',
        type: HabitSourceTypes.site,
        title: 'سایت کاریابی جابینجا',
        categoryId: _job),
    HabitSource(
        link:
            'https://taaghche.com/book/111424/%D8%A7%D8%B2-%DA%86%DB%8C%D8%B2%DB%8C-%D9%86%D9%85%DB%8C-%D8%AA%D8%B1%D8%B3%DB%8C%D8%AF%D9%85',
        desc:
            'کتاب «از چیزی نمی‌ترسیدم»، زندگینامه‌ خودنوشت سردار سلیمانی است که توسط انتشارات مکتب حاج قاسم منتشر شده است. این کتاب که شامل دست‌نوشته‌های شخصی شهید سلیمانی از دوران کودکی و زندگی در روستای قنات ملک کرمان تا میانهٔ مبارزات انقلابی در سال ۵۷ است.',
        type: HabitSourceTypes.book,
        title: 'از چیزی نمی ترسیدم',
        categoryId: _entertainment),
    HabitSource(
        link:
            'https://fidibo.com/book/70915-%DA%A9%D8%AA%D8%A7%D8%A8-%D8%A8%DB%8C%D9%86%D9%88%D8%A7%DB%8C%D8%A7%D9%86',
        desc:
            'بینوایان نام زیباترین رمان نوشته شده به قلم ویکتور هوگو، نویسنده فرانسوی است که کتاب خود را برای اولین بار در سال 1862 منتشر کرد. کتاب بینوایان یکی از بزرگترین کتاب های جهان در قرن 19 بود و هنوز هم بعد از گذشت سال ها، همواره در لیست بهترین کتاب های دنیا قرار دارد.',
        type: HabitSourceTypes.book,
        title: 'بینوایان',
        categoryId: _entertainment),
    HabitSource(
        link:
            'https://taaghche.com/book/51895/%D8%A7%D9%86%D8%B3%D8%A7%D9%86-%DB%B2%DB%B5%DB%B0-%D8%B3%D8%A7%D9%84%D9%87-%D8%AD%D9%84%D9%82%D9%87-%D8%AF%D9%88%D9%85',
        desc:
            'کتاب انسان ۲۵۰ ساله بیانات مقام معظم رهبری درباره‌ی زندگی سیاسی و مبارزات ائمه‌ی معصومین (ع) می‌باشد.',
        type: HabitSourceTypes.book,
        title: 'انسان ۲۵۰ ساله',
        categoryId: _entertainment),
    HabitSource(
        link: 'http://cafebazaar.ir/app/?id=com.gunaystudio.khak&ref=share',
        desc:
            'یک بازی متفاوت و حرفه ای ایرانی در سبک بازی های اکشن می باشد با گرافیک واقع گرایانه و سبک بازی های جنگی به سرعت مورداستقبال گیمرهای ایرانی قرار گرفت. موضوع بازی روایت فرار دو دوست از اسارت داعشی هاست.',
        type: HabitSourceTypes.software,
        title: 'خاک',
        categoryId: _entertainment),
    HabitSource(
        link: 'http://cafebazaar.ir/app/?id=com.papata.grapes2&ref=share',
        desc:
            'یک بازی جدید ایرانی از سوی استودیو بازی سازی پاپاتا با محوریت قرار دادن جنگ تحمیلی و هشت سال دفاع مقدس است. این بازی قصد دارد با سوژه قرار دادن جنگ ایران و عراق گوشه ای از این دوران را در قالب یک بازی اندرویدی به تصویر بکشد.',
        type: HabitSourceTypes.software,
        title: 'هشتمین حمله',
        categoryId: _entertainment),
    HabitSource(
        link: 'http://cafebazaar.ir/app/?id=ir.masaf.mahdiyar&ref=share',
        desc:
            'در این بازی بچه ها با همکاری شخصیت اصلی بازی، موضوعات تربیتی را آموزش می بینند. این بازی می تواند در پیشرفت فرزندان شما بسیار مؤثر باشد.',
        type: HabitSourceTypes.software,
        title: 'مهدیار1',
        categoryId: _entertainment),
    HabitSource(
        link: 'http://cafebazaar.ir/app/?id=ir.masaf.mahdiyar2&ref=share',
        desc: '',
        type: HabitSourceTypes.software,
        title: 'مهدیار2',
        categoryId: _entertainment),
    HabitSource(
        link:
            'http://cafebazaar.ir/app/?id=ir.mahdiyarStudio.mahdiyar3&ref=share',
        desc: '',
        type: HabitSourceTypes.software,
        title: 'مهدیار3',
        categoryId: _entertainment),
  ];
  static final categoryList = [
    CategoryEntity(
      id: _hygieneId,
      name: 'hygiene'.tr(),
      icon: Assets.icons.bathtub.path,
    ),
    CategoryEntity(
        id: _healthId,
        name: 'health'.tr(),
        icon: Assets.icons.fitness.path,
        subCategory: [
          CategoryEntity(id: _nutritionId, name: 'nutrition'.tr()),
          CategoryEntity(id: _sleepId, name: 'sleep'.tr()),
          CategoryEntity(id: _fitnessId, name: 'sport'.tr()),
        ]),
    CategoryEntity(
        id: _work,
        name: 'work_effort'.tr(),
        icon: Assets.icons.workEffortIcon.path,
        subCategory: [
          CategoryEntity(id: _job, name: 'job'.tr()),
          CategoryEntity(id: _education, name: 'education'.tr()),
          CategoryEntity(id: _skill, name: 'skill'.tr()),
        ]),
    CategoryEntity(
        id: _relationships,
        name: 'relationships'.tr(),
        icon: Assets.icons.relationIcon.path,
        subCategory: [
          CategoryEntity(id: _withGod, name: 'with_god'.tr()),
          CategoryEntity(id: _withYourself, name: 'with_yourself'.tr()),
          CategoryEntity(id: _withOther, name: 'with_other'.tr()),
          CategoryEntity(id: _withEnvironment, name: 'with_environment'.tr()),
        ]),
    CategoryEntity(
      id: _entertainment,
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

  static final Map<String, dynamic> quranVerses = {
    "هَذَا بَيَانٌ لِلنَّاسِ وَهُدًى وَمَوْعِظَةٌ لِلْمُتَّقِينَ":
        "این [قرآن] برای مردم، بیانگر [حوادث و واقعیات] و برای پرهیزکاران، سراسر هدایت و اندرز است. (سوره آل عمران آیه 138)",
    "يَا أَيُّهَا الَّذِينَ آمَنُوا لِمَ تَقُولُونَ مَا لَا تَفْعَلُونَ. كَبُرَ مَقْتًا عِنْدَ اللَّهِ أَنْ تَقُولُوا مَا لَا تَفْعَلُونَ.":
        "ی مؤمنان! چرا چیزی را می گویید که خود عمل نمی کنید؟ نزد خدا به شدت موجب خشم است که چیزی را بگویید که خود عمل نمی کنید. (سوره صف آیه  2و3)",
    "يَا أَيُّهَا الَّذِينَ آمَنُوا لَا تُقَدِّمُوا بَيْنَ يَدَيِ اللَّهِ وَرَسُولِهِ وَاتَّقُوا اللَّهَ إِنَّ اللَّهَ سَمِيعٌ عَلِيمٌ":
        "ای اهل ایمان! بر خدا و پیامبرش [در هیچ امری از امور دین و دنیا و آخرت] پیشی مگیرید و از خدا پروا کنید که خدا شنوا و داناست. سوره (حجرات آیه )1",
    "قُلْ يَا عِبَادِيَ الَّذِينَ أَسْرَفُوا عَلَى أَنْفُسِهِمْ لَا تَقْنَطُوا مِنْ رَحْمَةِ اللَّهِ إِنَّ اللَّهَ يَغْفِرُ الذُّنُوبَ جَمِيعًا إِنَّهُ هُوَ الْغَفُورُ الرَّحِيمُ":
        "بگو: ای بندگان من که [با ارتکاب گناه] بر خود زیاده روی کردید! از رحمت خدا نومید نشوید، یقیناً خدا همه گناهان را می آمرزد؛ زیرا او بسیار آمرزنده و مهربان است.(سوره زمر آیه 53)",
    "يَا أَيُّهَا النَّاسُ أَنْتُمُ الْفُقَرَاءُ إِلَى اللَّهِ وَاللَّهُ هُوَ الْغَنِيُّ الْحَمِيدُ":
        "ای مردم! شمایید نیازمندان به خدا، و فقط خدا بی نیاز و ستوده است. سوره فاطر آیه 15",
    "يَا أَيُّهَا الَّذِينَ آمَنُوا اصْبِرُوا وَصَابِرُوا وَرَابِطُوا وَاتَّقُوا اللَّهَ لَعَلَّكُمْ تُفْلِحُونَ":
        "ای اهل ایمان! [در برابر حوادث] شکیبایی کنید، و دیگران را هم به شکیبایی وادارید، و با یکدیگر [چه در حال آسایش چه در بلا و گرفتاری] پیوند و ارتباط برقرار کنید و از خدا پروا نمایید تا رستگار شوید. (سوره آل عمران آیه 200)",
    "يَا بَنِي آدَمَ خُذُوا زِينَتَكُمْ عِنْدَ كُلِّ مَسْجِدٍ وَكُلُوا وَاشْرَبُوا وَلَا تُسْرِفُوا إِنَّهُ لَا يُحِبُّ الْمُسْرِفِينَ":
        "ای فرزندان آدم! [هنگام هر نماز و] در هر مسجدی، آرایش و زینتِ [مادی و معنوی خود را متناسب با آن عمل و مکان] همراه خود برگیرید، و بخورید و بیاشامید و اسراف نکنید؛ زیرا خدا اسراف کنندگان را دوست ندارد. (سوره اعراف آیه 31)",
    "قَالَ مُوسَى لِقَوْمِهِ اسْتَعِينُوا بِاللَّهِ وَاصْبِرُوا إِنَّ الْأَرْضَ لِلَّهِ يُورِثُهَا مَنْ يَشَاءُ مِنْ عِبَادِهِ وَالْعَاقِبَةُ لِلْمُتَّقِينَ":
        "موسی به قومش گفت: از خدا یاری بخواهید، و شکیبایی ورزید، یقیناً زمین در سیطره مالکیّت و فرمانروایی خداست، آن را به هر کس از بندگانش که بخواهد می بخشد، و سرانجام نیک، برای پرهیزکاران است. (سوره اعراف آیه 128)",
    "يَا أَيُّهَا الَّذِينَ آمَنُوا اسْتَعِينُوا بِالصَّبْرِ وَالصَّلَاةِ إِنَّ اللَّهَ مَعَ الصَّابِرِينَ":
        "ای اهل ایمان از صبر و نماز [برای حل مشکلات خود و پاک ماندن از آلودگی ها و رسیدن به رحمت حق] کمک بخواهید زیرا خدا با صابران است. (سوره بقره آیه 153)",
    "فَاذْكُرُونِي أَذْكُرْكُمْ وَاشْكُرُوا لِي وَلَا تَكْفُرُونِ":
        "پس مرا یاد کنید تا شما را یاد کنم و مرا سپاس گزارید و کفران نعمت نکنید. (سوره بقره آیه  152)",
    "يَا أَيُّهَا الرُّسُلُ كُلُوا مِنَ الطَّيِّبَاتِ وَاعْمَلُوا صَالِحًا إِنِّي بِمَا تَعْمَلُونَ عَلِيمٌ":
        "ای پیامبران! از خوردنی های پاکیزه بخورید و کار شایسته انجام دهید؛ مسلماً من به آنچه انجام می دهید، دانایم.(سوره مومنون آیه 5)",
    "يَا أَيُّهَا الَّذِينَ آمَنُوا عَلَيْكُمْ أَنْفُسَكُمْ لَا يَضُرُّكُمْ مَنْ ضَلَّ إِذَا اهْتَدَيْتُمْ إِلَى اللَّهِ مَرْجِعُكُمْ جَمِيعًا فَيُنَبِّئُكُمْ بِمَا كُنْتُمْ تَعْمَلُونَ":
        "ای اهل ایمان! مراقبِ [ایمان و ارزش های معنویِ] خود باشید؛ اگر شما هدایت یافتید، گمراهی کسی که گمراه شده به شما زیانی نمی رساند. بازگشت همه شما به سوی خداست؛ پس شما را از آنچه انجام می دادید، آگاه خواهد کرد. (سوره مائده آیه 10)",
    "يَا أَيُّهَا النَّاسُ اتَّقُوا رَبَّكُمْ وَاخْشَوْا يَوْمًا لَا يَجْزِي وَالِدٌ عَنْ وَلَدِهِ وَلَا مَوْلُودٌ هُوَ جَازٍ عَنْ وَالِدِهِ شَيْئًا إِنَّ وَعْدَ اللَّهِ حَقٌّ فَلَا تَغُرَّنَّكُمُ الْحَيَاةُ الدُّنْيَا وَلَا يَغُرَّنَّكُمْ بِاللَّهِ الْغَرُورُ":
        "ای مردم! از پروردگارتان پروا کنید، و بترسید از روزی که هیچ پدری چیزی [از عذاب دوزخ را] از فرزندش دفع نمی کند، و نه هیچ فرزندی دفع کننده چیزی از [عذاب] پدر خویش است. بی تردید وعده خدا حق است، پس زندگی دنیا شما را نفریبد، و مبادا شیطان شما را به [کرم و رحمت] خدا مغرور کند. (سوره لقمان آیه 3)",
    "يَا أَيُّهَا النَّاسُ إِنَّ وَعْدَ اللَّهِ حَقٌّ فَلَا تَغُرَّنَّكُمُ الْحَيَاةُ الدُّنْيَا وَلَا يَغُرَّنَّكُمْ بِاللَّهِ الْغَرُورُ":
        "ای مردم! بی تردید وعده خدا [درباره قیامت] حق است، پس این زندگی دنیا [ی زودگذر،] شما را نفریبد و شیطان فریبنده، شما را [به کرم] خدا مغرور نکند. (سوره فاطر آیه 5)"
  };
}
