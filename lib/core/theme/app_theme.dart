// =============================================================================
// APP THEME — GLOBAL TYPOGRAPHY & COLORSCHEME GUIDE
// -----------------------------------------------------------------------------
// [A] ColorScheme.fromSeed (Material 3)
// [B] fontFamily for the whole app
// [C] textTheme defaults (per-style weight, size is often overridden in screens)
//
// Screen-specific sizes usually use LucizScale in widgets; this file sets the
// baseline theme. Edit values marked ← edit.
// =============================================================================

import 'package:flutter/material.dart';

import 'luciz_colors.dart';

ThemeData buildLucizTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: LucizColors.brandRed, // ← edit: seed drives generated scheme
      primary: LucizColors.brandRed,
      surface: Colors.white, // ← edit: default scaffold/surface color
    ),
    fontFamily: 'Alexandria', // ← edit: must match pubspec font family name
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontFamily: 'Alexandria',
        fontWeight: FontWeight.w700, // ← edit: default headline weight
        color: LucizColors.brandRed,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Alexandria',
        fontWeight: FontWeight.w400, // ← edit: default body weight
        color: LucizColors.bodyGrey,
        height: 1.45, // ← edit: default body line height
      ),
      labelLarge: TextStyle(
        fontFamily: 'Alexandria',
        fontWeight: FontWeight.w600, // ← edit: default button label weight
        color: Colors.white,
      ),
    ),
  );
}
