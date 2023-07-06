import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/features/auth/presentation/widgets/auth_text_field.dart';

import '../../../../common/widgets/titled_textfield.dart';
import '../../../../helper/validator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

final _formKey = GlobalKey<FormBuilderState>();

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 30,
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: FormBuilder(
        key: _formKey,
        child: Stack(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  AuthTextField(
                    controller: _emailFieldController,
                    validator: Validator.email(),
                    title: 'email'.tr(),
                    name: 'email',
                    hint: "Email",
                  ).animate().fadeIn(),
                  AuthTextField(
                    controller: _passwordFieldController,
                    validator: Validator.password(),
                    title: 'password'.tr(),
                    name: 'password',
                    hint: "Password",
                  ).animate().fadeIn(delay: 100.ms),
                  ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              debugPrint("login");
                            }
                          },
                          child: Text("sign_in".tr()))
                      .animate()
                      .fadeIn(delay: 130.ms)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
