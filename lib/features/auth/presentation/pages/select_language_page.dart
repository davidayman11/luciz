// =============================================================================
// SELECT LANGUAGE — LAYOUT GUIDE
// -----------------------------------------------------------------------------
// [A] Page background
// [B] Title “Select language” (w500, left aligned)
// [C] Language row: full width × 48 design px, fill LucizColors.inputFill (#F9F9F9)
// [D] Gap before primary button
// [E] Primary button label
//
// Flow: Login → OTP → this screen → Home. “Get started” finishes setup.
// =============================================================================

import 'package:flutter/material.dart';

import '../../../../core/responsive/luciz_content_metrics.dart';
import '../../../../core/responsive/luciz_scale.dart';
import '../../../../core/theme/luciz_colors.dart';
import '../../../../core/widgets/luciz_primary_button.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../widgets/auth_logo_header.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({super.key});

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  String _code = 'en'; // ← edit: default language code

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    final pad = LucizContentMetrics.horizontalPadding(context);

    return Scaffold(
      backgroundColor: Colors.white, // ← edit: [A]
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: pad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: s.h(12)),
              const AuthLogoHeader(),
              SizedBox(height: s.h(24)), // ← edit: logo → title gap
              Text(
                'Select language',
                style: TextStyle(
                  fontFamily: 'Alexandria',
                  fontSize: s.font(20), // ← edit: [B] title size (design px)
                  fontWeight: FontWeight.w500, // ← edit: [B] title weight
                  color: LucizColors.titleBlack,
                ),
              ),
              SizedBox(height: s.h(20)),
              _LangTile(
                flag: '🇺🇸',
                label: 'English',
                selected: _code == 'en',
                onTap: () => setState(() => _code = 'en'),
              ),
              SizedBox(height: s.h(12)), // ← edit: gap between tiles
              _LangTile(
                flag: '🇪🇬',
                label: 'العربية',
                selected: _code == 'ar',
                onTap: () => setState(() => _code = 'ar'),
              ),
              const Spacer(),
              SizedBox(height: s.h(16)), // ← edit: [D]
              LucizPrimaryButton(
                label: 'Get started', // ← edit: [E]
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(
                      builder: (_) => const HomeScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
              SizedBox(height: s.h(24)),
            ],
          ),
        ),
      ),
    );
  }
}

class _LangTile extends StatelessWidget {
  const _LangTile({
    required this.flag,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String flag;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    final rowH = LucizContentMetrics.authInputRowHeight(context);
    final radius = s.r(12); // ← edit: match auth field radius
    return Material(
      color: LucizColors.inputFill,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          width: double.infinity,
          height: rowH, // ← edit: [C] same as AuthLabeledField / password
          padding: EdgeInsets.symmetric(horizontal: s.w(16)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: selected ? LucizColors.brandRed : LucizColors.inputBorder,
              width: selected ? 1.2 : 1, // ← match TextField focused / enabled
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                flag,
                style: TextStyle(fontSize: s.font(22)), // ← edit: [C] flag size (48px row)
              ),
              SizedBox(width: s.w(12)),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: s.font(16),
                    fontWeight: FontWeight.w500,
                    color: LucizColors.titleBlack,
                  ),
                ),
              ),
              _RadioDot(selected: selected, compact: true),
            ],
          ),
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected, this.compact = false});

  final bool selected;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    final outer = compact ? s.r(18) : s.r(22);
    return Container(
      width: outer,
      height: outer,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: LucizColors.brandRed,
          width: 2,
        ),
        color: selected ? LucizColors.brandRed.withValues(alpha: 0.12) : null,
      ),
      alignment: Alignment.center,
      child: selected
          ? Container(
              width: compact ? s.r(8) : s.r(10),
              height: compact ? s.r(8) : s.r(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: LucizColors.brandRed,
              ),
            )
          : null,
    );
  }
}
