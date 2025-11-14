import 'package:flutter/material.dart';
import 'package:tap_task/config/constants/app_colors.dart';
import 'package:tap_task/core/widgets/custom_text.dart';

class CustomIconButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color foregroundColor;
  final Widget? icon;
  final Color borderColor;
  final double borderWidth;
  final double verticalPadding;
  final double fontSize;
  final FontWeight fontWeight;
  final double? horizontalPadding;
  final Size? minSize;
  final Size? maxSize;
  final bool? isEnabled;
  final bool isLoading;
  final Color? loaderColor;
  final bool showIconOnLeft;
  final double borderRadius;
  final double? height;
  final double? width;
  final double iconAndTitleGap;

  const CustomIconButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Palette.whiteColor,
    this.textColor = Palette.whiteColor,
    this.foregroundColor = Palette.blackColor,
    this.icon,
    this.showIconOnLeft = false,
    this.borderColor = Palette.blackColor,
    this.borderWidth = 1,
    this.verticalPadding = 12,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.horizontalPadding,
    this.minSize,
    this.maxSize,
    this.isEnabled = true,
    this.isLoading = false,
    this.loaderColor,
    this.borderRadius = 30,
    this.height,
    this.width,
    this.iconAndTitleGap = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled! ? onPressed : null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(borderRadius * 0.4),
        ),
        minimumSize: minSize,
        maximumSize: maxSize,
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding ?? 0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null && showIconOnLeft) ...[
            icon!,
            SizedBox(width: iconAndTitleGap),
          ],
          CustomText(
            title: text,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
          if (icon != null && !showIconOnLeft) ...[
            SizedBox(width: iconAndTitleGap),
            icon!,
          ],
        ],
      ),
    );
  }
}
