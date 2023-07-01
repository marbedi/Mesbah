import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/extensions/string.dart';
import 'package:habit_tracker_moshtari/common/navigation/navigation_flow.dart';
import 'package:habit_tracker_moshtari/common/utils/constants.dart';
import 'package:habit_tracker_moshtari/common/widgets/titled_date_picker.dart';
import 'package:habit_tracker_moshtari/common/widgets/titled_dropdown.dart';
import 'package:habit_tracker_moshtari/common/widgets/titled_textfield.dart';
import 'package:habit_tracker_moshtari/common/widgets/titled_widget.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/reminder.dart';
import 'package:habit_tracker_moshtari/helper/validator.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/widgets/icon_pack_widget.dart';
import '../../../../common/widgets/select_category_widget.dart';
import '../../../../common/widgets/select_month_days_field.dart';
import '../../../../common/widgets/select_week_days_field.dart';
import '../widgets/category_filter_item.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({super.key, this.habit});
  final HabitEntity? habit;

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

final _formKey = GlobalKey<FormBuilderState>();

class _CreateHabitPageState extends State<CreateHabitPage> {
  final pageController = PageController(initialPage: 0);
  int currentPage = 0;
  String getTitle() {
    if (currentPage == 0) {
      return 'create_habit'.tr();
    }
    if (currentPage == 1) {
      return 'create_habit_page_2_title'.tr();
    }
    if (currentPage == 2) {
      return 'specific_goal'.tr();
    }
    if (currentPage == 3) {
      return 'reminder'.tr();
    }
    return 'create_habit'.tr();
  }

  final pages = [
    const _FirstPage(),
    _SecondPage(),
    _ThirdPage(),
    _FourthPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: null,
        leadingWidth: 0,
        centerTitle: true,
        title: FittedBox(
          child: Text(
            getTitle(),
            style: context.textTheme.labelMedium,
          ),
        ),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 140),
              child: ClipPath(
                  clipper: WaveClipperOne(reverse: true),
                  child: Container(
                    width: double.infinity,
                    color: context.colorScheme.primary.withOpacity(0.1),
                  )),
            ),
            Column(
              children: [
                Expanded(
                  child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: pages),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            if (currentPage == 0) {
                              NavigationFlow.back();
                              return;
                            }
                            pageController.animateToPage(currentPage - 1,
                                duration: 200.ms, curve: Curves.easeIn);
                            setState(() {
                              currentPage--;
                            });
                          },
                          child: Text('back'.tr(),
                              style: context.textTheme.labelMedium!)),
                      AnimatedSmoothIndicator(
                          // textDirection: TextDirection.ltr,
                          activeIndex: currentPage,
                          count: pages.length,
                          effect: ExpandingDotsEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              dotColor: Colors.grey[400]!,
                              activeDotColor: Colors.black)),
                      ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.saveAndValidate()) {
                              return;
                            }

                            if (currentPage == pages.length - 1) {
                              print(_formKey.currentState?.value);
                              return;
                            }
                            pageController.animateToPage(currentPage + 1,
                                duration: 200.ms, curve: Curves.easeIn);
                            setState(() {
                              currentPage++;
                            });
                          },
                          child: Text(
                            currentPage == pages.length - 1
                                ? 'save'.tr()
                                : 'next'.tr(),
                            style: context.textTheme.labelMedium!
                                .copyWith(color: context.colorScheme.onPrimary),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FourthPage extends StatefulWidget {
  const _FourthPage({super.key});

  @override
  State<_FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<_FourthPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: FormBuilderField<List<ReminderEntity>>(
        initialValue: [],
        builder: (field) => Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  trailing: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () async {
                      final time = await showPersianTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (time != null) {
                        field.value?.add(ReminderEntity(
                            time: time, days: [0, 1, 2, 3, 4, 5]));
                        field.didChange(field.value);
                      }
                    },
                    child: Ink(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colorScheme.primary),
                      child: Icon(
                        Icons.add,
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    'reminder_hint'.tr(),
                    style: context.textTheme.labelSmall,
                  ),
                  title: Text(
                    'reminder'.tr(),
                    style: context.textTheme.labelMedium,
                  )).animate().fadeIn(),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: field.value?.length ?? 0,
                    itemBuilder: (c, i) {
                      final r = field.value![i];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 3,
                                  offset: const Offset(0, 2))
                            ],
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  r.time.persianFormat(context).toFarsiNumber(),
                                  style: context.textTheme.labelMedium!
                                      .copyWith(fontSize: 15),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: SelectWeekDayField(
                                        smallSize: true,
                                        initialValue: r.days,
                                        name: 'reminder_week_days')),
                                Material(
                                  type: MaterialType.transparency,
                                  shape: const CircleBorder(),
                                  child: InkWell(
                                    customBorder: const CircleBorder(),
                                    onTap: () {
                                      if (field.value?.isNotEmpty ?? false) {
                                        field.value?.remove(r);
                                        field.didChange(field.value);
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }))
          ],
        ),
        name: 'reminders',
      ),
    );
  }
}

class _ThirdPage extends StatefulWidget {
  const _ThirdPage({
    super.key,
  });

