import 'package:flutter/material.dart';

/// FlutterFlow icon button stub
class FlutterFlowIconButton extends StatelessWidget {
  final IconData? icon;
  final double? buttonSize;
  final Color? fillColor;
  final Color? iconColor;
  final double? iconSize;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const FlutterFlowIconButton({
    super.key,
    this.icon,
    this.buttonSize,
    this.fillColor,
    this.iconColor,
    this.iconSize,
    this.onPressed,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon ?? Icons.circle, color: iconColor),
      iconSize: iconSize ?? 24.0,
      padding: padding ?? const EdgeInsets.all(8.0),
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: fillColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
