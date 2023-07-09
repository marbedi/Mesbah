import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Validator {
  static FormFieldValidator required() {
    return FormBuilderValidators.required(
        errorText: "validator_cant_be_empty".tr());
  }

  static FormFieldValidator<String> password() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: "validator_cant_be_empty".tr()),
      FormBuilderValidators.match(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*]).{8,}$',
          errorText: "validate_password".tr()),
    ]);
  }

  static FormFieldValidator<String> email() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: "validator_cant_be_empty".tr()),
      FormBuilderValidators.email(errorText: "validate_email".tr()),
    ]);
  }

  static FormFieldValidator<String> username() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: "validator_cant_be_empty".tr()),
      FormBuilderValidators.match(r'^[a-zA-Z0-9_-]{3,16}$',
          errorText: "validate_username".tr()),
    ]);
  }
}
