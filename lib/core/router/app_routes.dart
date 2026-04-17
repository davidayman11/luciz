// =============================================================================
// APP ROUTES — NAMED PATHS GUIDE
// -----------------------------------------------------------------------------
// Strings used in MaterialApp.routes. Keep in sync with Navigator.push calls.
//
// [A] Edit path segments only if you change deep linking / web routes.
// =============================================================================

/// Named routes for [MaterialApp.routes].
abstract final class AppRoutes {
  static const onboarding = '/onboarding'; // ← edit: onboarding path
  static const home = '/home'; // ← edit: home path
  static const selectLanguage = '/select-language'; // ← edit
  static const signUp = '/sign-up'; // ← edit
  static const login = '/login'; // ← edit
  static const otp = '/otp'; // ← edit
}
