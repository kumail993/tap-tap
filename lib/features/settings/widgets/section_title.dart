import 'package:flutter/material.dart';
import 'package:tap_task/core/widgets/custom_text.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: title,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.white.withValues(alpha: 0.95),
    );
  }
}
