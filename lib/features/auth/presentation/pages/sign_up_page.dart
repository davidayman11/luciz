// =============================================================================
// SIGN UP — LAYOUT GUIDE
// -----------------------------------------------------------------------------
// [A] Field stack gaps
// [B] Placeholder / hint copy (edit strings in AuthLabeledField calls)
// [C] Footer rich text (“Sign In” link)
// [D] Primary CTA → next screen (currently Home after success)
//
// Title uses FontWeight.w500 per product spec.
// =============================================================================

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/responsive/luciz_content_metrics.dart';
import '../../../../core/responsive/luciz_scale.dart';
import '../../../../core/theme/luciz_colors.dart';
import '../../../../core/widgets/luciz_primary_button.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../widgets/auth_labeled_field.dart';
import '../widgets/auth_logo_header.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _password.dispose();
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
              SizedBox(height: s.h(20)), // ← edit: [A] logo → title
              Text(
                'Create your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Alexandria',
                  fontSize: s.font(22), // ← edit: title size (design px)
                  fontWeight: FontWeight.w500,
                  color: LucizColors.brandRed,
                ),
              ),
              SizedBox(height: s.h(24)), // ← edit: [A] title → first field
              AuthLabeledField(
                label: 'Full name',
                hint: 'Enter your full name',
                controller: _name,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: s.h(18)), // ← edit: [A] between fields
              AuthLabeledField(
                label: 'Mobile number',
                hint: '01xxxxxxxxx',
                controller: _phone,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: s.h(18)),
              AuthLabeledField(
                label: 'Email address',
                hint: 'name@example.com',
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: s.h(18)),
              AuthLabeledField(
                label: 'Password',
                hint: 'Enter password',
                controller: _password,
                obscureText: _obscure,
                textInputAction: TextInputAction.done,
                suffix: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  style: IconButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  icon: Icon(
                    _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: LucizColors.bodyGrey,
                    size: s.r(22),
                  ),
                ),
              ),
              SizedBox(height: s.h(28)),
              LucizPrimaryButton(
                label: 'Sign up',
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
                    (route) => false,
                  );
                },
              ),
              SizedBox(height: s.h(20)),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      fontFamily: 'Alexandria',
                      fontSize: s.font(14),
                      color: LucizColors.bodyGrey,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          fontFamily: 'Alexandria',
                          color: LucizColors.brandRed,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute<void>(
                                builder: (_) => const LoginPage(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
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
