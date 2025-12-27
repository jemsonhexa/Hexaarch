import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexaarch/common/widgets/inputfields/textfield.dart';
import 'package:hexaarch/themes/color_scheme.dart';
import 'package:hexaarch/utils/mediaquery.dart';

Widget buildInputField(
  BuildContext context,
  String label,
  String hint,
  TextInputType keyBoardType,
  TextEditingController controller, {
  bool isPassword = false,
  void Function(String)? onChanged,
  String? Function(String?)? validator,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12.h),
    child: CustomEditTextField(
      labelText: label,
      hintText: hint,
      controller: controller,
      obscureText: isPassword,
      showToggleIcon: isPassword,
      keyBoardType: keyBoardType,
      inputformatters: inputFormatters,
      onTextChanged: onChanged,
      validator: validator,
      labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: getResponsiveFontSize(
          context,
          defaultFontSize: 14,
          widePortraitFontSize: 10,
        ),
        letterSpacing: -0.5,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget buildErrorText(BuildContext context, title, String message) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: RichText(
      text: TextSpan(
        text: "$title - ",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.error,
          fontWeight: FontWeight.bold,
          fontSize: getResponsiveFontSize(
            context,
            defaultFontSize: 12,
            widePortraitFontSize: 8,
          ),
        ),
        children: [
          TextSpan(
            text: message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: getResponsiveFontSize(
                context,
                defaultFontSize: 12,
                widePortraitFontSize: 8,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
