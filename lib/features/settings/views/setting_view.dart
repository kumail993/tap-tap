import 'package:flutter/material.dart';
import 'package:tap_task/core/widgets/custom_button.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';
import 'package:tap_task/features/products/widgets/glass_panel.dart';
import 'package:tap_task/features/settings/widgets/glass_action_tile.dart';
import 'package:tap_task/features/settings/widgets/glass_dropdown.dart';
import 'package:tap_task/features/settings/widgets/glass_switch.dart';
import 'package:tap_task/features/settings/widgets/glass_textfield.dart';
import 'package:tap_task/features/settings/widgets/section_title.dart';
import 'package:tap_task/features/settings/widgets/setting_header.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String themeValue = "System";
  String densityValue = "Comfortable";
  bool emailAlerts = true;
  bool pushNotifications = false;
  bool stockAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      const SettingsHeader(
                        title: "Settings",
                        subtitle: "Manage your account settings",
                      ),
                      verticalSpace(25),
                      GlassPanel(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionTitle(title: 'Profile Settuing'),
                            verticalSpace(16),
                            const GlassTextField(
                              label: "Full Name",
                              placeholder: "Enter your full name",
                            ),
                            verticalSpace(12),
                            const GlassTextField(
                              label: "Email Address",
                              placeholder: "Enter email",
                            ),
                            verticalSpace(12),
                            const GlassTextField(
                              label: "Change Password",
                              placeholder: "Enter new password",
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(20),
                      GlassPanel(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionTitle(title: 'App Display'),
                            verticalSpace(16),
                            GlassDropdown(
                              label: "Theme",
                              items: const ["System", "Light", "Dark"],
                              value: themeValue,
                              onChanged: (v) {
                                setState(() => themeValue = v!);
                              },
                            ),
                            verticalSpace(16),
                            GlassDropdown(
                              label: "Layout Density",
                              items: const ["Comfortable", "Compact"],
                              value: densityValue,
                              onChanged: (v) {
                                setState(() => densityValue = v!);
                              },
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(20),
                      GlassPanel(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionTitle(title: 'Notifications'),
                            verticalSpace(10),
                            GlassSwitchTile(
                              title: "Email Alerts",
                              subtitle:
                                  "Receive email notifications for updates",
                              value: emailAlerts,
                              onChanged: (v) {
                                setState(() => emailAlerts = v);
                              },
                            ),
                            verticalSpace(10),
                            GlassSwitchTile(
                              title: "Push Notifications",
                              subtitle: "Receive push alerts about activities",
                              value: pushNotifications,
                              onChanged: (v) {
                                setState(() => pushNotifications = v);
                              },
                            ),
                            verticalSpace(10),
                            GlassSwitchTile(
                              title: "Stock Alerts",
                              subtitle:
                                  "Notify me when products go out of stock",
                              value: stockAlerts,
                              onChanged: (v) {
                                setState(() => stockAlerts = v);
                              },
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(20),
                      GlassPanel(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionTitle(title: 'System Settings'),
                            verticalSpace(10),
                            GlassActionTile(
                              icon: Icons.delete_outline_rounded,
                              title: "Clear Cache",
                              onTap: () {},
                            ),
                            verticalSpace(10),
                            GlassActionTile(
                              icon: Icons.restart_alt_rounded,
                              title: "Reset Application Data",
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(25),
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
                      verticalSpace(50),
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
}
