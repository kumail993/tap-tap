import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tap_task/core/widgets/custom_text.dart';
import 'package:tap_task/core/widgets/sizedbox.dart';

class GlassTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool obscureText;

  const GlassTextField({
    super.key,
    required this.label,
    required this.placeholder,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: label,
          fontSize: 13,
          color: Colors.white.withValues(alpha: 0.8),
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
                border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
                color: Colors.white.withValues(alpha: 0.06),
              ),
              child: TextField(
                obscureText: obscureText,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: placeholder,
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
