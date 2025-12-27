import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexaarch/core/route/app_router.dart';
import 'package:hexaarch/themes/app_themes.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (_, _) => const MyApp(),
      ),
    ),
  );

  FlutterNativeSplash.remove(); // removes immediately
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 844),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(1.0)),
          child: MaterialApp.router(
            theme: AppThemes.lightTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            title: 'Hexaarch',
          ),
        );
      },
    );
  }
}
