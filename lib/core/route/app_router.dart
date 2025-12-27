import 'package:go_router/go_router.dart';
import 'package:hexaarch/splash/splash.dart';
import 'package:hexaarch/views/auth/profile/location.dart';
import 'package:hexaarch/views/auth/profile/set_budget.dart';
import 'package:hexaarch/views/auth/profile/set_profilepic.dart';
import 'package:hexaarch/views/auth/profile/set_property.dart';
import 'package:hexaarch/views/auth/profile/show_profile.dart';
import 'package:hexaarch/views/auth/reset_password/pages/email_to_reset.dart';
import 'package:hexaarch/views/auth/reset_password/pages/recover_password.dart';
import 'package:hexaarch/views/auth/reset_password/pages/reset_password.dart';
import 'package:hexaarch/views/auth/reset_password/pages/reset_success.dart';
import 'package:hexaarch/views/auth/signin/pages/email_signin.dart';
import 'package:hexaarch/views/auth/signup/pages/signup.dart';
import 'package:hexaarch/views/coursal.dart';
import 'package:hexaarch/views/auth/otp/otp.dart';
import 'package:hexaarch/views/auth/signin/pages/number_signin.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(
      path: '/getstart',
      name: 'getstart',
      builder: (context, state) => const HexaCareersLayout(),
    ),
    GoRoute(
      path: '/phonesignin',
      name: 'phonesignin',
      builder: (context, state) => const PhoneSignInScreen(),
    ),
    GoRoute(path: '/otp', name: 'otp', builder: (context, state) => OtpPage()),
    //email signin
    GoRoute(
      path: '/emailsignin',
      name: 'emailsignin',
      builder: (context, state) => const EmailSignInScreen(),
    ),

    GoRoute(
      path: '/forgotpwd',
      name: 'forgotpwd',
      builder: (context, state) => const RecoverPasswordPage(),
    ),
    GoRoute(
      path: '/sendemail',
      name: 'sendemail',
      builder: (context, state) => const SendEmailPage(),
    ),
    GoRoute(
      path: '/resetpwd',
      name: 'resetpwd',
      builder: (context, state) => const ResetPasswordPage(),
    ),
    GoRoute(
      path: '/resetsuccess',
      name: 'resetsuccess',
      builder: (context, state) => const ResetPasswordSuccessPage(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const RegisterScreen(),
    ),
    //set up account
    GoRoute(
      path: '/location',
      name: 'location',
      builder: (context, state) => const LocationScreen(),
    ),
    GoRoute(
      path: '/profilepic',
      name: 'profilepic',
      builder: (context, state) => const ProfilePhotoPage(),
    ),
    GoRoute(
      path: '/showprofile',
      name: 'showprofile',
      builder: (context, state) => const ShowProfile(),
    ),
    GoRoute(
      path: '/propertytype',
      name: 'propertytype',
      builder: (context, state) => const PropertyTypeScreen(),
    ),
    GoRoute(
      path: '/budgetrange',
      name: 'budgetrange',
      builder: (context, state) => const BudgetRangeScreen(),
    ),
    // GoRoute(
    //   path: '/accountsuccess',
    //   name: 'accountsuccess',
    //   builder: (context, state) {
    //     final text = state.extra as String?;
    //     return AccountCreatedPage(text: text ?? '');
    //   },
    // ),
    // GoRoute(
    //   path: '/mywallet',
    //   name: 'mywallet',
    //   builder: (context, state) => const MywalletPage(),
    // ),

    // GoRoute(
    //   path: '/choosepayment',
    //   name: 'choosepayment',
    //   builder: (context, state) => const ChoosePaymentPage(),
    // ),
    // GoRoute(
    //   path: '/referralhistorypage',
    //   name: 'referralhistorypage',
    //   builder: (context, state) {
    //     final subtext = state.extra as String? ?? '';
    //     return ReferralHistoryPage(subtext: subtext);
    //   },
    // ),
    // GoRoute(
    //   path: '/courseitem',
    //   name: 'courseitem',
    //   builder: (context, state) {
    //     final courseitem = state.extra as Map<String, dynamic>;

    //     return ShowCourseItem(courseItem: courseitem);
    //   },
    // ),
    // GoRoute(
    //   path: '/sessionitem',
    //   name: 'sessionitem',
    //   builder: (context, state) {
    //     final courseitem = state.extra as Map<String, dynamic>;

    //     return ShowSession(sessionItem: courseitem);
    //   },
    // ),
    //for pages with custom appbar
    // ShellRoute(
    //   builder: (context, state, child) {
    //     return DefaultPage();
    //   },
    //   routes: [
    //     GoRoute(
    //       path: '/overview',
    //       name: 'overview',
    //       builder: (context, state) => const OverviewPage(),
    //     ),
    //     GoRoute(
    //       path: '/explore',
    //       name: 'explore',
    //       builder: (context, state) => const ExploreSessions(),
    //     ),
    //     GoRoute(
    //       path: '/mycourse',
    //       name: 'mycourse',
    //       builder: (context, state) => const Mycourse(),
    //     ),
    //     GoRoute(
    //       path: '/todo',
    //       name: 'todo',
    //       builder: (context, state) => const TodoPage(),
    //     ),
    //     GoRoute(
    //       path: '/attendence',
    //       name: 'attendence',
    //       builder: (context, state) => const Attendence(),
    //     ),
    //     GoRoute(
    //       path: '/notes',
    //       name: 'notes',
    //       builder: (context, state) => const NotesPage(),
    //     ),

    //     GoRoute(
    //       path: '/assignment',
    //       name: 'assignment',
    //       builder: (context, state) => const AssignmentPage(),
    //     ),
    //     GoRoute(
    //       path: '/messages',
    //       name: 'messages',
    //       builder: (context, state) => const Messages(),
    //     ),
    //     GoRoute(
    //       path: '/certificates',
    //       name: 'certificates',
    //       builder: (context, state) => const Certificates(),
    //     ),
    //     GoRoute(
    //       path: '/refer',
    //       name: 'refer',
    //       builder: (context, state) => const ReferAndEarnPage(),
    //     ),
    //     GoRoute(
    //       path: '/terms',
    //       name: 'terms',
    //       builder: (context, state) => const TermsPage(),
    //     ),
    //     GoRoute(
    //       path: '/privacy',
    //       name: 'privacy',
    //       builder: (context, state) => const PrivacyPage(),
    //     ),
    //     GoRoute(
    //       path: '/fav',
    //       name: 'fav',
    //       builder: (context, state) => const Favourites(),
    //     ),
    //     GoRoute(
    //       path: '/noti',
    //       name: 'noti',
    //       builder: (context, state) => const NotificationPage(),
    //     ),
    //   ],
    // ),
  ],
);
