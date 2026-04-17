// =============================================================================
// APP SCOPE — DEPENDENCY INJECTION GUIDE
// -----------------------------------------------------------------------------
// InheritedWidget that exposes shared services to the widget tree.
//
// [A] Add new dependencies as fields + constructor params
// [B] Expose them via static `of(BuildContext)` (pattern match existing)
//
// No layout sizes here — only wiring. Edit repository type / name if you split
// onboarding storage.
// =============================================================================

import 'package:flutter/widgets.dart';

import '../../features/onboarding/domain/onboarding_repository.dart';

/// Provides app-wide dependencies without a third-party DI package.
final class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.onboardingRepository,
    required super.child,
  });

  final OnboardingRepository onboardingRepository;

  static OnboardingRepository of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found above this context');
    return scope!.onboardingRepository;
  }

  @override
  bool updateShouldNotify(covariant AppScope oldWidget) =>
      oldWidget.onboardingRepository != onboardingRepository;
}
