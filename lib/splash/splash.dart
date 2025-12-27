import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'dart:async';

import 'package:hexaarch/themes/color_scheme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _moveToCenterAnimation;

  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ), // Adjust for desired animation speed
    );

    // Animation to move from bottom center to center
    _moveToCenterAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Bottom center
      end: const Offset(0, 0), // Center
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Fade-in animation for the text
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    // Navigate to the next page after the animation
    Timer(const Duration(seconds: 3), _checkOnboardingStatus);
  }

  void _checkOnboardingStatus() async {
    context.go('/getstart');
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool onboardingSeen = prefs.getBool('onboardingSeen') ?? false;
    // bool loggedIn = prefs.getBool('loggedIn') ?? false;
    // bool? verifieduser = prefs.getBool('verifieduser');

    // if (mounted) {
    //   if (onboardingSeen) {
    //     if (loggedIn) {
    //       context.go('/home');
    //     } else if (verifieduser == false) {
    //       context.go('/onboarding');
    //     } else {
    //       context.goNamed('login');
    //     }
    //   } else {
    //     context.go('/getstartpage');
    //   }
    // }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Image and Text moving animation
          SlideTransition(
            position: _moveToCenterAnimation,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/splash.png',
                    width: 200,
                    height: 250,
                  ),
                  // SizedBox(
                  //   width: 80,
                  //   height: 80,
                  //   child: ResponsiveImageAsset(assetPath: 'assets/images/customsplashlogo.png')),
                  //  SvgPicture.asset('assets/svg/logo.svg'),
                  // FadeTransition(
                  //   opacity: _fadeAnimation,
                  //   child: Padding(
                  //     padding: EdgeInsets.only(top: 16.0),
                  //     child: Text(
                  //       "HexaServices",
                  //       style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  //         color: AppColors.primaryColor,
                  //         fontSize: getResponsiveFontSize(
                  //           context,
                  //           defaultFontSize: 32,
                  //           widePortraitFontSize: 26,
                  //         ),
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
