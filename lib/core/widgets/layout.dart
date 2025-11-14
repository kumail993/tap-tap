import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tap_task/core/functions/supabase_signout.dart';
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
            _GlassSidebar(
              selectedIndex: selectedIndex,
              onNavTap: (i) => onNavItemTapped(context, i),
              onLogout: () => logout(context),
            ),

            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const _GlassTopBar(),
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

      drawer: _GlassMobileDrawer(
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

class _GlassTopBar extends StatelessWidget {
  const _GlassTopBar();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: Container(
          height: 65,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            border: Border(
              bottom: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
            ),
          ),
          child: Row(
            children: [
              const CustomText(
                title: "Dashboard",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              const Spacer(),
              Icon(
                Icons.notifications_none_rounded,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              horizontalSpace(20),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavTap;
  final VoidCallback onLogout;

  const _GlassSidebar({
    required this.selectedIndex,
    required this.onNavTap,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: const BoxDecoration(),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.10),
                  Colors.white.withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border(
                right: BorderSide(color: Colors.white.withValues(alpha: 0.10)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LOGO
                Row(
                  children: [
                    const Icon(
                      Icons.blur_circular,
                      color: Colors.white,
                      size: 28,
                    ),
                    horizontalSpace(10),
                    const CustomText(
                      title: "Tap Task",
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),

                verticalSpace(40),

                // NAV ITEMS
                _navItem(
                  icon: Icons.dashboard_outlined,
                  label: "Dashboard",
                  index: 0,
                ),
                _navItem(
                  icon: Icons.shopping_cart_outlined,
                  label: "Products",
                  index: 1,
                ),
                _navItem(
                  icon: Icons.settings_outlined,
                  label: "Settings",
                  index: 2,
                ),

                const Spacer(),

                // LOGOUT
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onLogout,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red.withValues(alpha: 0.10),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.logout, color: Colors.redAccent),
                        horizontalSpace(12),
                        const CustomText(
                          title: "Logout",
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isActive = index == selectedIndex;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onNavTap(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isActive
              ? Colors.white.withValues(alpha: 0.18)
              : Colors.white.withValues(alpha: 0.05),
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? Colors.white : Colors.white70),
            horizontalSpace(14),
            CustomText(
              title: label,
              fontSize: 16,
              color: isActive ? Colors.white : Colors.white70,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassMobileDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavTap;
  final VoidCallback onLogout;

  const _GlassMobileDrawer({
    required this.selectedIndex,
    required this.onNavTap,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.10),
                  Colors.white.withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.blur_circular,
                        color: Colors.white,
                        size: 28,
                      ),
                      horizontalSpace(10),
                      const CustomText(
                        title: "Tap Task",
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                verticalSpace(30),

                _drawerItem(context, "Dashboard", Icons.dashboard_outlined, 0),
                _drawerItem(
                  context,
                  "Products",
                  Icons.shopping_cart_outlined,
                  1,
                ),
                _drawerItem(context, "Settings", Icons.settings_outlined, 2),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.all(18),
                  child: _drawerLogout(),
                ),

                verticalSpace(30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context,
    String label,
    IconData icon,
    int index,
  ) {
    final isActive = index == selectedIndex;

    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onNavTap(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isActive
              ? Colors.white.withValues(alpha: 0.18)
              : Colors.white.withValues(alpha: 0.05),
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? Colors.white : Colors.white70),
            horizontalSpace(12),
            CustomText(
              title: label,
              fontSize: 16,
              color: isActive ? Colors.white : Colors.white70,
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerLogout() {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onLogout,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.red.withValues(alpha: 0.12),
          border: Border.all(color: Colors.red.withValues(alpha: 0.22)),
        ),
        child: Row(
          children: [
            const Icon(Icons.logout, color: Colors.redAccent),
            horizontalSpace(12),
            const CustomText(
              title: "Logout",
              fontSize: 16,
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
