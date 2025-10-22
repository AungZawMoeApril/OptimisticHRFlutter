import 'package:flutter/material.dart';

class CustomButtonTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final bool isScrollable;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final Color? indicatorColor;
  final EdgeInsetsGeometry? labelPadding;
  final double borderRadius;
  final Duration duration;

  const CustomButtonTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorColor,
    this.labelPadding,
    this.borderRadius = 8.0,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TabBar(
        controller: controller,
        isScrollable: isScrollable,
        labelColor: labelColor ?? theme.primaryColor,
        unselectedLabelColor: unselectedLabelColor ?? theme.unselectedWidgetColor,
        indicatorColor: indicatorColor ?? theme.primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: labelPadding,
        indicator: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        tabs: tabs,
      ),
    );
  }
}