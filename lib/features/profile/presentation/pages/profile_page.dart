import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/navigation/navigation_flow.dart';
import 'package:habit_tracker_moshtari/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:habit_tracker_moshtari/features/auth/presentation/widgets/auth_text_field.dart';

import '../../../../helper/validator.dart';
import '../../../auth/domain/entities/user_entity.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // final user = widget.userEntity;

    return const Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   leadingWidth: 30,
        //   centerTitle: true,
        //   forceMaterialTransparency: true,
        // ),
        body: Center(child: Text("HelloWorld")));
  }
}
