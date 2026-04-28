import 'dart:async';

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
  Timer? _bannerTimer;

  final List<_ProductItem> products = [
    _ProductItem(
      title: 'Mighty Zinger Sandwich',
      description: '2 Zinger Piece with Cheese, Lettuce, Tomato and sma...',
      price: 400,
      asset: 'assets/images/Chicken_logo.png',
      quantity: 0,
    ),
    _ProductItem(
      title: 'Ice Cream Vanilla Cone',
      description: '2 Zinger Piece with Cheese, Lettuce, Tomato and sma...',
      price: 400,
      asset: 'assets/images/Desserts_logo.png',
      quantity: 0,
    ),
    _ProductItem(
      title: 'Smoky BBQ Burger',
      description: '100% Beef Patty, American Cheese, Smoky Sauce,...',
      price: 320,
      asset: 'assets/images/Burgers_logo.png',
      quantity: 0,
    ),
  ];

  int get cartCount {
    return products.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  int get cartTotal {
    return products.fold<int>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  bool get hasCartItems => cartCount > 0;

  @override
  void initState() {
    super.initState();
    _startBannerAutoSlide();
  }

  void _startBannerAutoSlide() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_bannerController.hasClients) return;

      final nextIndex = bannerIndex == 2 ? 0 : bannerIndex + 1;

      _bannerController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  void _increaseProduct(int index) {
    setState(() {
      products[index].quantity++;
    });
  }

  void _decreaseProduct(int index) {
    setState(() {
      if (products[index].quantity > 0) {
        products[index].quantity--;
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = LucizScale.of(context);

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/home_page_cover.png',
            height: s.h(210),
            fit: BoxFit.cover,
          ),
        ),

        SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              s.w(10),
              s.h(6),
              s.w(10),
              hasCartItems ? s.h(95) : s.h(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(s: s),
                SizedBox(height: s.h(18)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: s.w(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _OrderType(
                        s: s,
                        title: 'Delivery',
                        selectedAsset: 'assets/images/delivery_icon.svg',
                        unselectedAsset:
                            'assets/images/Delivery-unselected.svg',
                        selected: selectedOrderType == 0,
                        onTap: () => setState(() => selectedOrderType = 0),
                      ),
                      _OrderType(
                        s: s,
                        title: 'Self-pickup',
                        selectedAsset: 'assets/images/pickup-selected.svg',
                        unselectedAsset: 'assets/images/self_pickup_icon.svg',
                        selected: selectedOrderType == 1,
                        onTap: () => setState(() => selectedOrderType = 1),
                      ),
                      _OrderType(
                        s: s,
                        title: 'Dine-in',
                        selectedAsset: 'assets/images/dine-in-selected.svg',
                        unselectedAsset: 'assets/images/dine_in_icon.svg',
                        selected: selectedOrderType == 2,
                        onTap: () => setState(() => selectedOrderType = 2),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: s.h(24)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: s.w(8)),
                  child: _SectionTitle(
                    s: s,
                    title: 'Special offers',
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: s.h(10)),

                SizedBox(
                  height: s.h(160),
                  child: PageView.builder(
                    controller: _bannerController,
                    itemCount: 3,
                    onPageChanged: (i) => setState(() => bannerIndex = i),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: s.w(8)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(s.r(15)),
                          clipBehavior: Clip.antiAlias,
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
                  child: _SectionTitle(
                    s: s,
                    title: 'Our menu',
                    fontWeight: FontWeight.w500,
                  ),
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
                        imageHeight: 90,
                        right: -30,
                        bottom: -4,
                      ),
                      _MenuCard(
                        s: s,
                        title: 'Chicken',
                        asset: 'assets/images/Chicken_logo.png',
                        imageWidth: 116,
                        imageHeight: 98,
                        right: -25,
                        bottom: -5,
                      ),
                      _MenuCard(
                        s: s,
                        title: 'Sides',
                        asset: 'assets/images/Sides_logo.png',
                        imageWidth: 112,
                        imageHeight: 90,
                        right: -26,
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
                        imageWidth: 120,
                        imageHeight: 95,
                        right: -33,
                        bottom: -4,
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

                SizedBox(height: s.h(23)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: s.w(2)),
                  child: _SectionTitle(
                    s: s,
                    title: 'Recommended for you',
                    fontWeight: FontWeight.w600,
                    color: LucizColors.brandRed,
                  ),
                ),

                SizedBox(height: s.h(10)),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  separatorBuilder: (_, __) => SizedBox(height: s.h(14)),
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return _RecommendedProductCard(
                      s: s,
                      product: product,
                      onAdd: () => _increaseProduct(index),
                      onRemove: () => _decreaseProduct(index),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        if (hasCartItems)
          Positioned(
            left: s.w(12),
            right: s.w(12),
            bottom: s.h(10),
            child: SafeArea(
              top: false,
              child: _CartBar(
                s: s,
                cartCount: cartCount,
                cartTotal: cartTotal,
              ),
            ),
          ),
      ],
    );
  }
}

class _ProductItem {
  _ProductItem({
    required this.title,
    required this.description,
    required this.price,
    required this.asset,
    required this.quantity,
  });

  final String title;
  final String description;
  final int price;
  final String asset;
  int quantity;
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
                    Flexible(
                      child: Text(
                        'Sheraton AL Matar , El Nozha....',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Alexandria',
                          fontSize: s.font(10),
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF777777),
                        ),
                      ),
                    ),
                    SizedBox(width: s.w(2)),
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
    required this.selectedAsset,
    required this.unselectedAsset,
    required this.selected,
    required this.onTap,
  });

  final LucizScale s;
  final String title;
  final String selectedAsset;
  final String unselectedAsset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        selected ? LucizColors.brandRed : const Color(0xFFA3A3A3);

    final double circleSize = selected ? s.r(82) : s.r(72);
    final double iconSize = selected ? s.r(54) : s.r(46);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: s.w(96),
        height: s.h(118),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: s.r(82),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  width: circleSize,
                  height: circleSize,
                  padding: EdgeInsets.all(selected ? s.r(8) : s.r(10)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: borderColor,
                      width: selected ? s.r(2.6) : s.r(2),
                    ),
                  ),
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOut,
                      width: iconSize,
                      height: iconSize,
                      child: SvgPicture.asset(
                        selected ? selectedAsset : unselectedAsset,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: s.h(8)),
            SizedBox(
              height: s.h(18),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: s.font(13),
                    fontWeight: FontWeight.w700,
                    color: borderColor,
                  ),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
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
    this.fontWeight,
    this.color,
  });

  final LucizScale s;
  final String title;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Alexandria',
        fontSize: s.font(16),
        fontWeight: fontWeight ?? FontWeight.w800,
        color: color ?? Colors.black,
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

