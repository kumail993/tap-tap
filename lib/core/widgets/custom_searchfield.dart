import 'package:flutter/cupertino.dart';
import 'package:tap_task/config/constants/app_colors.dart';

class CustomSearchField extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? placeholder;
  final void Function(String)? onClear;
  final bool autofocus;
  final bool isEnabled;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? prefixIconColor;

  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double? lineHeight;
  final double fontSize;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? prefixIconPadding;
  final double? prefixIconSize;

  const CustomSearchField({
    super.key,
    this.onChanged,
    this.controller,
    this.placeholder,
    this.onClear,
    this.autofocus = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.borderRadius,
    this.prefixIconColor,
    this.color = Palette.blackColor,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.start,
    this.lineHeight,
    this.padding,
    this.prefixIconPadding,
    this.prefixIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      enabled: isEnabled,
      prefix: Padding(
        padding: prefixIconPadding ?? const EdgeInsets.all(8.0),
        child: Icon(
          CupertinoIcons.search,
          color: prefixIconColor ?? CupertinoColors.systemGrey,
          size: prefixIconSize,
        ),
      ),
      suffix: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller ?? TextEditingController(),
        builder: (context, value, child) {
          return value.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    controller!.clear();
                    onClear!(value.text);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                )
              : const SizedBox();
        },
      ),
      onChanged: onChanged,
      textInputAction: TextInputAction.done,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      controller: controller,
      autofocus: autofocus,
      placeholder: placeholder,
      placeholderStyle: TextStyle(
        fontFamily: 'GeneralSans',
        fontWeight: fontWeight,
        fontSize: fontSize,
        height: lineHeight,
        color: color,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        border: Border.all(color: Palette.darkGrayColor),
      ),
    );
  }
}
