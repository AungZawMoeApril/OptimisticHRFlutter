import 'package:flutter/material.dart';

/// FlutterFlow FlutterFlowButtonTabBar stub
class FlutterFlowButtonTabBar extends StatelessWidget {
  const FlutterFlowButtonTabBar({
    super.key,
    required this.tabs,
    this.onTap,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.labelColor,
    this.unselectedLabelColor,
    this.backgroundColor,
    this.unselectedBackgroundColor,
    this.borderColor,
    this.unselectedBorderColor,
    this.borderWidth,
    this.borderRadius,
    this.elevation,
    this.buttonMargin,
    this.padding,
    this.labelPadding,
  });

  final List<Widget> tabs;
  final ValueChanged<int>? onTap;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final Color? backgroundColor;
  final Color? unselectedBackgroundColor;
  final Color? borderColor;
  final Color? unselectedBorderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? elevation;
  final EdgeInsetsGeometry? buttonMargin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? labelPadding;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabs,
      onTap: onTap,
      labelStyle: labelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      indicator: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth ?? 1)
            : null,
      ),
      labelPadding: labelPadding,
      padding: padding,
    );
  }
}
