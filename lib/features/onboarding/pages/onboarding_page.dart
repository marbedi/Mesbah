import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/material.dart';
import 'package:mesbah/common/extensions/context.dart';
import 'package:mesbah/common/gen/assets.gen.dart';
import 'package:mesbah/common/navigation/navigation_flow.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../locator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final onBoardingData = [
    {
      'title': '',
      'description':
          """امیرالمؤمنین علی (علیهالسلام) فرمودند: إنّما قَلْبُ الحَدَثِ كالأرضِ الخالِيةِ ما اُلقِيَ فيها مِنْ شيءٍ قَبِلَتْهُ .
قطعا دل جوان همانند زمین خالى است، هر بذرى در آن ريخته شود می‌پذيرد.""",
      'color': Color.fromARGB(255, 174, 187, 251),
      'image': Assets.images.onboarding1.path
    },
    {
      'title': '',
      'description':
          'با عادت‌های خوب و مفید دينی دل و جانمان را بذرافشانی كنیم...',
      'color': Color.fromARGB(255, 134, 154, 254),
      'image': Assets.images.onboarding2.path
    },
    {
      'title': '',
      'description': 'مصباح در اين مسیر چراغ راه شماست...',
      'color': Color.fromARGB(255, 92, 119, 255),
      'image': Assets.images.onboarding3.path
    },
  ];
  late LiquidController liquidController;
  @override
  void initState() {
    liquidController = LiquidController();

    super.initState();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Directionality(
            textDirection: TextDirection.rtl,
            child: LiquidSwipe.builder(
              itemCount: onBoardingData.length,
              liquidController: liquidController,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  color: onBoardingData[index]['color'] as Color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0),
                            shape: BoxShape.circle),
                        child: Image.asset(
                          onBoardingData[index]['image'].toString(),
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                                onBoardingData[index]['title'].toString(),
                                style: context.textTheme.labelMedium!.copyWith(
                                    color: Colors.white, fontSize: 20)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                                onBoardingData[index]['description'].toString(),
                                textAlign: TextAlign.center,
                                style: context.textTheme.labelMedium!
                                    .copyWith(color: Colors.white)),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              positionSlideIcon: 0.5,
              slideIconWidget: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              waveType: WaveType.liquidReveal,
              fullTransitionValue: 880,
              enableSideReveal: true,
              onPageChangeCallback: (i) => setState(() {
                currentIndex = i;
              }),
              preferDragFromRevealedArea: true,
              enableLoop: false,
              ignoreUserGestureWhileAnimating: true,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () async {
                  if (currentIndex == 2) {
                    NavigationFlow.toAuthSignIn();
                    return;
                  }
                  liquidController.animateToPage(
                      page: liquidController.currentPage + 1 >
                              onBoardingData.length - 1
                          ? 0
                          : liquidController.currentPage + 1);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.01),
                    foregroundColor: Colors.black),
                child: Text(
                  currentIndex == 2 ? "finish".tr() : "next".tr(),
                  style: context.textTheme.labelLarge!
                      .copyWith(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: AnimatedSmoothIndicator(
                    textDirection: TextDirection.ltr,
                    activeIndex: currentIndex,
                    count: onBoardingData.length,
                    effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        dotColor: Colors.grey[100]!,
                        activeDotColor: Colors.white))),
          )
        ],
      ),
    );
  }
}
