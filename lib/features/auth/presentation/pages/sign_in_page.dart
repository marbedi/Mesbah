import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                width: double.infinity,
                color: Colors.red.withOpacity(0.3),
                // child: const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
