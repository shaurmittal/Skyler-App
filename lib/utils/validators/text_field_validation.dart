import 'package:get/utils.dart';

class Validator {
  String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required'.toString();
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    value = value!.trim();
    if (value.isEmpty) {
      return 'Please enter an email';
    }
    if (GetUtils.isEmail(value)) {
      return null;
    } else {
      return 'Please enter a valid email address';
    }
  }

  String? password(String? value, {bool isFromLogin = false}) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if ((value.length) < 6) {
      return 'Password must be at least 6 characters long';
    } else {
      return null;
    }
  }
}
