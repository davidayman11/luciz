// =============================================================================
// AUTH LOGO HEADER — GUIDE
// -----------------------------------------------------------------------------
// [A] Logo frame (design px): 343 × 184 — scales down if content width is less
// [B] Scales with [LucizScale] baseline 390×844
//
// Edit ← edit markers only.
// =============================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/responsive/luciz_scale.dart';

/// Logo for auth screens (same asset as splash).
class AuthLogoHeader extends StatelessWidget {
  const AuthLogoHeader({super.key});

  static const double _designLogoW = 343; // ← edit: [A] design width (px)
  static const double _designLogoH = 184; // ← edit: [A] design height (px)

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final designW = s.w(_designLogoW);
        final designH = s.h(_designLogoH);
        final maxW = constraints.maxWidth;
        final w = maxW.isFinite ? math.min(designW, maxW) : designW;
        final h = designH * (w / designW);
        return SizedBox(
          width: double.infinity,
          height: h,
          child: Center(
            child: SizedBox(
              width: w,
              height: h,
              child: SvgPicture.asset(
                'assets/images/luciz_logo.svg',
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
