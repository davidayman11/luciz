// =============================================================================
// LUCIZ PRIMARY BUTTON — SHARED CTA WIDGET
// -----------------------------------------------------------------------------
// One place for the red343×40 (scaled) pill used on onboarding, auth, etc.
//
// [A] label / onPressed
// [B] Colors (brand fill, white label)
// [C] Corner radius, label font size & weight
//
// Width uses [LucizContentMetrics.primaryButtonWidth] so it never overflows
// the standard horizontal padding.
// =============================================================================

import 'package:flutter/material.dart';

import '../responsive/luciz_content_metrics.dart';
import '../responsive/luciz_scale.dart';
import '../theme/luciz_colors.dart';

class LucizPrimaryButton extends StatelessWidget {
  const LucizPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.labelFontSize,
    this.labelFontWeight,
  });

  final String label;
  final VoidCallback? onPressed;

  /// Design px for label (scaled via [LucizScale.font]). Default 17.
  final double? labelFontSize;

  final FontWeight? labelFontWeight;

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    final w = LucizContentMetrics.primaryButtonWidth(context);
    final h = LucizContentMetrics.primaryButtonHeight(context);
    final fontSize = labelFontSize ?? 17; // ← edit: default label (design px)
    final weight = labelFontWeight ?? FontWeight.w600; // ← edit: default weight

    return Center(
      child: SizedBox(
        width: w,
        height: h,
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: LucizColors.brandRed, // ← edit: [B] fill
            foregroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.zero,
            minimumSize: Size(w, h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                s.r(14),
              ), // ← edit: [C] corner radius (design px)
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Alexandria',
              fontSize: s.font(fontSize),
              fontWeight: weight,
            ),
          ),
        ),
      ),
    );
  }
}
