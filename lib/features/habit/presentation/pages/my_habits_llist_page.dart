import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/navigation/navigation_flow.dart';
import 'package:habit_tracker_moshtari/common/usecases/usecase.dart';
import 'package:habit_tracker_moshtari/common/utils/constants.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/category_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/usecases/get_all_habits_use_case.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/widgets/todo_habit_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../common/widgets/loading_widget.dart';
import '../../../../locator.dart';
import '../../domain/entities/my_habits_search_filter.dart';
import '../widgets/category_filter_item.dart';
import '../widgets/my_habits_item.dart';
import '../widgets/search_bar.dart' as s;

final myHabitsListKey = GlobalKey<_ListState>();

class MyHabitsListPage extends StatefulWidget {
  const MyHabitsListPage({super.key});

  @override
  State<MyHabitsListPage> createState() => _MyHabitsListPageState();
}

class _MyHabitsListPageState extends State<MyHabitsListPage> {
  @override
  Widget build(BuildContext context) {
    final filter =
        myHabitsListKey.currentState?.filter ?? MyHabitsSearchFilterEntity();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: context.colorScheme.primary,
          onPressed: () async {
            final created = await NavigationFlow.toCreateHabit();
            if (created != null && created) {
              myHabitsListKey.currentState?.refresh();
            }
          },
          child: Icon(
            Icons.add,
            color: context.colorScheme.onPrimary,
          ),
        ),
        body: NestedScrollView(
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
                    hasFilter: filter.hasFilter,
                    onFilter: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        context: context,
                        builder: (context) {
                          return _FilterBottomSheet(
                            filter: myHabitsListKey.currentState!.filter,
                            onFilter: (MyHabitsSearchFilterEntity f) {
                              myHabitsListKey.currentState!.updateFilter(f);
                              setState(() {});
                            },
                          );
                        },
                      );
                    },
                    onSearch: (val) {
                      myHabitsListKey.currentState!.updateFilter(filter
                          .copyWith(searchText: val.isEmpty ? null : val));
                    },
                  ),
                ),
              ];
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (filter.selectedStatus != 0)
                  Row(
                    children: [
                      CategoryFilterItem(
                        onTap: () {},
                        isSelected: true,
                        text: Constants.habitStatusFilter[myHabitsListKey
                            .currentState!.filter.selectedStatus],
                      ),
                    ],
                  ),
                if (filter.selectedCategory.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: filter.selectedCategory
                          .map(
                            (e) => CategoryFilterItem(
                              onTap: () {},
                              isSelected: true,
                              c: Constants.categoryList[e],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                Expanded(
                  child: _List(
                    key: myHabitsListKey,
                  ),
                ),
              ],
            )));
  }
}

class _FilterBottomSheet extends StatefulWidget {
  const _FilterBottomSheet(
      {super.key, required this.filter, required this.onFilter});
  final MyHabitsSearchFilterEntity filter;
  final Function(MyHabitsSearchFilterEntity f) onFilter;
  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  late MyHabitsSearchFilterEntity filter;
  @override
  void initState() {
    filter = widget.filter;
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
                        filter = MyHabitsSearchFilterEntity();
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
                    final isSelected = filter.selectedCategory
                        .any((element) => element == index);
                    final c = Constants.categoryList[index];
                    return CategoryFilterItem(
                      c: c,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            filter = filter.copyWith(
                                selectedCategory: filter.selectedCategory
                                    .where((element) => element != index)
                                    .toList());
                            return;
                          }
                          filter = filter.copyWith(selectedCategory: [
                            ...filter.selectedCategory,
                            index
                          ]);
                        });
                      },
                    )
                        .animate()
                        .fadeIn(delay: Duration(milliseconds: 50 * index));
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'habit_status'.tr(),
                style: context.textTheme.labelMedium!.copyWith(fontSize: 14),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: Constants.habitStatusFilter.map((e) {
                        final isSelected = filter.selectedStatus ==
                            Constants.habitStatusFilter.indexOf(e);
                        return Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                filter = filter.copyWith(
                                    selectedStatus:
                                        Constants.habitStatusFilter.indexOf(e));
                              });
                            },
                            child: AnimatedContainer(
                              decoration: BoxDecoration(
                                  color: isSelected
                                      ? context.colorScheme.primary
                                          .withOpacity(0.1)
                                      : context.colorScheme.surface),
                              padding: const EdgeInsets.all(10),
                              duration: 500.ms,
                              child: Center(
                                child: Text(
                                  e,
                                  style: context.textTheme.labelMedium!
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ).animate().fadeIn(delay: 200.ms);
                      }).toList()),
                ),
              ),
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
                      widget.onFilter(filter);
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

class _List extends StatefulWidget {
  const _List({
    super.key,
  });

  @override
  State<_List> createState() => _ListState();
}

late PagingController<int, HabitEntity> _pagingController;

class _ListState extends State<_List> {
  void refresh() {
    _pagingController.refresh();
  }

  void updateFilter(MyHabitsSearchFilterEntity newFilter) async {
    filter = newFilter;
    _pagingController.refresh();
  }

  MyHabitsSearchFilterEntity filter = MyHabitsSearchFilterEntity();
  Future<void> _fetchPage(int pageKey) async {
    final either = await sl<GetAllHabitsUseCase>()(filter);
    either.fold((l) => _pagingController.error == l.message, (r) {
      _pagingController.appendLastPage(r);
    });
  }

  @override
  void initState() {
    _pagingController = sl();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _pagingController.refresh();
      },
      child: PagedListView<int, HabitEntity>(
        padding: EdgeInsets.zero,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<HabitEntity>(
            noItemsFoundIndicatorBuilder: (val) => Center(
                  child: Text(
                    'not_found'.tr(),
                    style: context.textTheme.labelMedium,
                  ),
                ),
            firstPageProgressIndicatorBuilder: (val) =>
                const Center(child: LoadingWidget()),
            newPageProgressIndicatorBuilder: (val) =>
                const Center(child: LoadingWidget()),
            firstPageErrorIndicatorBuilder: (val) => Center(
                  child: Text(
                    'unexpected_failure_message'.tr(),
                    style: context.textTheme.labelMedium,
                  ),
                ),
            itemBuilder: (context, item, index) => MyHabitItem(
                  habit: item,
                )),
      ),
    );
  }
}

// Column(
//         children: [
//
//         ],
//       ),

