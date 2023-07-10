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
import 'package:habit_tracker_moshtari/features/auth/presentation/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helper/validator.dart';
import '../../../../locator.dart';

class AuthSignInPage extends StatefulWidget {
  const AuthSignInPage({super.key});

  @override
  State<AuthSignInPage> createState() => _AuthSignInPageState();
}

class _AuthSignInPageState extends State<AuthSignInPage> {
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
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
              context.showMessage("با موفقیت وارد شدید!", SnackBarType.success);

              final shared = locator<SharedPreferences>();
              await shared.setBool('firstLogin', false);
              NavigationFlow.toHome();
            } else if (state.status == AuthStatus.failure) {
              context.showMessage(
                  "ایمیل یا رمز عبور شما نامعتبر است!", SnackBarType.error);
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("sign_in".tr(),
                            style: context.textTheme.labelLarge!.copyWith(
                                fontWeight: FontWeight.normal, fontSize: 40)),
                        const SizedBox(
                          height: 120,
                        ),
                        AuthTextField(
                          obscureText: false,
                          controller: _emailFieldController,
                          validator: Validator.email(),
                          title: 'email'.tr(),
                          name: 'email',
                          hint: "Email",
                        ).animate().fadeIn(),
                        AuthTextField(
                          obscureText: true,
                          controller: _passwordFieldController,
                          validator: Validator.password(),
                          title: 'password'.tr(),
                          name: 'password',
                          hint: "Password",
                        ).animate().fadeIn(delay: 100.ms),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<AuthBloc>()
                                        .add(SignInRequestedEvent(
                                          email: _emailFieldController.text,
                                          password:
                                              _passwordFieldController.text,
                                        ));
                                  }
                                },
                                child: Text("sign_in".tr()))
                            .animate()
                            .fadeIn(delay: 130.ms),
                        const SizedBox(
                          height: 30,
                        ),
                        Text.rich(TextSpan(
                            style: context.textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                            children: [
                              const TextSpan(text: "حساب کاربری ندارید؟"),
                              const TextSpan(text: " "),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => NavigationFlow.toAuthSignUp(),
                                text: "ثبت نام",
                                style: context.textTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                            ])),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
