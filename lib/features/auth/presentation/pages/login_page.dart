// =============================================================================
// LOGIN — LAYOUT GUIDE
// -----------------------------------------------------------------------------
// [A] Vertical gaps (logo → title → field → button → social → footer)
// [B] “Sign in” → OTP screen (passes mobile string)
// [C] Social row (see auth_social_row.dart)
// [D] Footer link → Sign up
//
// Title FontWeight.w500.
// =============================================================================

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/responsive/luciz_content_metrics.dart';
import '../../../../core/responsive/luciz_scale.dart';
import '../../../../core/theme/luciz_colors.dart';
import '../../../../core/widgets/luciz_primary_button.dart';
import '../widgets/auth_labeled_field.dart';
import '../widgets/auth_logo_header.dart';
import '../widgets/auth_social_row.dart';
import 'otp_verification_page.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phone = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    final pad = LucizContentMetrics.horizontalPadding(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: pad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: s.h(8)),
              const AuthLogoHeader(),
              SizedBox(height: s.h(20)), // ← edit: [A]
              Text(
                'Log into your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Alexandria',
                  fontSize: s.font(22),
                  fontWeight: FontWeight.w500,
                  color: LucizColors.brandRed,
                ),
              ),
              SizedBox(height: s.h(28)),
              AuthLabeledField(
                label: 'Mobile number',
                hint: '01xxxxxxxxx',
                controller: _phone,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: s.h(28)),
              LucizPrimaryButton(
                label: 'Sign in',
                onPressed: () {
                  final raw = _phone.text.replaceAll(RegExp(r'\s'), '');
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => OtpVerificationPage(phoneDisplay: raw),
                    ),
                  );
                },
              ),
              SizedBox(height: s.h(28)),
              const AuthSocialRow(),
              SizedBox(height: s.h(28)),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(
                      fontFamily: 'Alexandria',
                      fontSize: s.font(14),
                      color: LucizColors.bodyGrey,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          fontFamily: 'Alexandria',
                          color: LucizColors.brandRed,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute<void>(
                                builder: (_) => const SignUpPage(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: s.h(24)),
            ],
          ),
        ),
      ),
    );
  }
}
