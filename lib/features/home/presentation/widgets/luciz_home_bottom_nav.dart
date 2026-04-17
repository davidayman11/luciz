// =============================================================================
// HOME BOTTOM NAV — 4 tabs (SVG inactive / filled active)
// -----------------------------------------------------------------------------
// Assets: assets/images/nav/*.svg
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/responsive/luciz_scale.dart';
import '../../../../core/theme/luciz_colors.dart';

class LucizHomeBottomNav extends StatelessWidget {
  const LucizHomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  static const _inactiveGrey = Color(0xFFA3A1A1);

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    final icon = s.r(24);

    return Material(
      color: Colors.white,
      child: SizedBox(
        height: s.h(56) + s.h(20),
        child: Row(
          children: [
            _NavEntry(
              label: 'Home',
              assetOut: 'assets/images/nav/home.svg',
              assetIn: 'assets/images/nav/home-filled.svg',
              selected: currentIndex == 0,
              iconSize: icon,
              onTap: () => onChanged(0),
            ),
            _NavEntry(
              label: 'Rewards',
              assetOut: 'assets/images/nav/gift.svg',
              assetIn: 'assets/images/nav/gift_filled.svg',
              selected: currentIndex == 1,
              iconSize: icon,
              onTap: () => onChanged(1),
            ),
            _NavEntry(
              label: 'Cart',
              assetOut: 'assets/images/nav/cart.svg',
              assetIn: 'assets/images/nav/cart_filled.svg',
              selected: currentIndex == 2,
              iconSize: icon,
              onTap: () => onChanged(2),
            ),
            _NavEntry(
              label: 'Account',
              assetOut: 'assets/images/nav/profile.svg',
              assetIn: 'assets/images/nav/profile_filled.svg',
              selected: currentIndex == 3,
              iconSize: icon,
              onTap: () => onChanged(3),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------

class _NavEntry extends StatefulWidget {
  const _NavEntry({
    required this.label,
    required this.assetOut,
    required this.assetIn,
    required this.selected,
    required this.iconSize,
    required this.onTap,
  });

  final String label;
  final String assetOut;
  final String assetIn;
  final bool selected;
  final double iconSize;
  final VoidCallback onTap;

  @override
  State<_NavEntry> createState() => _NavEntryState();
}

class _NavEntryState extends State<_NavEntry>
    with TickerProviderStateMixin {

  // — Selection: icon scale + label fade/slide/color
  late final AnimationController _selectCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 380),
  );

  // — Ripple: fires once on tap, never reverses, fully disappears
  late final AnimationController _rippleCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  // Select animations
  late final Animation<double> _iconScale = _selectCtrl.drive(
    Tween<double>(begin: 1.0, end: 1.18).chain(
      CurveTween(curve: Curves.elasticOut),
    ),
  );

  late final Animation<double> _labelFade = _selectCtrl.drive(
    CurveTween(curve: Curves.easeOut),
  );

  late final Animation<Offset> _labelSlide = _selectCtrl.drive(
    Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeOut)),
  );

  late final Animation<Color?> _labelColor = _selectCtrl.drive(
    ColorTween(
      begin: LucizHomeBottomNav._inactiveGrey,
      end: LucizColors.brandRed,
    ),
  );

  // Ripple: expands as a circle, starts at ~22% opacity, fully fades to 0
  late final Animation<double> _rippleScale = _rippleCtrl.drive(
    Tween<double>(begin: 0.0, end: 2.0).chain(
      CurveTween(curve: Curves.easeOut),
    ),
  );

  late final Animation<double> _rippleOpacity = _rippleCtrl.drive(
    Tween<double>(begin: 0.22, end: 0.0).chain(
      CurveTween(curve: Curves.easeIn),
    ),
  );

  @override
  void initState() {
    super.initState();
    // Start fully selected if this tab is active on first build
    if (widget.selected) _selectCtrl.value = 1.0;
  }

  @override
  void didUpdateWidget(_NavEntry old) {
    super.didUpdateWidget(old);
    if (widget.selected && !old.selected) {
      _selectCtrl.forward(from: 0);
      // Fire ripple fresh every time this tab is tapped
      _rippleCtrl.forward(from: 0);
    } else if (!widget.selected && old.selected) {
      _selectCtrl.reverse();
      // No need to reverse ripple — it already fades to nothing
    }
  }

  @override
  void dispose() {
    _selectCtrl.dispose();
    _rippleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);
    final rippleSize = widget.iconSize + s.r(16);

    return Expanded(
      child: InkWell(
        onTap: widget.onTap,
        // Kill Flutter's default rectangular ink — our circle is the feedback
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              width: rippleSize,
              height: rippleSize,
              child: Stack(
                alignment: Alignment.center,
                children: [

                  // 1 — Circle ripple: expands outward and fully disappears
                  AnimatedBuilder(
                    animation: _rippleCtrl,
                    builder: (_, __) => Transform.scale(
                      scale: _rippleScale.value,
                      child: Opacity(
                        opacity: _rippleOpacity.value,
                        child: Container(
                          width: rippleSize,
                          height: rippleSize,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: LucizColors.brandRed,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 2 — Icon with elastic scale bounce + svg crossfade
                  ScaleTransition(
                    scale: _iconScale,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: SvgPicture.asset(
                        widget.selected ? widget.assetIn : widget.assetOut,
                        key: ValueKey(widget.selected),
                        width: widget.iconSize,
                        height: widget.iconSize,
                      ),
                    ),
                  ),

                ],
              ),
            ),

            SizedBox(height: s.h(4)),

            // 3 — Label always visible; active = red + slide up, inactive = grey
            AnimatedBuilder(
              animation: _selectCtrl,
              builder: (_, __) => Text(
                widget.label,
                style: TextStyle(
                  fontFamily: 'Alexandria',
                  fontSize: s.font(11),
                  fontWeight: FontWeight.w500,
                  // Always show the label — only the color animates
                  color: widget.selected
                      ? _labelColor.value
                      : LucizHomeBottomNav._inactiveGrey,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}