// =============================================================================
// MAIN — APP ENTRY GUIDE
// -----------------------------------------------------------------------------
// [A] Device orientation lock
// [B] SharedPreferences bootstrap (used by onboarding persistence)
// [C] Root widget: LucizApp + repository wiring
//
// Edit only the values marked with ← edit below.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/luciz_app.dart';
import 'features/onboarding/data/onboarding_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // --- [A] ORIENTATION ------------------------------------------------------
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // ← edit: allow / disallow orientations
    DeviceOrientation.portraitDown,
  ]);

  // --- [B] LOCAL STORAGE ---------------------------------------------------
  final prefs = await SharedPreferences.getInstance();

  // --- [C] RUN APP ----------------------------------------------------------
  runApp(
    LucizApp(
      onboardingRepository: OnboardingRepositoryImpl(prefs),
    ),
  );
}
