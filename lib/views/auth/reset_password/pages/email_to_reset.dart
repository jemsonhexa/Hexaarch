import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/common/widgets/appbar.dart';
import 'package:hexaarch/common/widgets/buttons/custom_button.dart';
import 'package:hexaarch/themes/color_scheme.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key});

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();

  bool isExpired = false;
  bool isCodeResent = false;
  bool isCodeInvalid = false;
  bool isNetError = false;
  bool isRateLimited = false;
  bool isLoading = false;

  int submitAttempts = 0;

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  void verifyOtpPasswordReset() async {
    setState(() {
      isLoading = true;
      isCodeInvalid = false;
      isNetError = false;
    });

    await Future.delayed(const Duration(seconds: 2));

    final code = codeController.text.trim().toLowerCase();

    setState(() {
      isLoading = false;

      if (code == 'wrong') {
        submitAttempts++;
        isCodeInvalid = true;

        if (submitAttempts >= 3) {
          isRateLimited = true;
        }
      } else if (code == 'nonet') {
        isNetError = true;
      } else if (code == 'expired') {
        isExpired = true;
      } else {
        // SUCCESS
        context.push('/resetpwd');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(context, 'Forgot Password'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Align(
                alignment: AlignmentGeometry.center,
                child: SvgPicture.asset('assets/svg/emailsent.svg'),
              ),
              const SizedBox(height: 10),

              /// Title
              Text.rich(
                TextSpan(
                  children: [
                    _boldText(context, "We’ve sent you an "),
                    _greyText(context, "email with a code"),
                    _boldText(context, " to reset your password."),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Description
              Text(
                "Check your spam and promotions folder if it doesn’t appear "
                "in your mailbox and enter the code.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 12),

              /// Expired / Resend message
              if (isExpired)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: isCodeResent
                      ? _infoText(
                          title: "New Code Sent, ",
                          message: "Check your inbox.",
                        )
                      : RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              const TextSpan(
                                text: "Expired Code – ",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(
                                text: "The reset code is no longer valid. ",
                              ),
                              TextSpan(
                                text: "Click here",
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      isCodeResent = true;
                                      isExpired = false;
                                    });
                                  },
                              ),
                              const TextSpan(text: " to resend."),
                            ],
                          ),
                        ),
                ),

              /// Code label
              Row(
                children: const [
                  Text(
                    "Verification Code",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("*", style: TextStyle(color: Colors.red)),
                ],
              ),

              const SizedBox(height: 8),

              /// Code Field
              TextFormField(
                controller: codeController,
                decoration: InputDecoration(
                  hintText: "Enter verification code",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Code is required";
                  }
                  return null;
                },
              ),

              /// Errors
              if (isCodeInvalid)
                _errorText("Invalid Code - The code entered is incorrect."),
              if (isNetError)
                _errorText("Network Error - Please check your connection."),

              const SizedBox(height: 24),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Submit",
                  isLoading: isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      verifyOtpPasswordReset();
                    }
                  },
                  isEnabled: !isRateLimited,
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
    );
  }

  /// Helpers
  TextSpan _boldText(BuildContext context, String text) {
    return TextSpan(
      text: text,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  TextSpan _greyText(BuildContext context, String text) {
    return TextSpan(
      text: text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.grey,
      ),
    );
  }

  Widget _errorText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.error,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _infoText({required String title, required String message}) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: message),
        ],
      ),
    );
  }
}
