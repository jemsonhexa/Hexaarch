import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/common/widgets/appbar.dart';
import 'package:hexaarch/common/widgets/inputfields/textfield.dart';
import 'package:hexaarch/themes/color_scheme.dart';
import 'package:hexaarch/views/auth/signup/provider/email_provider.dart';
import 'package:hexaarch/views/auth/signup/provider/name_provider.dart';
import 'package:hexaarch/views/auth/signup/provider/phone_num_provider.dart';
import 'package:hexaarch/views/auth/signup/widgets/signup_buttons.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _email = TextEditingController();
  final _mobile = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool isRequestDone = false;
  bool isPasswordValid = false;
  bool get _isConfirmPasswordValid => _password.text == _confirmPassword.text;

  @override
  void dispose() {
    _firstName.dispose();
    _email.dispose();
    _mobile.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  ///  Only 8 character validation
  void _validatePassword(String password) {
    setState(() {
      isPasswordValid = password.length >= 8;
    });
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  Future<void> _onSignUp() async {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    final body = {
      "email": _email.text.trim(),
      "password": _password.text,
      "confirmPassword": _confirmPassword.text,
      "firstName": _firstName.text.trim(),
      "phone": _mobile.text.trim(),
      "countryCode": "+91",
    };
    ref.read(emailProvider.notifier).setEmail(_email.text.trim());
    ref.read(nameProvider.notifier).setName(_firstName.text.trim());
    ref.read(phoneNumberProvider.notifier).setPhone('+91${_mobile.text}');

    try {
      setState(() => isRequestDone = true);
      log("Signup body: $body");

      /// API call here
      /// await AuthProvider().signup(body);

      context.pushNamed("location");
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Signup failed: $e")));
      setState(() => isRequestDone = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(context, 'Register'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ///  Name
              CustomEditTextField(
                controller: _firstName,
                labelText: 'Name',
                hintText: 'Enter your name',
                keyBoardType: TextInputType.name,
                validator: (val) => val == null || val.trim().isEmpty
                    ? "Name is required"
                    : null,
              ),
              const SizedBox(height: 16),

              /// Email Field
              CustomEditTextField(
                controller: _email,
                labelText: 'Email Address',
                hintText: 'Enter your email address',
                keyBoardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!value.contains('@')) {
                    return 'Please provide a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              /// Mobile
              CustomEditTextField(
                controller: _mobile,
                labelText: 'Mobile Number',
                hintText: 'Enter your Mobile Number',
                keyBoardType: TextInputType.phone,
                inputformatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (val) => val == null || val.length != 10
                    ? "Enter valid mobile number"
                    : null,
              ),

              const SizedBox(height: 16),
              CustomEditTextField(
                hintText: 'Enter Password',
                controller: _password,
                showToggleIcon: true,
                obscureText: true,
                labelText: 'Password',

                onTextChanged: _validatePassword,
                validator: _passwordValidator,
              ),
              const SizedBox(height: 16),

              /// Password
              CustomEditTextField(
                hintText: 'Confirm Password',
                controller: _confirmPassword,
                showToggleIcon: true,
                obscureText: true,
                labelText: 'Confirm Password',

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm password is required";
                  }
                  if (!_isConfirmPasswordValid) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    isPasswordValid
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    size: 18,
                    color: isPasswordValid ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  const Text("Minimum 8 characters"),
                ],
              ),
              const SizedBox(height: 16),

              /// Sign Up Button
              ElevatedButton(
                onPressed: isRequestDone ? null : _onSignUp,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppColors.primaryColor,
                ),
                child: isRequestDone
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('Or Sign up with'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),
              googleSignUpButton(context),
              const SizedBox(height: 10),
              fbSignUpButton(context),
              const SizedBox(height: 10),
              appleSignUpButton(context),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  TextButton(
                    onPressed: () {
                      context.push('/emailsignin');
                    },
                    child: const Text('Sign in'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
