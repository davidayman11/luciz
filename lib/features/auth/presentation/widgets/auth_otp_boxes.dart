// =============================================================================
// AUTH OTP BOXES — PHONE-STYLE (hidden field + display cells)
// -----------------------------------------------------------------------------
// Same interaction model as nzl_mobile phone_verification_screen:
// [A] One Offstage TextField holds the full code; tap row to focus it.
// [B] Each cell shows a digit or a blinking bar when active & empty.
// [C] length (4), box 80×60 design px (scaled); row may shrink cells on narrow width.
// [D] Border: brand red when cell has digit or is the active index; else grey.
//
// Pass [controller] + [focusNode] from the parent if you need tap-to-focus
// from an outer GestureDetector; parent must dispose them.
// =============================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/responsive/luciz_scale.dart';
import '../../../../core/theme/luciz_colors.dart';

class AuthOtpBoxes extends StatefulWidget {
  const AuthOtpBoxes({
    super.key,
    required this.length,
    required this.onChanged,
    required this.controller,
    required this.focusNode,
  });

  /// Number of OTP digits.
  final int length;

  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  State<AuthOtpBoxes> createState() => _AuthOtpBoxesState();
}

class _AuthOtpBoxesState extends State<AuthOtpBoxes>
    with SingleTickerProviderStateMixin {
  late AnimationController _cursorController;
  late Animation<double> _cursorAnim;

  String get _code => widget.controller.text;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _cursorAnim = CurvedAnimation(
      parent: _cursorController,
      curve: Curves.easeInOut,
    );
    widget.controller.addListener(_handleText);
    widget.focusNode.addListener(_handleFocus);
  }

  void _handleText() {
    var t = widget.controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (t != widget.controller.text) {
      widget.controller.value = TextEditingValue(
        text: t,
        selection: TextSelection.collapsed(offset: t.length),
      );
      return;
    }
    if (t.length > widget.length) {
      t = t.substring(0, widget.length);
      widget.controller.value = TextEditingValue(
        text: t,
        selection: TextSelection.collapsed(offset: t.length),
      );
    }
    if (mounted) setState(() {});
    widget.onChanged(widget.controller.text);
  }

  void _handleFocus() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleText);
    widget.focusNode.removeListener(_handleFocus);
    _cursorController.stop();
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    final targetW = s.w(60); // ← edit: [C] design cell width
    final boxH = s.h(80); // ← edit: [C] design cell height
    final gap = s.w(1); // ← edit: [C] minimum gap between cells (design px)
    final radius = s.r(12); // ← edit: [D] corner radius

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Offstage(
          offstage: true,
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            autofocus: true,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            maxLength: widget.length,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(widget.length),
            ],
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
              isCollapsed: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final rowW = constraints.maxWidth;
            final gapsTotal = gap * (widget.length - 1);
            final maxEach = (rowW - gapsTotal) / widget.length;
            final boxW = math.min(targetW, maxEach);

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => widget.focusNode.requestFocus(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(widget.length, (index) {
                  final char =
                      index < _code.length ? _code[index] : '';
                  final hasChar = char.isNotEmpty;
                  final isActive = widget.focusNode.hasFocus &&
                      ((_code.length < widget.length &&
                              index == _code.length) ||
                          (_code.length == widget.length &&
                              index == widget.length - 1));

                  return _OtpDisplayBox(
                    width: boxW,
                    height: boxH,
                    borderRadius: radius,
                    char: char,
                    hasChar: hasChar,
                    isActive: isActive,
                    cursorAnim: _cursorAnim,
                  );
                }),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _OtpDisplayBox extends StatelessWidget {
  const _OtpDisplayBox({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.char,
    required this.hasChar,
    required this.isActive,
    required this.cursorAnim,
  });

  final double width;
  final double height;
  final double borderRadius;
  final String char;
  final bool hasChar;
  final bool isActive;
  final Animation<double> cursorAnim;

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    final borderColor = (isActive || hasChar)
        ? LucizColors.brandRed
        : LucizColors.inputBorder;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
          width: s.r(1.5), // ← edit: border stroke
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (hasChar)
            Text(
              char,
              style: TextStyle(
                fontFamily: 'Alexandria',
                color: LucizColors.titleBlack,
                fontSize: s.font(22),
                fontWeight: FontWeight.w600,
              ),
            ),
          if (!hasChar && isActive)
            Positioned(
              bottom: s.h(8),
              left: s.w(10),
              right: s.w(10),
              child: AnimatedBuilder(
                animation: cursorAnim,
                builder: (context, _) {
                  return Opacity(
                    opacity: cursorAnim.value,
                    child: Container(
                      height: s.r(2.5),
                      decoration: BoxDecoration(
                        color: LucizColors.brandRed,
                        borderRadius: BorderRadius.circular(s.r(2)),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
