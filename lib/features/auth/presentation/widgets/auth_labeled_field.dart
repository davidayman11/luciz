// =============================================================================
// AUTH LABELED FIELD — GUIDE
// -----------------------------------------------------------------------------
// Label above + [LucizAuthTextField] (shared core widget).
//
// [A] Label typography
// [B] Label → field gap
// =============================================================================

import 'package:flutter/material.dart';

import '../../../../core/responsive/luciz_scale.dart';
import '../../../../core/theme/luciz_colors.dart';
import '../../../../core/widgets/luciz_auth_text_field.dart';

class AuthLabeledField extends StatelessWidget {
  const AuthLabeledField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.suffix,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Alexandria',
            fontSize: s.font(14), // ← edit: [A] label size (design px)
            fontWeight: FontWeight.w500,
            color: LucizColors.bodyGrey,
          ),
        ),
        SizedBox(height: s.h(8)), // ← edit: [B] label → field gap
        LucizAuthTextField(
          controller: controller,
          hint: hint,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          suffix: suffix,
        ),
      ],
    );
  }
}
