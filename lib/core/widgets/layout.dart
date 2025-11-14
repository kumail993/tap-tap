import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tap_task/core/functions/supabase_signout.dart';
import 'package:tap_task/core/widgets/custom_glass_drawer.dart';
import 'package:tap_task/core/widgets/custom_glass_topbar.dart';
import 'package:tap_task/core/widgets/custom_siderbar.dart';
import 'package:tap_task/core/widgets/custom_text.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';

class DashboardLayout extends StatelessWidget {
  final Widget child;
  const DashboardLayout({super.key, required this.child});
  int getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/dashboard/products')) return 1;
    if (location.startsWith('/dashboard/settings')) return 2;
    return 0;
  }

  void onNavItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/dashboard/products');
        break;
      case 2:
        context.go('/dashboard/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = getSelectedIndex(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        return isMobile
            ? _buildMobileLayout(context, selectedIndex)
            : _buildGlassDesktopLayout(context, selectedIndex);
      },
    );
  }

  Widget _buildGlassDesktopLayout(BuildContext context, int selectedIndex) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF020617)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            GlassSidebar(
              selectedIndex: selectedIndex,
              onNavTap: (i) => onNavItemTapped(context, i),
              onLogout: () => logout(context),
            ),

            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const GlassTopBar(),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, int selectedIndex) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,

      drawer: GlassMobileDrawer(
        selectedIndex: selectedIndex,
        onNavTap: (i) => onNavItemTapped(context, i),
        onLogout: () => logout(context),
      ),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withValues(alpha: 0.12),
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SafeArea(
                child: Row(
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                    horizontalSpace(8),
                    const CustomText(
                      title: "Tap Task",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => logout(context),
                      child: const Icon(
                        Icons.logout_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF020617)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: child,
      ),
    );
  }
}