  @override
  State<_ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<_ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          FormBuilderSwitch(
              initialValue: false,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
              name: 'goal',
              onChanged: (val) {
                setState(() {
                  _formKey.currentState?.save();
                });
              },
              activeColor: context.colorScheme.primary,
              contentPadding: EdgeInsets.zero,
              subtitle: Text(
                'specific_goal_desc'.tr(),
                style: context.textTheme.labelSmall,
              ),
              title: Text(
                'specific_goal'.tr(),
                style: context.textTheme.labelMedium,
              )).animate().fadeIn(),
          if (_formKey.currentState?.value['goal'] == true)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: TitledTextField(
                          title: 'goal'.tr(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: Validator.required(),
                          name: 'goal_value',
                          hint: '10'.toFarsiNumber())),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TitledTextField(
                          title: 'unit'.tr(),
                          name: 'unit',
                          validator: Validator.required(),
                          hint: 'unit_hint'.tr()))
                ],
              ),
            ).animate().fadeIn()
        ],
      ),
    );
  }
}

class _SecondPage extends StatefulWidget {
  const _SecondPage({
    super.key,
  });

  @override
  State<_SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<_SecondPage> {
  String periodToDropDownText(PeriodType p) {
    if (p == PeriodType.everyDay) {
      return 'every_day'.tr();
    }
    if (p == PeriodType.aFewDaysPerWeek) {
      return 'every_week'.tr();
    }
    if (p == PeriodType.aFewDaysPerMonth) {
      return 'every_month'.tr();
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        children: [
          TitledDropDown(
                  name: 'period',
                  title: '',
                  initial: PeriodType.everyDay,
                  onChanged: (val) {
                    setState(() {
                      _formKey.currentState!.save();
                    });
                  },
                  space: 0,
                  items: PeriodType.values
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(periodToDropDownText(e),
                              style: context.textTheme.labelMedium!
                                  .copyWith(fontSize: 15))))
                      .toList())
              .animate()
              .fadeIn(),
          const SizedBox(
            height: 10,
          ),
          if (_formKey.currentState!.value['period'] ==
              PeriodType.aFewDaysPerWeek) ...[
            TitledWidget(
              title: 'select_week_days_title'.tr(),
              child: SelectWeekDayField(
                name: 'week_day',
                validator: Validator.required(),
              ),
            ).animate().fadeIn(),
          ],
          if (_formKey.currentState!.value['period'] ==
              PeriodType.aFewDaysPerMonth)
            TitledWidget(
                title: 'select_week_days_title'.tr(),
                child: SelectMonthDayField(
                  name: 'month_day',
                  validator: Validator.required(),
                )).animate().fadeIn(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: FormBuilderCheckbox(
                    name: 'once_day',
                    initialValue: true,
                    onChanged: (val) {
                      setState(() {
                        _formKey.currentState!.save();
                      });
                    },
                    title: Text(
                      'once_day'.tr(),
                      style:
                          context.textTheme.labelMedium!.copyWith(fontSize: 14),
                    ),
                    subtitle: Text(
                      'once_day_desc'.tr(),
                      style:
                          context.textTheme.labelSmall!.copyWith(fontSize: 12),
                    )),
              ),
              if (_formKey.currentState!.value['once_day'] == false)
                Expanded(
                  child: FormBuilderDropdown(
                      name: 'several_times_day_count',
                      validator: Validator.required(),
                      decoration: InputDecoration(
                          errorStyle: context.textTheme.labelSmall!
                              .copyWith(fontSize: 12, color: Colors.red),
                          contentPadding: EdgeInsets.zero),
                      isDense: false,
                      items: List.generate(50, (index) => index)
                          .skip(2)
                          .toList()
                          .map((e) => DropdownMenuItem(
                              alignment: Alignment.center,
                              value: e,
                              child: Text(
                                e.toString().toFarsiNumber(),
                                textAlign: TextAlign.center,
                                style: context.textTheme.labelMedium,
                              )))
                          .toList()),
                )
            ],
          ).animate().fadeIn(delay: 150.ms)
        ],
      ),
    );
  }
}

class _FirstPage extends StatelessWidget {
  const _FirstPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children: [
            TitledTextField(
                    validator: Validator.required(),
                    title: 'name'.tr(),
                    name: 'name',
                    hint: 'name_field_hint'.tr())
                .animate()
                .fadeIn(),
            TitledTextField(
                    validator: Validator.required(),
                    title: 'detail'.tr(),
                    name: 'detail',
                    hint: 'detail_field_hint'.tr())
                .animate()
                .fadeIn(delay: 100.ms),
            Container(
              width: double.infinity,
              height: 150,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: context.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1), blurRadius: 2)
                  ]),
              child: const IconPackWidget(
                name: 'icon',
              ),
            ).animate().fadeIn(delay: 300.ms),
            TitledWidget(
              title: 'category'.tr(),
              child: SelectCategoryWidget(
                name: 'category',
                validator: Validator.required(),
              ),
            ).animate().fadeIn(delay: 350.ms),
            FormBuilderCheckbox(
                initialValue: true,
                subtitle: Text(
                  'public_desc'.tr(),
                  style: context.textTheme.labelSmall!.copyWith(fontSize: 12),
                ),
                name: 'public',
                title: Text(
                  'public_title'.tr(),
                  style: context.textTheme.labelMedium!.copyWith(fontSize: 15),
                )).animate().fadeIn(delay: 400.ms),
            Row(
              children: [
                Expanded(
                  child: TitledDatePickerWidget(
                      initialDate: DateTime.now(),
                      onChange: (d) {},
                      title: 'start_date'.tr(),
                      name: 'start_date'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TitledDatePickerWidget(
                      onChange: (d) {},
                      title: 'end_date'.tr(),
                      name: 'end_date'),
                )
              ],
            ).animate().fadeIn(delay: 500.ms),
          ],
        ));
  }
}
