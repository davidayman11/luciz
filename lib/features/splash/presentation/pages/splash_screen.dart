// =============================================================================
// SPLASH SCREEN — LAYOUT GUIDE
// -----------------------------------------------------------------------------
// [A] Delay before navigating away
// [B] Background color
// [C] Logo horizontal padding (design px via LucizScale)
// [D] Logo: [AuthLogoHeader] (343×184 design frame, same as login / sign up / lang)
// =============================================================================

import 'package:flutter/material.dart';

import '../../../../core/responsive/luciz_scale.dart';
import '../../../auth/presentation/widgets/auth_logo_header.dart';
import '../../../onboarding/presentation/pages/onboarding_screen.dart';

/// Full-screen splash: logo for 4 seconds, then onboarding.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  Future<void> _goNext() async {
    // --- [A] SPLASH DURATION -------------------------------------------------
    await Future<void>.delayed(
      const Duration(seconds: 4), // ← edit: seconds before next route
    );
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    return Scaffold(
      backgroundColor: Colors.white, // ← edit: splash background
      body: Center(
        child: Padding(
          // --- [C] LOGO SIDE PADDING --------------------------------------
          padding: EdgeInsets.symmetric(
            horizontal: s.w(48), // ← edit: logo left/right inset (design px)
          ),
          child: const AuthLogoHeader(), // ← [D] same 343×184 frame as auth
        ),
      ),
    );
  }
}
