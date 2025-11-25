import 'package:flutter/material.dart';

class FlutterFlowButtonTabBar extends StatelessWidget {
  const FlutterFlowButtonTabBar({
    super.key,
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
    this.labelPadding,
    this.padding,
    this.tabs = const [],
    this.onTap,
  });

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
  final EdgeInsetsGeometry? labelPadding;
  final EdgeInsetsGeometry? padding;
  final List<Widget> tabs;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelStyle: labelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      labelPadding: labelPadding,
      padding: padding,
      tabs: tabs,
      onTap: onTap,
    );
  }
}
