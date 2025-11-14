import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    this.color = Colors.white,
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
    final ctrl = controller ?? TextEditingController();

    return ClipRRect(
      borderRadius: (borderRadius ?? BorderRadius.circular(18)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: (borderRadius ?? BorderRadius.circular(18)),
            border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.12),
                Colors.white.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: CupertinoTextField(
            enabled: isEnabled,
            controller: ctrl,
            autofocus: autofocus,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,
            prefix: Padding(
              padding: prefixIconPadding ?? const EdgeInsets.all(12.0),
              child: Icon(
                CupertinoIcons.search,
                color: prefixIconColor ?? Colors.white.withValues(alpha: 0.7),
                size: prefixIconSize ?? 20,
              ),
            ),
            suffix: ValueListenableBuilder<TextEditingValue>(
              valueListenable: ctrl,
              builder: (context, value, child) {
                if (value.text.isEmpty) return const SizedBox();
                return GestureDetector(
                  onTap: () {
                    ctrl.clear();
                    if (onClear != null) onClear!(value.text);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                );
              },
            ),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'GeneralSans',
              fontWeight: fontWeight,
              fontSize: fontSize,
              height: lineHeight,
            ),
            placeholder: placeholder,
            placeholderStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontFamily: 'GeneralSans',
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            cursorColor: Colors.white,
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
