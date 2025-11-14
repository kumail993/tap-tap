import 'package:flutter/material.dart';
import 'package:tap_task/config/constants/app_colors.dart';
import 'package:tap_task/config/constants/app_textstyles.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.title,
    this.color = Palette.blackColor,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.lineHeight,
    this.overflow,
    this.underline = false,
  });

  final String title;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? lineHeight;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style:
          AppTextStyles.interTextStyle(
            color: color,
            fontWeight: fontWeight,
            fontSize: fontSize,
            lineHeight: lineHeight,
          ).copyWith(
            decoration: underline
                ? TextDecoration.underline
                : TextDecoration.none,
          ),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
