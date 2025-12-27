import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/common/widgets/appbar.dart';
import 'package:hexaarch/common/widgets/buttons/custom_button.dart';
import 'package:hexaarch/themes/color_scheme.dart';

class ResetPasswordSuccessPage extends StatelessWidget {
  const ResetPasswordSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(context, 'Reset Password'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),

            /// Description text
            Text(
              "Your password has been successfully reset.\n"
              "Please log in with the updated password to continue.",
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.5),
            ),

            const SizedBox(height: 30),

            /// Success banner
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  "Password Reset Successful",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            /// Login button
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Login",
                // isLoading: isLoading,
                onPressed: () {
                  context.go('/emailsignin');
                },

                isEnabled: true,
                color: AppColors.primaryColor,
                textColor: AppColors.white,
                defaultFontSize: 18,
                widePortraitFontSize: 11,
                borderRadius: 10,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
