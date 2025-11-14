import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tap_task/core/widgets/custom_text.dart';
import 'package:tap_task/core/widgets/custom_button.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';

Widget glassPanel({
  required Widget child,
  EdgeInsets padding = const EdgeInsets.all(16),
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(24),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.18)),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.08),
              Colors.white.withOpacity(0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: child,
      ),
    ),
  );
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background same as ProductsView
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF020617)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      verticalSpace(25),

                      // ------------------------------------------------------------
                      // PROFILE SETTINGS
                      // ------------------------------------------------------------
                      glassPanel(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle("Profile Settings"),
                            verticalSpace(16),
                            _buildTextField(
                              "Full Name",
                              "Enter your full name",
                            ),
                            verticalSpace(12),
                            _buildTextField("Email Address", "Enter email"),
                            verticalSpace(12),
                            _buildTextField(
                              "Change Password",
                              "Enter new password",
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(20),

                      // ------------------------------------------------------------
                      // APP DISPLAY SETTINGS
                      // ------------------------------------------------------------
                      glassPanel(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle("App Display"),
                            verticalSpace(16),
                            _buildDropdown(
                              label: "Theme",
                              items: const ["System", "Light", "Dark"],
                              onChanged: (_) {},
                            ),
                            verticalSpace(16),
                            _buildDropdown(
                              label: "Layout Density",
                              items: const ["Comfortable", "Compact"],
                              onChanged: (_) {},
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(20),

                      // ------------------------------------------------------------
                      // NOTIFICATION SETTINGS
                      // ------------------------------------------------------------
                      glassPanel(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle("Notifications"),
                            verticalSpace(10),
                            _buildSwitchTile(
                              title: "Email Alerts",
                              subtitle:
                                  "Receive email notifications for updates",
                              value: true,
                              onChanged: (_) {},
                            ),
                            verticalSpace(10),
                            _buildSwitchTile(
                              title: "Push Notifications",
                              subtitle: "Receive push alerts about activities",
                              value: false,
                              onChanged: (_) {},
                            ),
                            verticalSpace(10),
                            _buildSwitchTile(
                              title: "Stock Alerts",
                              subtitle:
                                  "Notify me when products go out of stock",
                              value: true,
                              onChanged: (_) {},
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(20),

                      // ------------------------------------------------------------
                      // SYSTEM SETTINGS
                      // ------------------------------------------------------------
                      glassPanel(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle("System Settings"),
                            verticalSpace(10),
                            _buildActionTile(
                              icon: Icons.delete_outline_rounded,
                              title: "Clear Cache",
                              onTap: () {},
                            ),
                            verticalSpace(10),
                            _buildActionTile(
                              icon: Icons.restart_alt_rounded,
                              title: "Reset Application Data",
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(25),

                      // SAVE BUTTON
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomIconButton(
                          minSize: const Size(180, 44),
                          maxSize: const Size(220, 44),
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          text: "Save Changes",
                          onPressed: () {},
                        ),
                      ),

                      verticalSpace(30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: "Settings",
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        verticalSpace(4),
        CustomText(
          title: "Customize your preferences and account details.",
          fontSize: 13,
          color: Colors.white.withOpacity(0.7),
        ),
      ],
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================
  Widget _sectionTitle(String title) {
    return CustomText(
      title: title,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.white.withOpacity(0.95),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================
  Widget _buildTextField(
    String label,
    String placeholder, {
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: label,
          fontSize: 13,
          color: Colors.white.withOpacity(0.8),
        ),
        verticalSpace(6),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withOpacity(0.18)),
                color: Colors.white.withOpacity(0.06),
              ),
              child: TextField(
                obscureText: obscureText,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: placeholder,
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DROPDOWN
  // ============================================================
  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: label,
          fontSize: 13,
          color: Colors.white.withOpacity(0.8),
        ),
        verticalSpace(6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.18)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: const Color(0xFF020617),
              style: const TextStyle(color: Colors.white),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white.withOpacity(0.9),
              ),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
              value: items.first,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SWITCH TILE
  // ============================================================
  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                fontSize: 14,
                color: Colors.white.withOpacity(0.95),
                fontWeight: FontWeight.w600,
              ),
              verticalSpace(2),
              CustomText(
                title: subtitle,
                fontSize: 12,
                color: Colors.white.withOpacity(0.6),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.white,
          activeTrackColor: Colors.white.withOpacity(0.4),
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.white.withOpacity(0.15),
        ),
      ],
    );
  }

  // ============================================================
  // ACTION TILE
  // ============================================================
  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white.withOpacity(0.06),
          border: Border.all(color: Colors.white.withOpacity(0.16)),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            horizontalSpace(12),
            CustomText(
              title: title,
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }
}
