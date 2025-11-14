import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tap_task/core/functions/supabase_signout.dart';
import 'package:tap_task/core/widgets/custom_appbar.dart';
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
        final isMobile = constraints.maxWidth < 700;

        if (isMobile) {
          return _buildMobileLayout(context, selectedIndex);
        } else {
          return Scaffold(
            body: Row(
              children: [
                _ModernDesktopSidebar(
                  selectedIndex: selectedIndex,
                  onNavItemTapped: (index) => onNavItemTapped(context, index),
                  onLogout: () => logout(context),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const CustomAppBar(),
                      Expanded(child: child),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, int selectedIndex) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(color: Colors.white),
          child: SafeArea(
            child: Builder(
              builder: (context) => Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),

                  horizontalSpace(8),
                  const CustomText(
                    title: 'Tap Task',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  const Spacer(),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => logout(context),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.logout,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF2C3E50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                children: [
                  Icon(Icons.blur_circular, color: Color(0xFF4A90E2), size: 30),
                  horizontalSpace(10),
                  CustomText(
                    title: 'Tap Task',
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    _buildDrawerItem(
                      context,
                      icon: Icons.dashboard_outlined,
                      label: 'Dashboard',
                      index: 0,
                      selectedIndex: selectedIndex,
                    ),
                    _buildDrawerItem(
                      context,
                      icon: Icons.shopping_cart_outlined,
                      label: 'Products',
                      index: 1,
                      selectedIndex: selectedIndex,
                    ),
                    _buildDrawerItem(
                      context,
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      index: 2,
                      selectedIndex: selectedIndex,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () => logout(context),
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.redAccent, size: 22),
                      horizontalSpace(16),
                      CustomText(
                        title: 'Logout',
                        fontSize: 16,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            verticalSpace(20),
          ],
        ),
      ),
      body: child,
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    required int selectedIndex,
  }) {
    final isSelected = index == selectedIndex;
    final color = isSelected ? Colors.white : Colors.white70;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      child: Material(
        color: isSelected ? const Color(0xFF4A90E2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            onNavItemTapped(context, index);
          },
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: color, size: 22),
                horizontalSpace(16),
                CustomText(
                  title: label,
                  fontSize: 16,
                  color: color,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModernDesktopSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavItemTapped;
  final VoidCallback onLogout;

  const _ModernDesktopSidebar({
    required this.selectedIndex,
    required this.onNavItemTapped,
    required this.onLogout,
  });
  Widget _buildSidebarItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = index == selectedIndex;
    final color = isSelected ? Colors.white : Colors.white70;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      child: Material(
        color: isSelected ? const Color(0xFF4A90E2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: () => onNavItemTapped(index),
          borderRadius: BorderRadius.circular(8.0),
          hoverColor: Colors.white10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: color, size: 22),
                horizontalSpace(16),
                CustomText(
                  title: label,
                  fontSize: 16,
                  color: color,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double sidebarWidth = 260.0;
    const Color sidebarBgColor = Color(0xFF2C3E50);

    return Container(
      width: sidebarWidth,
      color: sidebarBgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 30.0,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.blur_circular,
                  color: Color(0xFF4A90E2),
                  size: 30,
                ),
                horizontalSpace(10),
                const CustomText(
                  title: 'Tap Task',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  _buildSidebarItem(
                    context: context,
                    icon: selectedIndex == 0
                        ? Icons.dashboard
                        : Icons.dashboard_outlined,
                    label: 'Dashboard',
                    index: 0,
                  ),
                  _buildSidebarItem(
                    context: context,
                    icon: selectedIndex == 1
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                    label: 'Products',
                    index: 1,
                  ),
                  _buildSidebarItem(
                    context: context,
                    icon: selectedIndex == 2
                        ? Icons.settings
                        : Icons.settings_outlined,
                    label: 'Settings',
                    index: 2,
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: onLogout,
              borderRadius: BorderRadius.circular(8.0),
              hoverColor: Colors.red.withOpacity(0.1),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.redAccent, size: 22),
                    horizontalSpace(16),
                    CustomText(
                      title: 'Logout',
                      fontSize: 16,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
          ),
          verticalSpace(20),
        ],
      ),
    );
  }
}
