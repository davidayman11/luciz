// =============================================================================
// HOME SCREEN — bottom nav + 4 empty tabs
// -----------------------------------------------------------------------------
// [A] Scaffold background
// [B] App bar (optional per product)
// [C] Tab bodies: [IndexedStack] keeps state when switching tabs
// [D] Bottom bar: [LucizHomeBottomNav] + SVGs in assets/images/nav/
// =============================================================================

import 'package:flutter/material.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/luciz_colors.dart';
import '../widgets/luciz_home_bottom_nav.dart';
import 'tabs/account_tab_page.dart';
import 'tabs/cart_tab_page.dart';
import 'tabs/home_tab_page.dart';
import 'tabs/rewards_tab_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = AppRoutes.home;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _tabIndex,
        sizing: StackFit.expand,
        children: const [
          HomeTabPage(),
          RewardsTabPage(),
          CartTabPage(),
          AccountTabPage(),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1, thickness: 1, color: LucizColors.inputBorder),
          SafeArea(
            top: false,
            child: LucizHomeBottomNav(
              currentIndex: _tabIndex,
              onChanged: (i) => setState(() => _tabIndex = i),
            ),
          ),
        ],
      ),
    );
  }
}
