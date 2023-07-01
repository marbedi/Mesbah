import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Validator {
  static FormFieldValidator required() {
    return FormBuilderValidators.required(
        errorText: "validator_cant_be_empty".tr());
  }
}
