// =============================================================================
// LUCIZ COLORS — DESIGN TOKENS GUIDE
// -----------------------------------------------------------------------------
// Central hex values. Prefer editing here over scattering Color(0xFF…) in UI.
//
// [A] Brand & text
// [B] UI accents (dots, borders, etc.)
// [C] Auth form fields
//
// After changes, hot restart may be needed for const colors.
// =============================================================================

import 'package:flutter/material.dart';

abstract final class LucizColors {
  // --- [A] BRAND & TEXT -----------------------------------------------------
  static const Color brandRed = Color(0xFFE31E24); // ← edit: primary brand
  static const Color bodyGrey = Color(0xFF4A4A4A); // ← edit: default body text

  // --- [B] ACCENTS ----------------------------------------------------------
  static const Color dotInactive = Color(0xFFD0D0D0); // ← edit: inactive dots

  // --- [C] AUTH INPUTS (sign up / login / language rows) --------------------
  static const Color inputFill = Color(0xFFF9F9F9); // ← edit: field / row fill
  static const Color inputBorder = Color(0xFFE0E0E0); // ← edit: field border
  static const Color titleBlack = Color(0xFF1A1A1A); // ← edit: dark titles (OTP)
}