class _RecommendedProductCard extends StatelessWidget {
  const _RecommendedProductCard({
    required this.s,
    required this.product,
    required this.onAdd,
    required this.onRemove,
  });

  final LucizScale s;
  final _ProductItem product;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final bool hasQuantity = product.quantity > 0;

    return Container(
      height: s.h(122),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(s.r(9)),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: const Offset(0, 2),
            color: Colors.black.withValues(alpha: 0.18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: s.w(12),
            top: s.h(18),
            bottom: s.h(16),
            child: SizedBox(
              width: s.w(98),
              child: Image.asset(
                product.asset,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Positioned(
            left: s.w(125),
            right: s.w(14),
            top: s.h(12),
            child: Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Alexandria',
                fontSize: s.font(14),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF222222),
              ),
            ),
          ),

          Positioned(
            left: s.w(125),
            right: s.w(18),
            top: s.h(40),
            child: Text(
              product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Alexandria',
                fontSize: s.font(11),
                height: 1.35,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9B9B9B),
              ),
            ),
          ),

          Positioned(
            left: s.w(125),
            bottom: s.h(17),
            child: Text(
              '${product.price} EGP',
              style: TextStyle(
                fontFamily: 'Alexandria',
                fontSize: s.font(14),
                fontWeight: FontWeight.w700,
                color: LucizColors.brandRed,
              ),
            ),
          ),

          Positioned(
  right: s.w(10),
  bottom: s.h(10),
  child: hasQuantity
      ? _QuantityOutlineControl(
          s: s,
          quantity: product.quantity,
          onRemove: onRemove,
          onAdd: onAdd,
        )
      : _AddButton(
          s: s,
          onTap: onAdd,
        ),
),
        ],
      ),
    );
  }
}

class _QuantityOutlineControl extends StatelessWidget {
  const _QuantityOutlineControl({
    required this.s,
    required this.quantity,
    required this.onRemove,
    required this.onAdd,
  });

  final LucizScale s;
  final int quantity;
  final VoidCallback onRemove;
  final VoidCallback onAdd;

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
              child: Icon(
                quantity == 1 ? Icons.delete_outline : Icons.remove,
                size: quantity == 1 ? s.r(18) : s.r(19),
                color: const Color(0xFF7F7F7F),
              ),
            ),
          ),
          SizedBox(width: s.w(11)),
          Text(
            '$quantity',
            style: TextStyle(
              fontFamily: 'Alexandria',
              fontSize: s.font(17),
              fontWeight: FontWeight.w800,
              color: Colors.black,
              height: 1,
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

class _AddButton extends StatelessWidget {
  const _AddButton({
    required this.s,
    required this.onTap,
  });

  final LucizScale s;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: s.r(28),
        height: s.r(28),
        decoration: BoxDecoration(
          color: LucizColors.brandRed,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: const Offset(0, 2),
              color: LucizColors.brandRed.withValues(alpha: 0.25),
            ),
          ],
        ),
        child: Icon(
          Icons.add,
          size: s.r(22),
          color: Colors.white,
        ),
      ),
    );
  }
}

class _CartBar extends StatelessWidget {
  const _CartBar({
    required this.s,
    required this.cartCount,
    required this.cartTotal,
  });

  final LucizScale s;
  final int cartCount;
  final int cartTotal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: s.h(49),
      padding: EdgeInsets.symmetric(horizontal: s.w(13)),
      decoration: BoxDecoration(
        color: LucizColors.brandRed,
        borderRadius: BorderRadius.circular(s.r(9)),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 5),
            color: Colors.black.withValues(alpha: 0.18),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: s.r(25),
            height: s.r(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(s.r(5)),
            ),
            child: Center(
              child: Text(
                '$cartCount',
                style: TextStyle(
                  fontFamily: 'Alexandria',
                  fontSize: s.font(14),
                  fontWeight: FontWeight.w800,
                  color: LucizColors.brandRed,
                ),
              ),
            ),
          ),
          SizedBox(width: s.w(9)),
          Text(
            'View Cart',
            style: TextStyle(
              fontFamily: 'Alexandria',
              fontSize: s.font(12),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Text(
            '$cartTotal EGP',
            style: TextStyle(
              fontFamily: 'Alexandria',
              fontSize: s.font(12),
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientText extends StatelessWidget {
  const _GradientText(this.text, {required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [Color(0xFFEC2024), Color(0xFFFF9300)],
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      blendMode: BlendMode.srcIn,
      child: Text(text, style: style),
    );
  }
}