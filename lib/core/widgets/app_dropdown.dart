import '../core/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final String? hintText;
  final ValueChanged<T?>? onChanged;
  final String Function(T) textBuilder;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? icon;

  const AppDropdown({
    Key? key,
    required this.items,
    this.value,
    this.hintText,
    this.onChanged,
    required this.textBuilder,
    this.width,
    this.height = 50.0,
    this.textStyle,
    this.hintStyle,
    this.fillColor,
    this.borderColor,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.contentPadding,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: fillColor ?? theme.canvasColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? theme.dividerColor,
          width: borderWidth,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<T>(
            value: value,
            hint: hintText != null
                ? Text(
                    hintText!,
                    style: hintStyle ??
                        theme.textTheme.bodyMedium?.copyWith(
                          color: theme.hintColor,
                        ),
                  )
                : null,
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                  textBuilder(item),
                  style: textStyle ?? theme.textTheme.bodyMedium,
                ),
              );
            }).toList(),
            onChanged: onChanged,
            icon: icon ?? const Icon(Icons.arrow_drop_down),
            isExpanded: true,
            borderRadius: BorderRadius.circular(borderRadius),
            padding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
      ),
    );
  }
}