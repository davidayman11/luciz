// =============================================================================
// ONBOARDING REPOSITORY — DOMAIN PORT GUIDE
// -----------------------------------------------------------------------------
// Abstract API implemented in data/onboarding_repository_impl.dart.
//
// [A] Add methods here when onboarding needs more persisted state
// [B] Keep implementations free of Flutter imports (domain rule)
//
// No layout sizes here.
// =============================================================================

/// Persistence for whether the user has finished onboarding.
abstract interface class OnboardingRepository {
  Future<bool> isOnboardingComplete();

  Future<void> markOnboardingComplete();
}
