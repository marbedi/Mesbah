import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mesbah/common/extensions/context.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/navigation/navigation_flow.dart';
import '../../../../helper/validator.dart';
import '../../../../locator.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_text_field.dart';

class AuthSignUpPage extends StatefulWidget {
  const AuthSignUpPage({super.key});

  @override
  State<AuthSignUpPage> createState() => _AuthSignUpPageState();
}

class _AuthSignUpPageState extends State<AuthSignUpPage> {
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();
  final TextEditingController _usernameFieldController =
      TextEditingController();
  final TextEditingController _fullNameFieldController =
      TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 30,
          centerTitle: true,
          forceMaterialTransparency: true,
        ),
        body: BlocListener<AuthBloc, AuthBlocState>(
          listener: (context, state) async {
            if (state.status == AuthStatus.success) {
              context.showMessage(
                  "با موفقیت ثبت نام شدید!", SnackBarType.success);
              final shared = locator<SharedPreferences>();
              await shared.setBool('firstLogin', false);
              NavigationFlow.toHome();
            } else if (state.status == AuthStatus.failure) {
              context.showMessage("مشکلی روی داده است!", SnackBarType.error);
            }
          },
          child: FormBuilder(
            key: _formKey,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
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
                      Text("sign_up".tr(),
                          style: context.textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.normal, fontSize: 40)),
                      const SizedBox(
                        height: 80,
                      ),
                      AuthTextField(
                        obscureText: false,
                        controller: _fullNameFieldController,
                        validator: Validator.required(),
                        title: 'full_name'.tr(),
                        name: 'fullname',
                        hint: "Full Name",
                      ).animate().fadeIn(),
                      AuthTextField(
                        obscureText: false,
                        controller: _usernameFieldController,
                        validator: Validator.required(),
                        title: 'username'.tr(),
                        name: 'username',
                        hint: "Username",
                      ).animate().fadeIn(delay: 100.ms),
                      AuthTextField(
                        obscureText: false,
                        controller: _emailFieldController,
                        validator: Validator.email(),
                        title: 'email'.tr(),
                        name: 'email',
                        hint: "Email",
                      ).animate().fadeIn(delay: 120.ms),
                      AuthTextField(
                        obscureText: true,
                        controller: _passwordFieldController,
                        validator: Validator.password(),
                        title: 'password'.tr(),
                        name: 'password',
                        hint: "Password",
                      ).animate().fadeIn(delay: 140.ms),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                      SignUpRequestedEvent(
                                          email: _emailFieldController.text,
                                          password:
                                              _passwordFieldController.text,
                                          fullName:
                                              _fullNameFieldController.text,
                                          userame:
                                              _usernameFieldController.text));
                                }
                              },
                              child: Text("sign_up".tr()))
                          .animate()
                          .fadeIn(delay: 130.ms),
                      const SizedBox(
                        height: 12,
                      ),
                      Text.rich(TextSpan(
                          style: context.textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                          children: [
                            const TextSpan(text: "حساب کاربری دارید؟"),
                            const TextSpan(text: " "),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => NavigationFlow.toAuthSignIn(),
                              text: "ورود",
                              style: context.textTheme.labelLarge!.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ])),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
