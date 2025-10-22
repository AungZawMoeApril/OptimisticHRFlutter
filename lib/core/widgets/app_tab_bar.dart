import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final Function(int)? onTap;
  final bool useToggleStyle;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final Color? backgroundColor;
  final Color? unselectedBackgroundColor;
  final Color? borderColor;
  final Color? unselectedBorderColor;
  final double borderWidth;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry buttonMargin;
  final EdgeInsetsGeometry padding;

  const AppTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
    this.useToggleStyle = false,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.labelColor,
    this.unselectedLabelColor,
    this.backgroundColor,
    this.unselectedBackgroundColor,
    this.borderColor,
    this.unselectedBorderColor,
    this.borderWidth = 2.0,
    this.borderRadius = 8.0,
    this.elevation = 0.0,
    this.buttonMargin = const EdgeInsets.symmetric(horizontal: 8.0),
    this.padding = const EdgeInsets.all(4.0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (useToggleStyle) {
      return Container(
        decoration: BoxDecoration(
          color: unselectedBackgroundColor ?? theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: unselectedBorderColor ?? theme.colorScheme.outline,
            width: borderWidth,
          ),
        ),
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            tabs.length,
            (index) => Expanded(
              child: Padding(
                padding: buttonMargin,
                child: Material(
                  color: controller?.index == index
                      ? backgroundColor ?? theme.colorScheme.primary
                      : unselectedBackgroundColor ?? theme.colorScheme.surface,
                  elevation: elevation,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius - 2),
                    side: BorderSide(
                      color: controller?.index == index
                          ? borderColor ?? theme.colorScheme.primary
                          : unselectedBorderColor ?? theme.colorScheme.outline,
                      width: borderWidth,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => onTap?.call(index),
                    borderRadius: BorderRadius.circular(borderRadius - 2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DefaultTextStyle(
                        style: (controller?.index == index 
                          ? labelStyle 
                          : unselectedLabelStyle) ?? theme.textTheme.labelLarge!,
                        textAlign: TextAlign.center,
                        child: tabs[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return TabBar(
      controller: controller,
      onTap: onTap,
      tabs: tabs,
      labelStyle: labelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      labelColor: labelColor ?? theme.colorScheme.primary,
      unselectedLabelColor: unselectedLabelColor ?? theme.colorScheme.onSurface,
      indicator: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? theme.colorScheme.primary,
          width: borderWidth,
        ),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
    );
  }
}