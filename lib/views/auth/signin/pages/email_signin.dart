import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/common/widgets/inputfields/textfield.dart';
import 'package:hexaarch/themes/color_scheme.dart';
import 'package:hexaarch/utils/mediaquery.dart';
import 'package:hexaarch/views/auth/widgets/helpers/signup_validator.dart';
import 'package:hexaarch/views/auth/signin/widgets/signin_buttons.dart';
import 'package:hexaarch/common/widgets/buttons/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailSignInScreen extends ConsumerStatefulWidget {
  const EmailSignInScreen({super.key});

  @override
  ConsumerState<EmailSignInScreen> createState() => _EmailSignInScreenState();
}

class _EmailSignInScreenState extends ConsumerState<EmailSignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _emailsigninformkey = GlobalKey<FormState>();
  final _validator = SignUpValidator();

  @override
  void initState() {
    super.initState();
    // loadUserCredentials();
  }

  @override
  void dispose() {
    emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Future<void> loadUserCredentials() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final savedRememberMe = prefs.getBool('rememberMe') ?? false;

  //   if (savedRememberMe) {
  //     emailController.text = prefs.getString('email') ?? '';
  //     _passwordController.text = prefs.getString('password') ?? '';
  //     setState(() => _rememberMe = true);
  //   }
  // }

  // void _signIn() async {
  //   if (_signinformkey.currentState!.validate()) {
  //     final body = {
  //       "email": emailController.text.trim(),
  //       "password": _passwordController.text.trim(),
  //     };
  //     final prefs = await SharedPreferences.getInstance();

  //     try {
  //       // if (_rememberMe) {
  //       //   await prefs.setString('email', emailController.text);
  //       //   await prefs.setString('password', _passwordController.text);
  //       //   await prefs.setBool('rememberMe', true);
  //       // } else {
  //       //   await prefs.remove('email');
  //       //   await prefs.remove('password');
  //       //   await prefs.setBool('rememberMe', false);
  //       // }
  //       final authProvider = context.read<AuthProvider>();
  //       await authProvider.loginwithPassword(body, rememberMe: _rememberMe);
  //       // context.goNamed('overview', extra: 'Home');
  //       // final contexted = navigatorKey.currentContext!;
  //       context.go('/refer');
  //     } catch (e) {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text("login failed occured: $e")));
  //     }
  //   }
  // }

  bool isTextNotEmpty = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _emailsigninformkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomEditTextField(
                  hintText: 'Enter your email',
                  controller: emailController,
                  labelText: 'Email Address',
                  labelStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: getResponsiveFontSize(
                      context,
                      defaultFontSize: 14,
                      widePortraitFontSize: 10,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (p0) => _validator.validateEmail(p0),
                ),
                SizedBox(height: 16),
                CustomEditTextField(
                  hintText: 'Enter your Password',
                  controller: _passwordController,
                  showToggleIcon: true,
                  obscureText: true,
                  labelText: 'Password',
                  labelStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: getResponsiveFontSize(
                      context,
                      defaultFontSize: 14,
                      widePortraitFontSize: 10,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Password is required'
                      : null,
                ),
                const SizedBox(height: 24),

                /// Continue Button
                CustomButton(
                  text: 'Login',
                  isLoading: isLoading,
                  isEnabled: true,
                  color: AppColors.primaryColor,
                  textColor: AppColors.white,
                  defaultFontSize: 18,
                  widePortraitFontSize: 12,
                  borderRadius: 8,
                  onPressed: () async {
                    if (!_emailsigninformkey.currentState!.validate()) {
                      return;
                    }
                    setState(() => isLoading = true);
                    // Save phone number with country code
                    // ref
                    //     .read(phoneNumberProvider.notifier)
                    //     .setPhone('+91${_phoneController.text}');

                    await Future.delayed(const Duration(seconds: 2));

                    setState(() => isLoading = false);

                    if (context.mounted) {
                      context.push('/home');
                    }
                  },
                ),
                TextButton(
                  onPressed: () {
                    context.push('/forgotpwd');
                  },
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'Or',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
                const SizedBox(height: 20),

                /// Social Login Buttons
                googleSignInButton(context),
                const SizedBox(height: 10),
                fbSignInButton(context),
                const SizedBox(height: 10),
                phonenumberSignInButton(context),
                const SizedBox(height: 10),
                appleSignInButton(context),
                const SizedBox(height: 10),
                //signup
                signUpButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
