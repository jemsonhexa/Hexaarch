import 'package:flutter/material.dart';
import 'package:hexaarch/themes/color_scheme.dart';
import 'package:pinput/pinput.dart';

class OTPInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function(String)? onCompleted;

  const OTPInputField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(fontSize: 22, color: AppColors.black),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey),
      ),
    );

    return Pinput(
      length: 4,
      controller: controller,
      focusNode: focusNode,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: AppColors.black),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: AppColors.grey),
        ),
      ),
      onCompleted: onCompleted,
    );
  }
}
