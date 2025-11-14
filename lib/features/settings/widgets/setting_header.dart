import 'package:flutter/material.dart';
import 'package:tap_task/core/widgets/custom_text.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';

class SettingsHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SettingsHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: title,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        verticalSpace(4),
        CustomText(
          title: subtitle,
          fontSize: 13,
          color: Colors.white.withValues(alpha: 0.7),
        ),
      ],
    );
  }
}
