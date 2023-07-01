import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';

class SearchBar extends StatelessWidget {
  const SearchBar(
      {super.key,
      required this.onSearch,
      required this.onFilter,
      this.hasFilter = false});
  final Function(String)? onSearch;
  final Function()? onFilter;
  final bool hasFilter;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          decoration: BoxDecoration(
              color: context.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 2)
              ],
              borderRadius: BorderRadius.circular(100)),
          padding: const EdgeInsets.all(0),
          width: double.infinity,
          child: Row(
            children: [
              Material(
                type: MaterialType.transparency,
                child: IconButton(
                    splashRadius: 16,
                    onPressed: onFilter,
                    icon: Icon(Icons.filter_list,
                        size: 23,
                        color: hasFilter
                            ? context.colorScheme.primary
                            : Colors.grey[600])),
              ),
              Expanded(
                child: TextField(
                  style: context.textTheme.labelMedium,
                  onChanged: onSearch,
                  autofocus: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: context.textTheme.labelMedium!
                          .copyWith(fontSize: 14, color: Colors.grey[600]),
                      hintText: '${'search'.tr()} ...',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 0)),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 2,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {},
              child: Ink(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 3,
                      )
                    ]),
                child: Icon(
                  Icons.search,
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
