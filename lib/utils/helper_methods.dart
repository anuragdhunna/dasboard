import 'dart:developer';

import 'package:email_validator/email_validator.dart';

class HelperMethods {
  String? emptyField(value, fieldName) {
    if (value.isEmpty) {
      return 'Please enter ' + fieldName;
    }
    return null;
  }

  String? validateEmail(value) {
    if (value.isEmpty) {
      return 'Please enter Email';
    }
    if (!EmailValidator.validate(value)) {
      return 'The E-mail Address must be a valid email address.';
    }
    return null;
  }

  String? validatePassword(value) {
    bool passValid = RegExp(
            "^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*")
        .hasMatch(value);
    log("validate password");
    if (value.isEmpty) {
      return 'Please enter password';
    }

    if (!passValid) {
      return 'Enter valid password';
    }
    return null;
  }
}
