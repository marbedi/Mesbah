import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:mesbah/common/utils/constants.dart';
import 'package:mesbah/features/auth/domain/entities/user_entity.dart';
import 'package:lottie/lottie.dart';
import '../../../../common/extensions/context.dart';
import '../../../../common/gen/assets.gen.dart';
import '../../../../common/navigation/navigation_flow.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../bloc/habit_bloc_bloc.dart';
import '../bloc/online_habits_state.dart';
import '../bloc/online_habits_state.dart';
import '../widgets/category_filter_item.dart';
import '../widgets/habit_item.dart';
import '../widgets/my_habits_item.dart';
import '../widgets/online_habit_item.dart';
import '../widgets/search_bar.dart' as s;

class OnlineHabitsListPage extends StatefulWidget {
  const OnlineHabitsListPage({super.key});

  @override
  State<OnlineHabitsListPage> createState() => _OnlineHabitsListPageState();
}

class _OnlineHabitsListPageState extends State<OnlineHabitsListPage> {
  void refresh() {
    context.read<HabitBloc>().add(GetAllOnlineHabitsEvent());
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   leadingWidth: 30,
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   title: s.SearchBar(
      //     hasFilter: false,
      //     onFilter: () {
      //       showModalBottomSheet(
      //         shape: const RoundedRectangleBorder(
      //             borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(20),
      //                 topRight: Radius.circular(20))),
      //         context: context,
      //         builder: (context) {
      //           return _FilterBottomSheet(
      //               // filter: myHabitsListKey.currentState!.filter,
      //               // onFilter: (MyHabitsSearchFilterEntity f) {
      //               //   myHabitsListKey.currentState!.updateFilter(f);
      //               //   setState(() {});
      //               // },
      //               );
      //         },
      //       );
      //     },
      //     onSearch: (val) {
      //       // myHabitsListKey.currentState!.updateFilter(
      //       //     filter.copyWith(searchText: val.isEmpty ? null : val));
      //     },
      //   ),
      // ),
      body: BlocBuilder<HabitBloc, HabitBlocState>(
        builder: (context, state) {
          return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    floating: true,
                    leadingWidth: 0,
                    toolbarHeight: 70,
                    leading: const SizedBox(),
                    snap: true,
                    title: s.SearchBar(
                      hasFilter: false,
                      onFilter: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          context: context,
                          builder: (context) {
                            return const _FilterBottomSheet(
                                // filter: myHabitsListKey.currentState!.filter,
                                // onFilter: (MyHabitsSearchFilterEntity f) {
                                //   myHabitsListKey.currentState!.updateFilter(f);
                                //   setState(() {});
                                // },
                                );
                          },
                        );
                      },
                      onSearch: (val) {
                        // myHabitsListKey.currentState!.updateFilter(filter
                        //     .copyWith(searchText: val.isEmpty ? null : val));
                      },
                    ),
                  ),
                ];
              },
              body: ListView.builder(
                itemCount: Constants.defaultHabits.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      OnlineHabitItem(
                        habit: Constants.defaultHabits[index],
                        user: UserEntity(
                          follows: 1,
                          fullName: "مریم عابدی",
                          habits: [],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  );
                },
              ));
          //     if (state.onlineHabitsStates is OnlineHabitsLoading) {
          //       return const Center(child: LoadingWidget());
          //     }
          //     if (state.onlineHabitsStates is OnlineHabitsFailure) {
          //       return Center(
          //         child: Text(
          //           (state.onlineHabitsStates as OnlineHabitsFailure).message,
          //           style: context.textTheme.labelMedium,
          //         ),
          //       );
          //     }
          //     if (state.onlineHabitsStates is OnlineHabitsSuccess) {
          //       final habits =
          //           (state.onlineHabitsStates as OnlineHabitsSuccess).habits;
          //       if (habits.isEmpty) {
          //         return Center(
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Lottie.asset(Assets.animations.empty, height: 160),
          //               Text(
          //                 'empty_my_habit_list_message'.tr(),
          //                 style: context.textTheme.labelMedium,
          //               ),
          //             ],
          //           ),
          //         );
          //       }
          //       return RefreshIndicator(
          //           onRefresh: () async {
          //             refresh();
          //           },
          //           child: ListView.builder(
          //               padding: const EdgeInsets.only(top: 5),
          //               itemCount: habits.length,
          //               itemBuilder: (c, i) => MyHabitItem(
          //                     habit: habits[i],
          //                     onTap: () {
          //                       NavigationFlow.toHabitInfo(habits[i]);
          //                     },
          //                   )));
          //     }
          //     return const SizedBox();
        },
      ),
    );
  }
}

