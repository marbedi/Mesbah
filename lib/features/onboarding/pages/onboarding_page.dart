import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/material.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/gen/assets.gen.dart';
import 'package:habit_tracker_moshtari/common/navigation/navigation_flow.dart';
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
      'title': 'لورم ایپسوم متن ساختگی . ',
      'description':
          'با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است',
      'color': const Color(0xff3BC8DA),
      'image': Assets.images.onboarding1.path
    },
    {
      'title': 'لورم ایپسوم متن ساختگی . ',
      'description':
          'با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است',
      'color': const Color(0xff36DAA8),
      'image': Assets.images.onboarding2.path
    },
    {
      'title': 'لورم ایپسوم متن ساختگی . ',
      'description':
          'با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است',
      'color': const Color(0xff768DFD),
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
                    //TODO: set first login to false
                    final shared = sl<SharedPreferences>();
                    await shared.setBool('firstLogin', false);
                    NavigationFlow.toHome();
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
