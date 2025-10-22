import 'package:flutter/material.dart';

class AppButtonTabBar extends StatelessWidget {
  const AppButtonTabBar({
    Key? key,
    required this.labelStyle,
    required this.tabs,
    required this.controller,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorColor,
    this.backgroundColor,
    this.borderWidth = 2.0,
    this.borderRadius = 8.0,
    this.elevation = 0,
  }) : super(key: key);

  final TextStyle? labelStyle;
  final List<Widget> tabs;
  final TabController? controller;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final Color? indicatorColor;
  final Color? backgroundColor;
  final double borderWidth;
  final double borderRadius;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  blurRadius: elevation,
                  color: Colors.black26,
                  offset: Offset(0, elevation / 2),
                ),
              ]
            : null,
      ),
      child: TabBar(
        controller: controller,
        labelStyle: labelStyle,
        labelColor: labelColor ?? theme.colorScheme.primary,
        unselectedLabelColor: unselectedLabelColor ?? theme.colorScheme.onSurface.withOpacity(0.6),
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: indicatorColor ?? theme.colorScheme.primary,
              width: borderWidth,
            ),
          ),
        ),
        tabs: tabs,
      ),
    );
  }
}