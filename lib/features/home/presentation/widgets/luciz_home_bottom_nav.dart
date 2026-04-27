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
    final icon = s.r(25);

    return Material(
      color: Colors.white,
      child: SizedBox(
        height: s.h(68),
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

class _NavEntry extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              selected ? assetIn : assetOut,
              width: iconSize,
              height: iconSize,
            ),
            SizedBox(height: s.h(4)),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Alexandria',
                fontSize: s.font(10),
                fontWeight: FontWeight.w600,
                color: selected ? LucizColors.brandRed : LucizHomeBottomNav._inactiveGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}