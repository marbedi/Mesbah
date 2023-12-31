import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mesbah/common/extensions/context.dart';

class AuthTextField extends StatelessWidget {
  final String title;
  final String name;
  final String? hint;
  final bool enabled;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final ValueChanged<String?>? onChanged;
  final TextInputAction? action;
  final int? minLines;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final bool readOnly;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldSetter<String?>? onSubmitted;
  final String? errorText;
  final Widget? suffix;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextDirection textDirection;
  const AuthTextField(
      {Key? key,
      required this.title,
      required this.name,
      this.hint,
      this.enabled = true,
      this.keyboardType,
      this.focusNode,
      this.errorText,
      this.onChanged,
      this.action,
      this.minLines,
      this.maxLines,
      this.validator,
      this.maxLength,
      this.readOnly = false,
      this.inputFormatters,
      this.initialValue,
      this.onSubmitted,
      this.suffix,
      this.prefixIcon,
      this.controller,
      required this.obscureText,
      this.textDirection = TextDirection.ltr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: context.textTheme.labelLarge!
              .copyWith(fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 5,
        ),
        FormBuilderTextField(
          name: name,
          focusNode: focusNode,
          onChanged: onChanged,
          textDirection: textDirection,
          initialValue: initialValue,
          minLines: 1,
          style: context.textTheme.labelLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              hintTextDirection: textDirection,
              contentPadding: const EdgeInsets.all(18),
              errorStyle: context.textTheme.labelMedium!.copyWith(
                  color: context.colorScheme.error, fontSize: 12, height: 0.5),
              hintText: hint,
              filled: true,
              hintStyle: context.textTheme.labelLarge!.copyWith(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
              fillColor: context.colorScheme.surface,
              counter: const SizedBox(),
              errorText: errorText,
              suffix: suffix,
              prefixIcon: prefixIcon),
          keyboardType: keyboardType,
          textInputAction: action,
          inputFormatters: inputFormatters,
          maxLines: 1,
          validator: validator,
          maxLength: maxLength,
          onSubmitted: onSubmitted,
          readOnly: readOnly,
          enabled: enabled,
        ),
      ],
    );
  }
}
