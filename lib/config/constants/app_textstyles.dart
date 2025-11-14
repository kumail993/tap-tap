import 'package:tap_task/core/imports/common_imports.dart';

class AppTextStyles {
  static TextStyle interTextStyle({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14,
    Color color = Palette.blackColor,
    double? lineHeight,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      fontSize: fontSize,
      height: lineHeight,
      color: color,
    );
  }
}
