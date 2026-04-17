// =============================================================================
// ONBOARDING REPOSITORY — STORAGE GUIDE
// -----------------------------------------------------------------------------
// [A] SharedPreferences key — changing it resets “onboarding done” for users
// [B] getBool / setBool logic (extend if you add steps or version the flow)
//
// No UI sizes here.
// =============================================================================

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/onboarding_repository.dart';

final class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  /// [A] Persistence key. ← edit only if you need a fresh onboarding flag name
  static const _key = 'onboarding_done';

  @override
  Future<bool> isOnboardingComplete() async =>
      _prefs.getBool(_key) ?? false;

  @override
  Future<void> markOnboardingComplete() async {
    await _prefs.setBool(_key, true);
  }
}
