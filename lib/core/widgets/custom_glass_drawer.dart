import 'dart:ui';

import 'package:tap_task/core/imports/common_imports.dart';

class GlassMobileDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavTap;
  final VoidCallback onLogout;

  const GlassMobileDrawer({
    super.key,
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
