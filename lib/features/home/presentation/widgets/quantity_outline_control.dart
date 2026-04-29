import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/responsive/luciz_scale.dart';
import '../../../../core/theme/luciz_colors.dart';

class QuantityOutlineControl extends StatelessWidget {
  const QuantityOutlineControl({
    super.key,
    required this.s,
    required this.quantity,
    required this.onRemove,
    required this.onAdd,
    this.trashAsset = 'assets/images/trash-icon.svg',
  });

  final LucizScale s;
  final int quantity;
  final VoidCallback onRemove;
  final VoidCallback onAdd;
  final String trashAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: s.h(36),
      padding: EdgeInsets.fromLTRB(
        s.w(4),
        s.h(3),
        s.w(3),
        s.h(3),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(s.r(999)),
        border: Border.all(
          color: const Color(0xFFE1E1E1),
          width: s.r(1),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 7,
            offset: const Offset(0, 2),
            color: Colors.black.withValues(alpha: 0.07),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onRemove,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: s.r(30),
              height: s.r(30),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F1F1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 130),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.88,
                          end: 1,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: quantity == 1
                      ? SvgPicture.asset(
                          trashAsset,
                          key: const ValueKey('trash-icon'),
                          width: s.r(18),
                          height: s.r(18),
                          fit: BoxFit.contain,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF7F7F7F),
                            BlendMode.srcIn,
                          ),
                        )
                      : Icon(
                          Icons.remove,
                          key: const ValueKey('minus-icon'),
                          size: s.r(19),
                          color: const Color(0xFF7F7F7F),
                        ),
                ),
              ),
            ),
          ),

          SizedBox(width: s.w(11)),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 130),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Text(
              '$quantity',
              key: ValueKey<int>(quantity),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: s.font(14),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF000000),
                height: 1.0,
                letterSpacing: 0,
              ),
            ),
          ),

          SizedBox(width: s.w(11)),

          GestureDetector(
            onTap: onAdd,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: s.r(34),
              height: s.r(34),
              decoration: BoxDecoration(
                color: LucizColors.brandRed,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                    color: LucizColors.brandRed.withValues(alpha: 0.25),
                  ),
                ],
              ),
              child: Icon(
                Icons.add,
                size: s.r(27),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}