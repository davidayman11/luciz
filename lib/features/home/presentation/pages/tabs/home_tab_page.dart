import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/responsive/luciz_scale.dart';
import '../../../../../core/theme/luciz_colors.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  int selectedOrderType = 0;
  int bannerIndex = 0;

  final PageController _bannerController = PageController();

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(s.w(10), s.h(6), s.w(10), s.h(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(s: s),
            SizedBox(height: s.h(18)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: s.w(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _OrderType(
                    s: s,
                    title: 'Delivery',
                    asset: 'assets/images/delivery_icon.svg',
                    selected: selectedOrderType == 0,
                    onTap: () => setState(() => selectedOrderType = 0),
                  ),
                  _OrderType(
                    s: s,
                    title: 'Self-pickup',
                    asset: 'assets/images/self_pickup_icon.svg',
                    selected: selectedOrderType == 1,
                    onTap: () => setState(() => selectedOrderType = 1),
                  ),
                  _OrderType(
                    s: s,
                    title: 'Dine-in',
                    asset: 'assets/images/dine_in_icon.svg',
                    selected: selectedOrderType == 2,
                    onTap: () => setState(() => selectedOrderType = 2),
                  ),
                ],
              ),
            ),

            SizedBox(height: s.h(24)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: s.w(8)),
              child: _SectionTitle(s: s, title: 'Special offers'),
            ),

            SizedBox(height: s.h(10)),

            SizedBox(
              height: s.h(178),
              child: PageView.builder(
                controller: _bannerController,
                itemCount: 3,
                onPageChanged: (i) => setState(() => bannerIndex = i),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: s.w(8)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(s.r(10)),
                      child: Image.asset(
                        'assets/images/Special_Offers.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: s.h(9)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                final active = i == bannerIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.symmetric(horizontal: s.w(4)),
                  width: active ? s.w(25) : s.w(18),
                  height: s.h(4),
                  decoration: BoxDecoration(
                    color: active
                        ? LucizColors.brandRed
                        : const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(s.r(20)),
                  ),
                );
              }),
            ),

            SizedBox(height: s.h(26)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: s.w(8)),
              child: _SectionTitle(s: s, title: 'Our menu'),
            ),

            SizedBox(height: s.h(12)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: s.w(8)),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: s.w(10),
                mainAxisSpacing: s.h(14),
                childAspectRatio: 0.95,
                children: [
                  _MenuCard(
                    s: s,
                    title: 'Burgers',
                    asset: 'assets/images/Burgers_logo.png',
                    imageWidth: 112,
                    imageHeight: 88,
                    right: -40,
                    bottom: -4,
                  ),
                  _MenuCard(
                    s: s,
                    title: 'Chicken',
                    asset: 'assets/images/Chicken_logo.png',
                    imageWidth: 116,
                    imageHeight: 90,
                    right: -25,
                    bottom: -5,
                  ),
                  _MenuCard(
                    s: s,
                    title: 'Sides',
                    asset: 'assets/images/Sides_logo.png',
                    imageWidth: 112,
                    imageHeight: 88,
                    right: -25,
                    bottom: -4,
                  ),
                  _MenuCard(
                    s: s,
                    title: 'Drinks',
                    asset: 'assets/images/Drinks_logo.png',
                    imageWidth: 116,
                    imageHeight: 92,
                    right: -25,
                    bottom: -8,
                  ),
                  _MenuCard(
                    s: s,
                    title: 'Desserts',
                    asset: 'assets/images/Desserts_logo.png',
                    imageWidth: 108,
                    imageHeight: 92,
                    right: -40,
                    bottom: -8,
                  ),
                  _MenuCard(
                    s: s,
                    title: 'Extras',
                    asset: 'assets/images/Extras_logo.png',
                    imageWidth: 108,
                    imageHeight: 92,
                    right: -25,
                    bottom: -8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.s});

  final LucizScale s;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s.w(8)),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/sub_logo.svg',
            width: s.r(28),
            height: s.r(28),
            fit: BoxFit.contain,
          ),
          SizedBox(width: s.w(8)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deliver to',
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: s.font(13),
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: s.h(3)),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Sheraton AL Matar , El Nozha....',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Alexandria',
                          fontSize: s.font(10),
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF777777),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: LucizColors.brandRed,
                      size: s.r(16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: s.w(8)),
          Container(
            width: s.r(36),
            height: s.r(36),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                  color: Colors.black.withValues(alpha: 0.08),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/notification-bell.svg',
                width: s.r(20),
                height: s.r(20),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderType extends StatelessWidget {
  const _OrderType({
    required this.s,
    required this.title,
    required this.asset,
    required this.selected,
    required this.onTap,
  });

  final LucizScale s;
  final String title;
  final String asset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? LucizColors.brandRed : const Color(0xFFA3A3A3);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: s.w(96),
        child: Column(
          children: [
            Container(
              width: s.r(72),
              height: s.r(72),
              padding: EdgeInsets.all(s.r(12)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: s.r(2)),
              ),
              child: SvgPicture.asset(asset, fit: BoxFit.contain),
            ),
            SizedBox(height: s.h(7)),
            Text(
              title,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'Alexandria',
                fontSize: s.font(13),
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.s,
    required this.title,
  });

  final LucizScale s;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Alexandria',
        fontSize: s.font(18),
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.s,
    required this.title,
    required this.asset,
    required this.imageWidth,
    required this.imageHeight,
    required this.right,
    required this.bottom,
  });

  final LucizScale s;
  final String title;
  final String asset;
  final double imageWidth;
  final double imageHeight;
  final double right;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.fromLTRB(s.r(10), s.r(10), s.r(0), s.r(0)),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(s.r(20)),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: _GradientText(
              title,
              style: TextStyle(
                fontFamily: 'Alexandria',
                fontSize: s.font(17),
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
          Positioned(
            right: s.w(right),
            bottom: s.h(bottom),
            child: Image.asset(
              asset,
              width: s.w(imageWidth),
              height: s.h(imageHeight),
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientText extends StatelessWidget {
  const _GradientText(
    this.text, {
    required this.style,
  });

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [
            Color(0xFFEC2024),
            Color(0xFFFF9300),
          ],
        ).createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      blendMode: BlendMode.srcIn,
      child: Text(text, style: style),
    );
  }
}