// =============================================================================
// OTP VERIFICATION — LAYOUT GUIDE
// -----------------------------------------------------------------------------
// [A] App bar back
// [B] Headline + phone (red)
// [C] OTP: hidden field + display boxes (see auth_otp_boxes.dart), digit count
// [D] Resend row + countdown — placed under the Continue button
// [E] Continue → Select language
//
// Tap outside still focuses OTP via screen-level GestureDetector.
// =============================================================================

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/responsive/luciz_content_metrics.dart';
import '../../../../core/responsive/luciz_scale.dart';
import '../../../../core/theme/luciz_colors.dart';
import '../../../../core/widgets/luciz_primary_button.dart';
import '../widgets/auth_otp_boxes.dart';
import 'select_language_page.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({
    super.key,
    required this.phoneDisplay,
  });

  final String phoneDisplay;

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  static const int _otpLength = 4; // ← edit: [C] must match AuthOtpBoxes.length

  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _otpFocusNode = FocusNode();

  int _resendSeconds = 30;
  Timer? _resendTimer;
  bool _isResending = false;

  String get _code => _otpController.text;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _otpFocusNode.requestFocus();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _otpFocusNode.unfocus();
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  void _startResendCountdown() {
    _resendTimer?.cancel();
    setState(() => _resendSeconds = 30); // ← edit: [D] initial countdown seconds

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_resendSeconds <= 1) {
        timer.cancel();
        setState(() => _resendSeconds = 0);
      } else {
        setState(() => _resendSeconds -= 1);
      }
    });
  }

  Future<void> _resendOtp() async {
    if (_isResending || _resendSeconds > 0) return;
    setState(() => _isResending = true);
    _otpController.clear();
    setState(() {});

    // ← edit: [D] replace with API resend
    await Future<void>.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;
    setState(() => _isResending = false);
    _startResendCountdown();
    _otpFocusNode.requestFocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'OTP sent',
          style: TextStyle(fontFamily: 'Alexandria'),
        ),
      ),
    );
  }

  void _goNext() {
    if (_code.length != _otpLength) return;
    FocusManager.instance.primaryFocus?.unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (_) => const SelectLanguagePage(),
        ),
        (route) => false,
      );
    });
  }

  void _pop() {
    FocusManager.instance.primaryFocus?.unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      Navigator.of(context).maybePop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    final pad = LucizContentMetrics.horizontalPadding(context);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: LucizColors.titleBlack,
            size: s.r(20),
          ),
          onPressed: _pop,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _otpFocusNode.requestFocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              pad,
              0,
              pad,
              bottomInset + s.h(24),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: s.h(8)),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Alexandria',
                        fontSize: s.font(18),
                        fontWeight: FontWeight.w500,
                        color: LucizColors.titleBlack,
                      ),
                      children: [
                        const TextSpan(text: 'Enter the otp sent to '),
                        TextSpan(
                          text: widget.phoneDisplay,
                          style: TextStyle(
                            fontFamily: 'Alexandria',
                            color: LucizColors.brandRed,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: s.h(28)),
                  AuthOtpBoxes(
                    length: _otpLength,
                    controller: _otpController,
                    focusNode: _otpFocusNode,
                    onChanged: (_) => setState(() {}),
                  ),
                  SizedBox(height: s.h(32)),
                  LucizPrimaryButton(
                    label: 'Continue',
                    onPressed: _code.length == _otpLength ? _goNext : null,
                  ),
                  SizedBox(height: s.h(16)), // ← edit: gap button → resend row
                  // --- [D] RESEND ROW (under Continue, left aligned) ------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Didn\'t receive it? ',
                        style: TextStyle(
                          fontFamily: 'Alexandria',
                          fontSize: s.font(14),
                          fontWeight: FontWeight.w400, // ← edit: grey prompt weight
                          color: LucizColors.bodyGrey,
                        ),
                      ),
                      GestureDetector(
                        onTap: (_isResending || _resendSeconds > 0)
                            ? null
                            : _resendOtp,
                        child: _isResending
                            ? SizedBox(
                                width: s.r(14),
                                height: s.r(14),
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                  color: LucizColors.brandRed,
                                ),
                              )
                            : Text(
                                _resendSeconds > 0
                                    ? 'Resend in $_resendSeconds'
                                    : 'Resend OTP',
                                style: TextStyle(
                                  fontFamily: 'Alexandria',
                                  fontSize: s.font(14),
                                  fontWeight: _resendSeconds > 0
                                      ? FontWeight.w400
                                      : FontWeight.w800,
                                  color: _resendSeconds > 0
                                      ? LucizColors.bodyGrey
                                      : LucizColors.brandRed,
                                  decoration: _resendSeconds > 0
                                      ? TextDecoration.none
                                      : TextDecoration.underline,
                                  decorationColor: LucizColors.brandRed,
                                ),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(height: s.h(24)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
