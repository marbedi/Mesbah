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

class AuthSignInPage extends StatefulWidget {
  const AuthSignInPage({super.key});

  @override
  State<AuthSignInPage> createState() => _AuthSignInPageState();
}

final _formKey = GlobalKey<FormBuilderState>();

class _AuthSignInPageState extends State<AuthSignInPage> {
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();

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
      body: BlocBuilder<AuthBloc, AuthBlocState>(
        builder: (context, state) {
          return FormBuilder(
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
                      Text("sign_in".tr(),
                          style: context.textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.normal, fontSize: 40)),
                      const SizedBox(
                        height: 150,
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
                                        password: _passwordFieldController.text,
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
                                ..onTap = () => NavigationFlow.toHome(),
                              text: "ثبت نام",
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
          );
        },
      ),
    );
  }
}
