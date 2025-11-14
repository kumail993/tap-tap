import 'package:flutter/material.dart';
import 'package:tap_task/core/widgets/custom_text.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';

class GlassSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const GlassSwitchTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: title,
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.95),
                fontWeight: FontWeight.w600,
              ),
              verticalSpace(2),
              CustomText(
                title: subtitle,
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.white,
          activeTrackColor: Colors.white.withValues(alpha: 0.4),
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.white.withValues(alpha: 0.15),
        ),
      ],
    );
  }
}
