// =============================================================================
// LUCIZ APP — SHELL GUIDE
// -----------------------------------------------------------------------------
// [A] MaterialApp: title, theme, initial route, named routes
// [B] AppScope: global dependencies (onboarding repository)
//
// For colors / fonts / text sizes used everywhere, see core/theme/app_theme.dart
// and core/theme/luciz_colors.dart. Edit values marked ← edit below.
// =============================================================================

import 'package:flutter/material.dart';

import '../core/router/app_routes.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/otp_verification_page.dart';
import '../features/auth/presentation/pages/select_language_page.dart';
import '../features/auth/presentation/pages/sign_up_page.dart';
import '../features/home/presentation/pages/home_screen.dart';
import '../features/onboarding/domain/onboarding_repository.dart';
import '../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../features/splash/presentation/pages/splash_screen.dart';
import 'di/app_scope.dart';

class LucizApp extends StatelessWidget {
  const LucizApp({
    super.key,
    required this.onboardingRepository,
  });

  final OnboardingRepository onboardingRepository;

  @override
  Widget build(BuildContext context) {
    return AppScope(
      onboardingRepository: onboardingRepository,
      child: MaterialApp(
        title: "Luci'z", // ← edit: OS task switcher / web tab title
        debugShowCheckedModeBanner: false, // ← edit: set true for debug banner
        theme: buildLucizTheme(),
        home: const SplashScreen(), // ← edit: first screen after cold start
        routes: {
          AppRoutes.onboarding: (_) => const OnboardingScreen(),
          AppRoutes.home: (_) => const HomeScreen(),
          AppRoutes.selectLanguage: (_) => const SelectLanguagePage(),
          AppRoutes.signUp: (_) => const SignUpPage(),
          AppRoutes.login: (_) => const LoginPage(),
          AppRoutes.otp: (context) {
            final phone = ModalRoute.of(context)?.settings.arguments as String? ??
                '';
            return OtpVerificationPage(phoneDisplay: phone);
          },
        },
      ),
    );
  }
}
