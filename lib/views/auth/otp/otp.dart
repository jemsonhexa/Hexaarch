// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/common/widgets/buttons/custom_button.dart';
import 'package:hexaarch/constants/snackbar.dart';
import 'package:hexaarch/themes/color_scheme.dart';
import 'package:hexaarch/utils/mediaquery.dart';
import 'package:hexaarch/views/auth/otp/otp_input.dart';
import 'package:hexaarch/views/auth/signup/provider/phone_num_provider.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({super.key});

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  bool _isverifying = false;
  bool isTextNotEmpty = false;

  @override
  void initState() {
    super.initState();

    _otpController.addListener(_handlePhoneInputChange);
  }

  void _handlePhoneInputChange() {
    setState(() {
      isTextNotEmpty = _otpController.text.length == 4;
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void verifyOtp(String otp, BuildContext context) async {
    setState(() => _isverifying = true);
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isverifying = false);

    if (otp == '1234') {
      context.push('/otpgifcheck');
    } else {
      customshowSnackBar(context, "Invalid OTP", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final phone = ref.watch(phoneNumberProvider) ?? "";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm your number'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Enter the code that was sent to your phone number ',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Colors.grey,
                                fontSize: getResponsiveFontSize(
                                  context,
                                  defaultFontSize: 18,
                                  widePortraitFontSize: 14,
                                ),
                              ),
                        ),
                        TextSpan(
                          text: phone,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontSize: getResponsiveFontSize(
                                  context,
                                  defaultFontSize: 20,
                                  widePortraitFontSize: 14,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      OTPInputField(
                        controller: _otpController,
                        // onCompleted: (value) => verifyOtp(value, context),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Haven't recieved any SMS?"),
                      TextButton(
                        onPressed: () {
                          // context.push('/cleaningservice');
                          customshowSnackBar(
                            context,
                            "OTP resend successfully",
                            Colors.green,
                          );
                        },
                        child: Text(
                          "Send again",
                          style: TextStyle(color: AppColors.black),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Align(
                    alignment: AlignmentGeometry.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        _otpController.clear();
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Text(
                        "Clear All",
                        style: TextStyle(color: AppColors.black),
                      ),
                    ),
                  ),

                  /// Continue Button
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Continue',
                      //   isLoading: isLoading,
                      isEnabled: isTextNotEmpty,
                      color: AppColors.primaryColor,
                      textColor: AppColors.white,
                      defaultFontSize: 18,
                      widePortraitFontSize: 12,
                      borderRadius: 8,
                      onPressed: () async {
                        verifyOtp(_otpController.text, context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isverifying)
            Container(
              color: Colors.black.withValues(alpha: .4),
              child: const Center(
                child: SpinKitThreeBounce(color: Colors.black, size: 30),
              ),
            ),
        ],
      ),
    );
  }
}