class _FilterBottomSheet extends StatefulWidget {
  const _FilterBottomSheet({
    super.key,
    // required this.filter,
    // required this.onFilter,
  });
  // final MyHabitsSearchFilterEntity filter;
  // final Function(MyHabitsSearchFilterEntity f) onFilter;
  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  // late MyHabitsSearchFilterEntity filter;
  @override
  void initState() {
    // filter = widget.filter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: ClipPath(
            clipper: WaveClipperOne(reverse: true),
            child: Container(
              width: double.infinity,
              height: 150,
              color: Constants.backgroundColors[2].withOpacity(0.1),
            ),
          ),
        ).animate().fadeIn(delay: 50.ms),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.filter_list),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'filters'.tr(),
                        style: context.textTheme.labelMedium!
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  ).animate().fadeIn(delay: 50.ms),
                  InkWell(
                    customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onTap: () {
                      setState(() {
                        // filter = MyHabitsSearchFilterEntity();
                      });
                    },
                    child: Text(
                      'remove_filter'.tr(),
                      style: context.textTheme.labelMedium!
                          .copyWith(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
              Text(
                'categories'.tr(),
                style: context.textTheme.labelMedium!.copyWith(fontSize: 14),
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ListView.builder(
                  itemCount: Constants.categoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final c = Constants.categoryList[index];

                    // final isSelected = filter.selectedCategory
                    //     .any((element) => element == c.id);
                    return CategoryFilterItem(
                            c: c,
                            isSelected: false,
                            onTap: () {
                              print("tap");
                            })
                        .animate()
                        .fadeIn(delay: Duration(milliseconds: 50 * index));
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Text(
              //   'habit_status'.tr(),
              //   style: context.textTheme.labelMedium!.copyWith(fontSize: 14),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(10),
              //     child: Row(
              //         mainAxisSize: MainAxisSize.min,
              //         children: Constants.habitStatusFilter.map((e) {
              //           // final isSelected = filter.selectedStatus ==
              //           //     Constants.habitStatusFilter.indexOf(e);
              //           return Expanded(
              //             child: InkWell(
              //               onTap: () {
              //                 setState(() {
              //                   // filter = filter.copyWith(
              //                   //     selectedStatus:
              //                   //         Constants.habitStatusFilter.indexOf(e));
              //                 });
              //               },
              //               child: AnimatedContainer(
              //                 decoration: const BoxDecoration(
              //                     // color: isSelected
              //                     //     ? context.colorScheme.primary
              //                     //         .withOpacity(0.1)
              //                     //     : context.colorScheme.surface,
              //                     ),
              //                 padding: const EdgeInsets.all(10),
              //                 duration: 500.ms,
              //                 child: Center(
              //                   child: Text(
              //                     e,
              //                     style: context.textTheme.labelMedium!
              //                         .copyWith(fontSize: 14),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ).animate().fadeIn(delay: 200.ms);
              //         }).toList()),
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      // widget.onFilter(filter);
                      NavigationFlow.back();
                    },
                    child: Text('apply'.tr(),
                        style: context.textTheme.labelMedium!.copyWith(
                            fontSize: 16,
                            color: context.colorScheme.onPrimary))),
              ).animate().fadeIn(delay: 150.ms)
            ],
          ),
        ),
      ],
    );
  }
}
