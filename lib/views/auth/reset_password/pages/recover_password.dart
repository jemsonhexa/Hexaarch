import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/common/widgets/buttons/custom_button.dart';
import 'package:hexaarch/common/widgets/inputfields/textfield.dart';
import 'package:hexaarch/themes/color_scheme.dart';
import 'package:hexaarch/utils/mediaquery.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final _recoverPasswordKey = GlobalKey<FormState>();

  bool isEmailInvalid = false;
  bool isUnverified = false;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> sendEmail() async {
    if (!_recoverPasswordKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      isEmailInvalid = false;
      isUnverified = false;
    });

    final email = emailController.text.trim();

    //Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    //  Example backend responses
    if (!email.contains('@')) {
      setState(() => isEmailInvalid = true);
    } else if (email == 'unknown@gmail.com') {
      setState(() => isUnverified = true);
    } else {
      //  SUCCESS
      context.push('/sendemail');
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Form(
            key: _recoverPasswordKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Align(
                  alignment: AlignmentGeometry.center,
                  child: SvgPicture.asset('assets/svg/lock.svg'),
                ),
                const SizedBox(height: 10),

                /// Title
                Align(
                  alignment: AlignmentGeometry.center,
                  child: Text(
                    "Forgot Your Password?",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.black,
                      letterSpacing: -0.5,
                      fontSize: getResponsiveFontSize(
                        context,
                        defaultFontSize: 25,
                        widePortraitFontSize: 20,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                /// Description
                Text(
                  "Enter your registered email below to receive password reset instruction",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: getResponsiveFontSize(
                      context,
                      defaultFontSize: 15,
                      widePortraitFontSize: 12,
                    ),
                    color: AppColors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                /// Email Field
                CustomEditTextField(
                  controller: emailController,
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

                /// Invalid Email Error
                if (isEmailInvalid)
                  _errorText(
                    title: "Invalid Email - ",
                    message:
                        "Please check your email address. It does not exist in our system.",
                  ),

                /// Unverified Email Error
                if (isUnverified)
                  _errorText(
                    title: "Unverified Email - ",
                    message:
                        "Attempt to reset password for an unverified account.",
                  ),

                const SizedBox(height: 24),

                /// Button
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Send Email',
                    isLoading: isLoading,
                    onPressed: sendEmail,
                    isEnabled: true,
                    color: AppColors.primaryColor,
                    textColor: AppColors.white,
                    defaultFontSize: 18,
                    widePortraitFontSize: 11,
                    borderRadius: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _errorText({required String title, required String message}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            color: AppColors.black,
          ),
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: message,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
