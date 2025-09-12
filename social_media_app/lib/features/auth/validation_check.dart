import 'package:social_media_app/core/extensions/string_extensions.dart';

class ValidationCheck {
  static String? checkName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'user Name is required ..';
    } else if (!(value.isValidUsername)) {
      return 'Invalid user name, should contain only letters';
    }
    return null;
  }

  static String? checkEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'user email is required ..';
    } else if (!value.isValidEmail) {
      return 'Invalid email !!';
    }
    return null;
  }

  static String? checkPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'password is required ..';
    } else if (!value.isValidPassword) {
      return 'Invalid pasword, should be more than 8 letters, contains upper/lower/special letters';
    }
    return null;
  }

  static String? checkPasswordCofirmation(String? value, String? paswordValue) {
    if (value == null || value.trim().isEmpty) {
      return 'Password confirmation is required ..';
    } else if (value != paswordValue) {
      return "it doesn't match the password field";
    }
    return null;
  }
}



