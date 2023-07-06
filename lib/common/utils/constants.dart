import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/category_entity.dart';

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
      categoryId: _hygieneId,
      score: 0, // agar score nadarad score ro nanevisid
      desc: 'ascasc',
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad
      startDate: DateTime.now(),
      icon: 0,
      isPublic: false,
      period: Period(
        periodType: PeriodType.everyDay,
        dayStep: 1,
      ),
      title: 'title',
      longDesc: 'long desc',
      habitGoal: const HabitGoal(
          goalType: GoalType.integer, totalStep: 20, unit: 'km'),
    ),
    HabitEntity(
      id: generateRandomId(10),
      categoryId: _hygieneId,
      isDefault: true, // in hatman baiad true bashe
      //  score: 0, // agar score nadarad score ro nanevisid
      endDate: DateTime(1, 1, 1), // hatman be in shekl bayad bashad

      startDate: DateTime.now(),
      icon: 1,
      isPublic: false,
      period: Period(
          periodType: PeriodType.aFewDaysPerWeek,
          dayStep: 3,
          weekDays: [1, 2, 3, 4, 5, 6, 7] // hame roza
          ),
      title: 'title2',
      desc: 'asc',
      longDesc: 'long desc',
      // habitGoal: const HabitGoal(
      //     goalType: GoalType.integer, totalStep: 20, unit: 'km'),
      // agar goal nadard niaz be neveshtan nist
    ),
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
