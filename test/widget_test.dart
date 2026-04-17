// =============================================================================
// WIDGET TESTS — GUIDE
// -----------------------------------------------------------------------------
// [A] Pump the widget under test (LucizApp + fake repo here)
// [B] Advance time for splash delay (must match splash_screen duration)
//
// Edit pump durations if splash delay changes in lib/features/splash/...
// =============================================================================

import 'package:flutter_test/flutter_test.dart';

import 'package:luciz/app/luciz_app.dart';
import 'package:luciz/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:luciz/features/splash/presentation/pages/splash_screen.dart';

import 'fakes/fake_onboarding_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('shows splash then leaves splash', (WidgetTester tester) async {
    await tester.pumpWidget(
      LucizApp(
        onboardingRepository: FakeOnboardingRepository(complete: false),
      ),
    );
    expect(find.byType(SplashScreen), findsOneWidget);

    // --- [B] MATCH SPLASH DELAY ---------------------------------------------
    await tester.pump(const Duration(seconds: 4)); // ← edit if splash delay changes
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(SplashScreen), findsNothing);
    expect(find.byType(OnboardingScreen), findsOneWidget);
  });
}
