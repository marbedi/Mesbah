import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:mesbah/common/extensions/context.dart';
import 'package:mesbah/common/gen/assets.gen.dart';
import 'package:mesbah/common/utils/constants.dart';
import 'package:mesbah/common/widgets/loading_widget.dart';
import 'package:mesbah/features/auth/domain/entities/user_entity.dart';
import 'package:mesbah/features/habit/presentation/widgets/habit_item.dart';
import 'package:mesbah/features/habit/presentation/widgets/my_habits_item.dart';
import 'package:mesbah/features/habit/presentation/widgets/online_habit_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../habit/presentation/widgets/profile_habit_item.dart';
import '../bloc/auth_bloc.dart';
import '../../../habit/presentation/bloc/habit_bloc_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthBlocState>(
          // buildWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
        // if (state.status == AuthStatus.failure) {
        //   context.showMessage("مشکلی روی داده است!", SnackBarType.error);
        // }
      }, builder: (context, state) {
        // final user = context.watch<AuthBloc>().state.userEntity;
        bool isCurrentUser = (true);
        if (state.status == AuthStatus.failure) {
          return Center(
            child: Text("مشکلی روی داده است!"),
          );
        } else {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ClipPath(
                  clipper: WaveClipperTwo(reverse: true),
                  child: Container(
                    width: double.infinity,
                    color: context.colorScheme.primary.withOpacity(0.5),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 80.0),
                  const CircleAvatar(
                    radius: 70.0,
                    child: Text(
                      "م ع",
                      style: TextStyle(fontSize: 70),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text("مریم عابدی", style: context.textTheme.headlineLarge),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: 20.0),
                      Column(
                        children: [
                          Text("90", style: context.textTheme.headlineSmall!),
                          const SizedBox(height: 15.0),
                          Text(
                            "score".tr(),
                            style: context.textTheme.labelLarge!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("11.9k",
                              style: context.textTheme.headlineSmall!),
                          const SizedBox(height: 15.0),
                          Text(
                            "followers".tr(),
                            style: context.textTheme.labelLarge!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("7.5k", style: context.textTheme.headlineSmall!),
                          const SizedBox(height: 10.0),
                          Text(
                            "followings".tr(),
                            style: context.textTheme.labelLarge!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20.0),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  !isCurrentUser
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(140.0, 55.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: Text(
                                "follow".tr(),
                                style: context.textTheme.headlineSmall,
                              ),
                            ),
                            const SizedBox(width: 15.0),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.black12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  fixedSize: const Size(50.0, 60.0)),
                              child: const Icon(Icons.mail_outline_outlined),
                            )
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TabBar(
                          isScrollable: true,
                          controller: tabController,
                          indicator:
                              BoxDecoration(borderRadius: BorderRadius.zero),
                          labelColor: Colors.white,
                          labelStyle: context.textTheme.labelMedium,
                          unselectedLabelColor: Colors.black,
                          onTap: (tapIndex) {
                            setState(() {
                              selectedIndex = tapIndex;
                            });
                          },
                          tabs: const [
                            Tab(text: "در حال انجام"),
                            Tab(text: "انجام شده"),
                          ],
                        ),
                        //
                      ],
                    ),
                  ),
                  // SizedBox(height: 10.0),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ProfileHabitItem(
                                  habit: Constants.fakeHabits[index],
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            );
                          },
                          itemCount: 2,
                        ),
                        Center(
                          child: Text("شما عادت انجام شده‌ای ندارید",
                              style: context.textTheme.headlineSmall!),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        }
      }

          // return const SizedBox();
          ),
    );
  }
}
