import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/di/app_scope.dart';
import '../../../../core/responsive/luciz_scale.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/luciz_colors.dart';
import '../../../../core/widgets/luciz_primary_button.dart';
import '../../../auth/presentation/pages/login_page.dart';

// =============================================================================
// ONBOARDING — LAYOUT GUIDE
// -----------------------------------------------------------------------------
// Same `// =============================================================================` + `// ← edit:` style as other `lib/**` app files.
// All numbers like s.w(24) use design pixels at 390×844; LucizScale maps them
// to the real device. Edit the number inside s.w / s.h / s.r / s.font only.
//
// Sections in this file (search for the banner comments):
//   [A] Screen & page padding
//   [B] Image (illustration) height
//   [C] Vertical gaps: image → title → body → footer
//   [D] Title & body typography
//   [E] Page dots (pagination)
//   [F] Primary button → LucizPrimaryButton (core/widgets)
//   [G] Footer outer padding
// =============================================================================

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const routeName = AppRoutes.onboarding;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _index = 0;

  static const _pages = <_OnboardPage>[
    _OnboardPage(
      asset: 'assets/images/on1.svg',
      title: 'Delicious food, anytime',
      body:
          'Explore a wide variety of burgers, meals, and flavors made to satisfy every craving.',
    ),
    _OnboardPage(
      asset: 'assets/images/on2.svg',
      title: 'Your order, your Way',
      body:
          'Choose how you enjoy your meal, dine in, pick up, or get it delivered wherever you are.',
    ),
    _OnboardPage(
      asset: 'assets/images/on3.svg',
      title: 'Fast & fresh delivery',
      body:
          'Enjoy quick delivery with your food arriving hot, fresh, and right on time.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onGetStarted() async {
    if (_index < _pages.length - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
      return;
    }

    await AppScope.of(context).markOnboardingComplete();
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const LoginPage()),
    );
  }

  double _clamp(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = LucizScale.of(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    // --- [A] SCREEN & PAGE PADDING -----------------------------------------
    // Horizontal: fraction of width, clamped between min and max (design px).
    final horizontalPadding = _clamp(
      screenWidth * 0.064,
      s.w(20), // ← edit: min horizontal inset
      s.w(24), // ← edit: max horizontal inset
    );
    // Top: fraction of height, clamped (design px).
    final topPadding = _clamp(
      screenHeight * 0.015,
      s.h(10), // ← edit: min top inset
      s.h(16), // ← edit: max top inset
    );

    // --- [C] VERTICAL GAPS (design px, use s.h) ----------------------------
    final imageToTextSpacing = s.h(24); // ← edit: space under illustration
    final titleToBodySpacing = s.h(10); // ← edit: space title → body
    final textToButtonSpacing =
        s.h(150); // ← edit: space body block → dots/button area

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, viewportConstraints) {
                  // Inner height available to the page after [A] padding.
                  final innerH = viewportConstraints.maxHeight -
                      topPadding -
                      s.h(8); // ← edit: bottom inset of page content (design px)

                  // --- [B] IMAGE (ILLUSTRATION) HEIGHT ---------------------
                  // Uses innerH * fraction, clamped between min and max height.
                  final imageHeight = _clamp(
                    innerH * 0.34, // ← edit: fraction of inner height (0–1)
                    s.h(220), // ← edit: min image height
                    s.h(320), // ← edit: max image height
                  );

                  return PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (i) => setState(() => _index = i),
                    itemBuilder: (context, i) {
                      final p = _pages[i];

                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          topPadding,
                          horizontalPadding,
                          s.h(8), // ← edit: page bottom padding (above scroll)
                        ),
                        child: Column(
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: imageHeight,
                              child: SvgPicture.asset(
                                p.asset,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                padding: EdgeInsets.zero,
                                child: Column(
                                  children: [
                                    SizedBox(height: imageToTextSpacing),
                                    // --- [D] TITLE TYPOGRAPHY ----------------
                                    Text(
                                      p.title,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.headlineMedium
                                          ?.copyWith(
                                        // Responsive size: width * factor,
                                        // clamped between min/max (design px).
                                        fontSize: _clamp(
                                          screenWidth *
                                              0.053, // ← edit: width factor
                                          s.font(18), // ← edit: min title size
                                          s.font(20), // ← edit: max title size
                                        ),
                                        fontWeight:
                                            FontWeight.w500, // ← edit: title weight
                                        color: LucizColors.brandRed,
                                        letterSpacing:
                                            -0.2, // ← edit: title tracking
                                      ),
                                    ),
                                    SizedBox(height: titleToBodySpacing),
                                    // --- [D] BODY TYPOGRAPHY -----------------
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth *
                                            0.03, // ← edit: body side inset (% of width)
                                      ),
                                      child: Text(
                                        p.body,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                          fontSize: _clamp(
                                            screenWidth *
                                                0.04, // ← edit: width factor
                                            s.font(14), // ← edit: min body size
                                            s.font(15), // ← edit: max body size
                                          ),
                                          height:
                                              1.45, // ← edit: body line height
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: textToButtonSpacing),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // --- [G] FOOTER OUTER PADDING ------------------------------------
            Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                0,
                horizontalPadding,
                s.h(20), // ← edit: space under button to bottom safe area
              ),
              child: Column(
                children: [
                  // --- [E] PAGE DOTS -----------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (i) {
                      final active = i == _index;
                      final dot = s.r(8); // ← edit: dot diameter (design px)
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.symmetric(
                          horizontal: s.w(4),
                        ), // ← edit: gap between dots
                        width: dot,
                        height: dot,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: active
                              ? LucizColors.brandRed
                              : LucizColors.dotInactive,
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: s.h(18),
                  ), // ← edit: space dots → button
                  // --- [F] PRIMARY CTA (shared LucizPrimaryButton) ------------
                  LucizPrimaryButton(
                    label: _index == _pages.length - 1
                        ? 'Get Started'
                        : 'Next', // ← edit: labels
                    onPressed: _onGetStarted,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardPage {
  const _OnboardPage({
    required this.asset,
    required this.title,
    required this.body,
  });

  final String asset;
  final String title;
  final String body;
}
