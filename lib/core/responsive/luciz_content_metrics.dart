// =============================================================================
// LUCIZ CONTENT METRICS — SHARED PADDING & BUTTON WIDTH GUIDE
// -----------------------------------------------------------------------------
// [A] Horizontal padding for screens that share the same edge rhythm (auth,
//     onboarding footer, etc.)
// [B] Primary CTA width cap (343 design px) and height (40 design px)
// [C] Auth text rows + language rows (same height as password field)
//
// Import this from any feature; keep numbers in sync with design.
// =============================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'luciz_scale.dart';

abstract final class LucizContentMetrics {
  static double horizontalPadding(BuildContext context) {
    final s = LucizScale.of(context);
    final w = MediaQuery.sizeOf(context).width;
    return (w * 0.064).clamp(s.w(20), s.w(24)); // ← edit: min / max (design px)
  }

  /// Max width for the 343×40 primary button inside padded content.
  static double primaryButtonWidth(BuildContext context) {
    final s = LucizScale.of(context);
    final pad = horizontalPadding(context);
    final w = MediaQuery.sizeOf(context).width;
    return math.min(s.w(343), w - pad * 2); // ← edit: 343 = design button width
  }

  static double primaryButtonHeight(BuildContext context) {
    return LucizScale.of(context).h(40); // ← edit: design button height
  }

  /// Height for auth [TextField] rows and language tiles (design 48, scaled).
  static double authInputRowHeight(BuildContext context) {
    return LucizScale.of(context).h(48); // ← edit: [C] must match password row
  }

  /// Trailing slot width for suffix icons (visibility, etc.).
  static double authInputSuffixWidth(BuildContext context) {
    return LucizScale.of(context).w(48); // ← edit: [C] design px
  }
}
