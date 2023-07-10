import 'package:easy_localization/easy_localization.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/extensions/string.dart';
import 'package:habit_tracker_moshtari/common/gen/assets.gen.dart';
import 'package:like_button/like_button.dart';

import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entities/habit_entity.dart';

class OnlineHabitItem extends StatelessWidget {
  OnlineHabitItem({super.key, required this.habit, required this.user});

  final HabitEntity habit;
  final UserEntity user;

  final GlobalKey<ExpansionTileCardState> card = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ExpansionTileCard(
        key: card,
        expandedTextColor: const Color.fromARGB(255, 244, 54, 54),
        leading: CircleAvatar(
          child: Text(
            "م ع",
            style: TextStyle(fontSize: 20),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.fullName!,
                style: context.textTheme.labelLarge!.copyWith(
                    color: Colors.black, fontWeight: FontWeight.normal)),
            Text(habit.title,
                style: context.textTheme.labelMedium!.copyWith(
                    color: Colors.black, fontWeight: FontWeight.normal)),
          ],
        ),
        subtitle: Text(habit.desc,
            style: context.textTheme.labelSmall!
                .copyWith(color: Colors.grey, fontWeight: FontWeight.normal)),
        children: <Widget>[
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 3.0,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.grey[400],
                        size: 15,
                      ),
                      Text(
                        "۳ ساعت پیش",
                        style: context.textTheme.labelMedium!
                            .copyWith(fontSize: 11, color: Colors.grey[400]),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.grey[400],
                        size: 15,
                      ),
                      Text(
                        " ${habit.score..toString().toFarsiNumber()} امتیاز",
                        style: context.textTheme.labelMedium!
                            .copyWith(fontSize: 11, color: Colors.grey[400]),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: LikeButton(
                  circleColor: const CircleColor(
                      start: Color(0xff00ddff), end: Color(0xff0099cc)),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Color(0xff33b5e5),
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(Icons.favorite,
                        color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                        size: 30);
                  },
                ),
              ),
              TextButton(
                style: flatButtonStyle,
                onPressed: () {},
                child: const Column(
                  children: <Widget>[
                    Icon(Icons.comment, size: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
