import 'dart:ui';

import 'package:tap_task/core/imports/common_imports.dart';

class GlassSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavTap;
  final VoidCallback onLogout;

  const GlassSidebar({
    super.key,
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
