import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/navigation/navigation_flow.dart';
import 'package:habit_tracker_moshtari/common/utils/constants.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/category_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_source.dart';
import 'package:url_launcher/url_launcher.dart';

class HabitSourcesPage extends StatelessWidget {
  const HabitSourcesPage({super.key, required this.c});
  final CategoryEntity c;

  Icon getIcon(HabitSourceTypes type) {
    switch (type) {
      case HabitSourceTypes.book:
        return const Icon(
          Icons.book,
          size: 30,
          color: Colors.green,
        );
      case HabitSourceTypes.software:
        return const Icon(
          Icons.mobile_friendly,
          size: 30,
          color: Colors.blue,
        );
      case HabitSourceTypes.site:
        return const Icon(
          Icons.web,
          color: Colors.orange,
          size: 30,
        );
      default:
        return const Icon(
          Icons.book,
          color: Colors.green,
          size: 30,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '${'habit_sources'.tr()} ${c.name}',
          style: context.textTheme.labelMedium,
        ),
        leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              NavigationFlow.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: context.colorScheme.onBackground,
            )),
      ),
      body: Constants.habitSources
              .where((element) => element.categoryId == c.id)
              .toList()
              .isEmpty
          ? Center(
              child: Text(
                'source_not_found'.tr(),
                style: context.textTheme.labelMedium,
              ),
            )
          : ListView.builder(
              itemBuilder: (con, i) {
                final source = Constants.habitSources
                    .where((element) => element.categoryId == c.id)
                    .toList()[i];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      getIcon(source.type),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            source.title,
                            style: context.textTheme.labelMedium,
                          ),
                          Text(source.desc,
                              style: context.textTheme.labelSmall),
                          // Text(source.link,
                          //     style: context.textTheme.labelSmall!
                          //         .copyWith(color: Colors.grey, fontSize: 12)),
                        ],
                      )),
                      IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            try {
                              launchUrl(Uri.parse(source.link));
                            } catch (e) {}
                          },
                          icon: const Icon(Icons.open_in_browser))
                    ],
                  ),
                );
              },
              itemCount: Constants.habitSources
                  .where((element) => element.categoryId == c.id)
                  .toList()
                  .length),
    );
  }
}
