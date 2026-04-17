// =============================================================================
// LUCIZ AUTH TEXT FIELD — SHARED INPUT ROW
// -----------------------------------------------------------------------------
// Fixed-height row ([LucizContentMetrics.authInputRowHeight]), #F9F9F9 fill,
// optional trailing suffix (e.g. password visibility). Text is start-aligned;
// vertical centering uses measured line height + symmetric [contentPadding].
//
// Use from auth screens, or compose with a label in [AuthLabeledField].
// =============================================================================

import 'package:flutter/material.dart';

import '../responsive/luciz_content_metrics.dart';
import '../responsive/luciz_scale.dart';
import '../theme/luciz_colors.dart';

class LucizAuthTextField extends StatefulWidget {
  const LucizAuthTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.suffix,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.autofillHints,
  });

  final TextEditingController controller;
  final String hint;
  final Widget? suffix;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final Iterable<String>? autofillHints;

  @override
  State<LucizAuthTextField> createState() => _LucizAuthTextFieldState();
}

class _LucizAuthTextFieldState extends State<LucizAuthTextField> {
  late final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocus);
  }

  void _onFocus() => setState(() {});

  @override
  void dispose() {
    _focusNode.removeListener(_onFocus);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    final rowH = LucizContentMetrics.authInputRowHeight(context);
    final suffixW = LucizContentMetrics.authInputSuffixWidth(context);
    final focused = _focusNode.hasFocus;
    final radius = s.r(12);

    return Container(
      height: rowH,
      width: double.infinity,
      decoration: BoxDecoration(
        color: LucizColors.inputFill,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: focused ? LucizColors.brandRed : LucizColors.inputBorder,
          width: focused ? 1.2 : 1,
        ),
      ),
      padding: EdgeInsets.only(
        left: s.w(16),
        right: widget.suffix != null ? 0 : s.w(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final fontSize = s.font(15);
                final textStyle = TextStyle(
                  fontFamily: 'Alexandria',
                  fontSize: fontSize,
                  height: 1.0,
                  leadingDistribution: TextLeadingDistribution.even,
                  color: LucizColors.titleBlack,
                );
                final hintStyle = TextStyle(
                  fontFamily: 'Alexandria',
                  fontSize: fontSize,
                  height: 1.0,
                  leadingDistribution: TextLeadingDistribution.even,
                  color: LucizColors.bodyGrey.withValues(alpha: 0.55),
                );
                final tp = TextPainter(
                  text: TextSpan(text: 'Hg', style: textStyle),
                  textDirection: Directionality.of(context),
                  textScaler: MediaQuery.textScalerOf(context),
                )..layout();
                final lineH = tp.height;
                final innerH = constraints.maxHeight;
                final vp = innerH > lineH ? (innerH - lineH) / 2 : 0.0;
                final rightPad = widget.suffix != null ? s.w(8) : 0.0;

                return TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  autofillHints: widget.autofillHints,
                  onChanged: widget.onChanged,
                  style: textStyle,
                  strutStyle: StrutStyle(
                    fontFamily: 'Alexandria',
                    fontSize: fontSize,
                    height: 1.0,
                    leading: 0,
                    forceStrutHeight: true,
                  ),
                  cursorColor: LucizColors.brandRed,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    filled: false,
                    hintText: widget.hint,
                    hintStyle: hintStyle,
                    contentPadding: EdgeInsets.fromLTRB(0, vp, rightPad, vp),
                  ),
                );
              },
            ),
          ),
          if (widget.suffix != null)
            SizedBox(
              width: suffixW,
              child: Center(child: widget.suffix),
            ),
        ],
      ),
    );
  }
}
