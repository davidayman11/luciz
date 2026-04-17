// =============================================================================
// AUTH SOCIAL ROW — GUIDE (LOGIN)
// -----------------------------------------------------------------------------
// [A] “Or continue with” typography
// [B] Icon circle sizes
// [C] Brand colors for Facebook / Google / Apple chips
//
// Swap for real OAuth buttons when backend is ready.
// =============================================================================

import 'package:flutter/material.dart';

import '../../../../core/responsive/luciz_scale.dart';
import '../../../../core/theme/luciz_colors.dart';

class AuthSocialRow extends StatelessWidget {
  const AuthSocialRow({super.key});

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    final size = s.r(52); // ← edit: [B] circle diameter (design px)

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: LucizColors.inputBorder, height: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: s.w(12)),
              child: Text(
                'Or continue with',
                style: TextStyle(
                  fontFamily: 'Alexandria',
                  fontSize: s.font(13), // ← edit: [A] caption size
                  color: LucizColors.bodyGrey,
                ),
              ),
            ),
            Expanded(child: Divider(color: LucizColors.inputBorder, height: 1)),
          ],
        ),
        SizedBox(height: s.h(20)), // ← edit: gap under divider
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialChip(
              size: size,
              color: const Color(0xFF1877F2), // ← edit: [C] Facebook
              child: Icon(Icons.facebook, color: Colors.white, size: s.r(26)),
            ),
            SizedBox(width: s.w(20)), // ← edit: gap between icons
            _SocialChip(
              size: size,
              color: Colors.white,
              border: Border.all(color: LucizColors.inputBorder),
              child: Text(
                'G',
                style: TextStyle(
                  fontFamily: 'Alexandria',
                  fontSize: s.font(22),
                  fontWeight: FontWeight.w700,
                  color: LucizColors.titleBlack,
                ),
              ),
            ),
            SizedBox(width: s.w(20)),
            _SocialChip(
              size: size,
              color: LucizColors.titleBlack, // ← edit: [C] Apple circle
              child: Icon(Icons.apple, color: Colors.white, size: s.r(28)),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialChip extends StatelessWidget {
  const _SocialChip({
    required this.size,
    required this.child,
    this.color,
    this.border,
  });

  final double size;
  final Widget child;
  final Color? color;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Colors.white,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {}, // ← edit: wire OAuth when ready
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: border,
          ),
          child: child,
        ),
      ),
    );
  }
}
