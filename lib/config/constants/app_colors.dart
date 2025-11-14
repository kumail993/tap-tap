import 'package:flutter/material.dart';
import 'package:tap_task/core/imports/common_imports.dart';

class Palette {
  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color secondaryColor = Color(0xFFFF9800);
  static const Color accentColor = Color(0xFF2196F3);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(0xFFE0E0E0);

  static const Color blackColor = Color(0xFF212121);
  static const Color darkGrayColor = Color(0xFF757575);
  static const Color whiteColor = Color(0xFFFFFFFF);

  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color errorColor = Color(0xFFF44336);

  static const Color shadowColor = Color(0x1F000000);
  static const Color borderColor = Color(0xFFE0E0E0);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
