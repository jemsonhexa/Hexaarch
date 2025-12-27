// // lib/views/layouts/buildMobilePortrait.dart
// // ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

// import 'package:flutter/material.dart';

// Widget buildMobilePortrait({
//   required String currentView,
//   required Function(String) switchView,
//   required BuildContext context,
// }) {
//   return Container(
//     color: Colors.white,
//     child: SingleChildScrollView(
//       // controller: scrollController,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           children: [
//             // Display the current view dynamically
//             if (currentView == 'inactivateaccount')
//               InactiveView(onSwitchView: switchView),
//             if (currentView == 'signup') SignUpView(onSwitchView: switchView),
//             if (currentView == 'signin') SignInEmail(onSwitchView: switchView),
//             if (currentView == 'signinwithphone')
//               SignInPhone(onSwitchView: switchView),
//             if (currentView == 'otp') OtpPage(onSwitchView: switchView),
//             if (currentView == 'resetpassword')
//               FirstScreenResetPassword(onSwitchView: switchView),
//             if (currentView == 'resetpassword2')
//               ResetPasswordView(onSwitchView: switchView),
//             if (currentView == 'passwordresetsuccess')
//               Passwordresetsuccess(onSwitchView: switchView),
//             if (currentView == 'reenteremail')
//               Reenteremail(onSwitchView: switchView),
//             if (currentView == 'checkphone')
//               CheckPhoneTexts(onSwitchView: switchView),
//             if (currentView == 'recoverpassword')
//               RecoverPasswordPage(onSwitchView: switchView),
//             if (currentView == 'verifyidentity')
//               VerifyIdentityPage(onSwitchView: switchView),
//             if (currentView == 'checkmail')
//               CheckmailPage(onSwitchView: switchView),
//           ],
//         ),
//       ),
//     ),
//   );
// }
