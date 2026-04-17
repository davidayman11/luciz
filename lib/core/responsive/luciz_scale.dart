// =============================================================================
// LUCIZ SCALE — RESPONSIVE DESIGN GUIDE
// -----------------------------------------------------------------------------
// Maps design pixels from [designSize] to the device using MediaQuery.
//
// [A] designSize — change if your Figma/Sketch artboard size differs
// [B] w() — horizontal spacing & widths
// [C] h() — vertical spacing & heights
// [D] r() — radii, dots (uses min of width/height scale)
// [E] font() — text size (width scale × TextScaler for accessibility)
//
// In UI files, only change the numeric argument: s.w(24) → s.w(28), etc.
// =============================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Maps “design px” from [designSize] to the current device using
/// [MediaQuery] width/height and system [TextScaler] (accessibility).
final class LucizScale {
  LucizScale._(this._context);

  /// Reference artboard (logical px). ← edit if your design baseline changes
  static const Size designSize = Size(390, 844);

  factory LucizScale.of(BuildContext context) => LucizScale._(context);

  final BuildContext _context;

  Size get _screen => MediaQuery.sizeOf(_context);

  double get _wScale => _screen.width / designSize.width;
  double get _hScale => _screen.height / designSize.height;

  /// Horizontal spacing (margins, widths) from design px.
  double w(double designPx) => designPx * _wScale;

  /// Vertical spacing (gaps, heights) from design px.
  double h(double designPx) => designPx * _hScale;

  /// Radii, dots, strokes — uses the smaller axis so tablets stay balanced.
  double r(double designPx) => designPx * math.min(_wScale, _hScale);

  /// Typography: scales with width and respects the user’s text scale.
  double font(double designPx) =>
      MediaQuery.textScalerOf(_context).scale(designPx * _wScale);
}
