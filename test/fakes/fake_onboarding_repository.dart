// =============================================================================
// FAKE ONBOARDING REPOSITORY — TEST DOUBLE GUIDE
// -----------------------------------------------------------------------------
// [A] Default `complete` flag for tests
// [B] Toggle behavior in markOnboardingComplete
//
// Used by test/widget_test.dart. No production imports from lib UI.
// =============================================================================

import 'package:luciz/features/onboarding/domain/onboarding_repository.dart';

/// Test double with controllable completion flag.
final class FakeOnboardingRepository implements OnboardingRepository {
  FakeOnboardingRepository({this.complete = false}); // ← edit: [A] default

  bool complete;

  @override
  Future<bool> isOnboardingComplete() async => complete;

  @override
  Future<void> markOnboardingComplete() async {
    complete = true; // ← edit: [B] simulate persisted “done”
  }
}
