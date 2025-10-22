import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final Color? borderColor;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool showBorder;
  final double? iconSize;
  final double? buttonSize;
  final bool disabled;
  final double borderWidth;
  final Color? disabledColor;
  final Color? disabledIconColor;
  final Color? iconColor;

  const CustomIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.all(12.0),
    this.showBorder = true,
    this.iconSize,
    this.buttonSize,
    this.disabled = false,
    this.borderWidth = 1.0,
    this.disabledColor,
    this.disabledIconColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = disabled 
      ? (disabledIconColor ?? Theme.of(context).disabledColor)
      : iconColor;

    Widget effectiveIcon = icon;
    if (icon is Icon && effectiveIconColor != null) {
      final iconWidget = icon as Icon;
      effectiveIcon = Icon(
        iconWidget.icon,
        color: effectiveIconColor,
        size: iconWidget.size,
      );
    }

    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: Container(
        decoration: BoxDecoration(
          color: disabled
              ? (disabledColor ?? Theme.of(context).disabledColor.withOpacity(0.1))
              : (backgroundColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(borderRadius),
          border: showBorder
              ? Border.all(
                  color: disabled
                      ? (disabledColor ?? Theme.of(context).disabledColor)
                      : (borderColor ?? Theme.of(context).primaryColor),
                  width: borderWidth,
                )
              : null,
        ),
        child: IconButton(
          onPressed: disabled ? null : onPressed,
          icon: effectiveIcon,
          padding: padding,
          iconSize: iconSize,
          constraints: buttonSize != null 
              ? BoxConstraints.expand(width: buttonSize!, height: buttonSize!)
              : const BoxConstraints(),
        ),
      ),
    );
  }
}