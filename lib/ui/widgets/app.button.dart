import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../styles/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton(
    this.title, {
    this.height,
    this.width,
    this.isDisabled = false,
    this.isExpanded = false,
    this.onPressed,
    this.backgroundColor,
    this.backgroundGradient,
    this.textColor = AppColors.white,
    this.textShadowEnabled = false,
    this.borderSide,
    this.buttonTextStyle = const TextStyle(
      color: AppColors.black10,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    this.padding,
    this.borderRadius,
    this.appIcon,
    this.spaceBetweenIconText = 0,
    super.key,
  }) : assert(
          !(backgroundColor != null && backgroundGradient != null),
          'Cannot provide both a backgroundColor and a backgroundGradient',
        );

  final String title;
  final double? height;
  final double? width;
  final bool isExpanded;
  final bool isDisabled;
  final Function? onPressed;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final Color? textColor;
  final bool textShadowEnabled;
  final TextStyle buttonTextStyle;
  final BoxBorder? borderSide;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Widget? appIcon;
  final double spaceBetweenIconText;

  @override
  Widget build(BuildContext context) {
    Widget text = Padding(
      padding: padding ?? const EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          title,
          style: isDisabled
              ? const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                )
              : buttonTextStyle,
        ),
      ),
    );

    BoxDecoration boxDecoration = BoxDecoration(
      color: isDisabled
          ? const Color(0xFF242430)
          : backgroundColor ?? AppColors.orange,
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      border: borderSide,
    );

    if (isExpanded && appIcon == null) text = Center(child: text);

    if (appIcon != null) {
      text = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text,
          Gap(spaceBetweenIconText),
          Visibility(
            visible: appIcon != null,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: appIcon!,
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: onPressed == null || isDisabled ? null : () => onPressed!(),
      child: Container(
        height: height,
        width: width,
        decoration: boxDecoration,
        child: text,
      ),
    );
  }
}
