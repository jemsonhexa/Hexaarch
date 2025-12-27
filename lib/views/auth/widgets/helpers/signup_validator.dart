import 'package:hexaarch/views/auth/widgets/helpers/password_criteria.dart';

class SignUpValidator {
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'First name is required';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Last name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required';
    }

    final mobileRegex = RegExp(r'^\d{10}$');
    if (!mobileRegex.hasMatch(value.trim())) {
      return 'Enter a valid 10-digit mobile number';
    }

    return null;
  }

  String? validateReferral(String? value) {
    // Referral is optional. Add condition if there's a format or length requirement.
    if (value != null && value.isNotEmpty && value.length < 4) {
      return 'Referral code must be at least 4 characters';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Include at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Include at least one lowercase letter';
    }

    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Include at least one number';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Include at least one special character';
    }

    return null;
  }

  String? validateConfirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) {
      return 'Confirm your password';
    }

    if (value != original) {
      return 'Passwords do not match';
    }

    return null;
  }

  bool validateSignUp({
    required String email,
    required String password,
    required String confirmPassword,
    required Map<String, bool> passwordCriteriaOne,
    required Map<String, bool> passwordCriteriaTwo,
    required bool isConfirmPasswordValid,
    // required bool acceptTerms,
    // required bool excludeEmails,
    context,
  }) {
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;

    // Validate email
    if (email.isEmpty) {
      emailError = "Email cannot be empty";
    } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      emailError = "Please enter a valid email address";
    }

    // Validate password
    if (password.isEmpty) {
      passwordError = "Password cannot be empty";
    } else if (!passwordCriteriaOne.values.every((isValid) => isValid) ||
        !passwordCriteriaTwo.values.every((isValid) => isValid)) {
      passwordError = "Password does not meet the required criteria";
    }

    // Validate confirm password
    if (confirmPassword.isEmpty) {
      confirmPasswordError = "Confirm Password cannot be empty";
    } else if (!isConfirmPasswordValid) {
      confirmPasswordError = "Passwords do not match";
    }

    // Validate terms acceptance
    // if (!acceptTerms) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('You need to accept the terms and privacy policy.',
    //           textAlign: TextAlign.center),
    //       behavior: SnackBarBehavior.floating,
    //       backgroundColor: Colors.black54,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //       margin: EdgeInsets.symmetric(horizontal: 50, vertical: 90),
    //       duration: Duration(seconds: 2),
    //     ),
    //   );
    //   return false;
    // }

    return emailError == null &&
        passwordError == null &&
        confirmPasswordError == null;
  }

  bool validateResetpassword({
    required String password,
    required String confirmPassword,
    required Map<String, bool> passwordCriteriaOne,
    required Map<String, bool> passwordCriteriaTwo,
    required bool isConfirmPasswordValid,
    context,
  }) {
    passwordError = null;
    confirmPasswordError = null;

    // Validate password
    if (password.isEmpty) {
      passwordError = "Password cannot be empty";
    } else if (!passwordCriteriaOne.values.every((isValid) => isValid) ||
        !passwordCriteriaTwo.values.every((isValid) => isValid)) {
      passwordError = "Password does not meet the required criteria";
    }

    // Validate confirm password
    if (confirmPassword.isEmpty) {
      confirmPasswordError = "Confirm Password cannot be empty";
    } else if (!isConfirmPasswordValid) {
      confirmPasswordError = "Passwords do not match";
    }
    return passwordError == null && confirmPasswordError == null;
  }

  void reset() {
    passwordCriteriaone.updateAll((key, value) => value = false);
    passwordCriteriatwo.updateAll((key, value) => value = false);
  }
}
