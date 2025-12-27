import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hexaarch/themes/color_scheme.dart';
import 'package:hexaarch/common/widgets/buttons/iconbutton.dart';

Widget emailSignInButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ButtonwithIcon(
      label: 'Sign In with Email',
      onTap: () => context.go('/emailsignin'),
      textColor: AppColors.black,
      iconColor: AppColors.black,
      borderColor: AppColors.grey,
      icon: Icons.mail_outline,
      iconOnLeft: true,
      borderRadius: 8,
      defaultFontSize: 14,
      widePortraitFontSize: 10,
    ),
  );
}

Widget phonenumberSignInButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ButtonwithIcon(
      label: 'Sign In With Number',
      onTap: () => context.go('/phonesignin'),
      textColor: AppColors.black,
      iconColor: AppColors.black,
      borderColor: AppColors.grey,
      icon: Icons.phone_android,
      iconOnLeft: true,
      borderRadius: 8,
      defaultFontSize: 14,
      widePortraitFontSize: 10,
    ),
  );
}

Widget googleSignInButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ButtonwithIcon(
      label: 'Sign In with Google',
      onTap: () {
        context.goNamed('overview', extra: 'Home');
      },
      textColor: AppColors.black,
      iconColor: AppColors.black,
      borderColor: AppColors.grey,
      svgIcon: SvgPicture.asset('assets/svg/google.svg'),
      iconOnLeft: true,
      borderRadius: 8,
      defaultFontSize: 14,
      widePortraitFontSize: 10,
    ),
  );
}

Widget fbSignInButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ButtonwithIcon(
      label: 'Sign In with Facebook',
      onTap: () {
        //  context.goNamed('overview', extra: 'Home');
      },
      textColor: AppColors.white,
      iconColor: AppColors.white,
      borderColor: AppColors.grey,
      fillColor: Colors.blue,
      icon: Icons.facebook,
      iconOnLeft: true,
      borderRadius: 8,
      defaultFontSize: 14,
      widePortraitFontSize: 10,
    ),
  );
}

Widget appleSignInButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: ButtonwithIcon(
      label: 'Sign In With Apple',
      onTap: () {
        //  context.goNamed('overview', extra: 'Home');
      },
      textColor: AppColors.white,
      iconColor: AppColors.white,
      fillColor: AppColors.black,
      icon: Icons.apple,
      iconOnLeft: true,
      borderRadius: 8,
      defaultFontSize: 14,
      widePortraitFontSize: 10,
    ),
  );
}

Widget signUpButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("You don’t have an account?"),
      TextButton(
        onPressed: () {
          context.push('/signup');
        },
        child: Text("Sign up", style: TextStyle(color: AppColors.primaryColor)),
      ),
    ],
  );
}
