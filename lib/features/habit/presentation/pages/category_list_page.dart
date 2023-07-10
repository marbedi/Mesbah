import 'dart:math';

import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:mesbah/common/extensions/context.dart';
import 'package:mesbah/common/navigation/navigation_flow.dart';
import 'package:mesbah/common/utils/constants.dart';
import 'package:mesbah/features/habit/domain/entities/category_entity.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({
    super.key,
  });
  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  final List<CustomClipper<Path>> clipperList = [
    WaveClipperTwo(),
    WaveClipperOne(reverse: true),
  ];
  CategoryEntity? selectedCategory;

  CustomClipper<Path> getRandomClipper() {
    final random = Random();
    final randomIndex = random.nextInt(clipperList.length);
    return clipperList[randomIndex];
  }

  Widget getClipper() {
    final clipper = getRandomClipper();
    return Positioned(
      top: clipper is WaveClipperOne ? 15 : 0,
      right: 0,
      left: 0,
      bottom: clipper is WaveClipperTwo ? 15 : 0,
      child: ClipPath(
        clipper: clipper,
        child: Container(
          width: double.infinity,
          color: Colors.white.withOpacity(0.3),
          child: const SizedBox(),
        ),
      ),
    );
  }

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selectedCategory != null) {
          setState(() {
            selectedCategory = null;

            animationController.loop(count: 1);
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            elevation: 0,
            leadingWidth: 30,
            centerTitle: true,
            leading: selectedCategory == null
                ? null
                : IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          setState(() {
                            selectedCategory = null;

                            animationController.loop(count: 1);
                          });
                        },
                        icon: Icon(Icons.arrow_back,
                            color: context.colorScheme.onBackground))
                    .animate()
                    .fadeIn(),
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (selectedCategory != null)
                  Image.asset(
                    selectedCategory!.icon!,
                    width: 30,
                    height: 30,
                  ).animate().fadeIn(),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  (selectedCategory != null)
                      ? selectedCategory!.name
                      : 'categories'.tr(),
                  style: context.textTheme.labelMedium,
                ),
                const SizedBox(
                  width: 30,
                )
              ],
            )),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: selectedCategory?.subCategory?.length ??
              Constants.categoryList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.6,
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15),
          itemBuilder: (context, index) {
            final c = selectedCategory?.subCategory?[index] ??
                Constants.categoryList[index];
            return GestureDetector(
              onTap: () {
                if (c.subCategory != null && c.subCategory!.isNotEmpty) {
                  setState(() {
                    selectedCategory = c;
                    animationController.loop(count: 1);
                  });
                } else {
                  NavigationFlow.toHabitsListPage(c);
                }
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Constants.getRandomColor(),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  getClipper(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            c.name,
                            style: context.textTheme.labelMedium!
                                .copyWith(color: Colors.black54, fontSize: 14),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_back_ios_rounded,
                          textDirection: TextDirection.ltr,
                          size: 16,
                          color: Colors.black54,
                        )
                      ],
                    ),
                  ),
                  if (c.icon != null)
                    Positioned(
                        right: 10,
                        bottom: 10,
                        child: Image.asset(c.icon!, width: 50, height: 50))
                ],
              ),
            )
                .animate(controller: animationController)
                .flip(delay: Duration(milliseconds: index * 130));
          },
        ),
      ),
    );
  }
}
