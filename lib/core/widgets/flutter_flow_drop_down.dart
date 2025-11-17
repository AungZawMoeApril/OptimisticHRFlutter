import 'package:flutter/material.dart';
import '../utils/form_field_controller.dart';

/// Compatibility shim for legacy FlutterFlow dropdown code
/// This wraps DropdownButton to maintain backward compatibility
class FlutterFlowDropDown<T> extends StatelessWidget {
  const FlutterFlowDropDown({
    super.key,
    required this.options,
    required this.onChanged,
    this.controller,
    this.initialValue,
    this.initialOption,
    this.disabled = false,
    this.hintText,
    this.icon,
    this.fillColor,
    this.elevation = 2,
    this.borderWidth = 2,
    this.borderRadius = 8,
    this.borderColor,
    this.margin,
    this.textStyle,
    this.hintTextStyle,
    this.width,
    this.height = 56,
    this.searchHintTextStyle,
    this.searchTextStyle,
    this.isOverButton = false,
    this.isSearchable = false,
    this.maxHeight,
    this.dropdownColor,
    this.optionLabels,
    this.hidesUnderline = true,
    this.isMultiSelect = false,
  });

  final List<T> options;
  final Function(T?)? onChanged;
  final FormFieldController<T>? controller;
  final T? initialValue;
  final String? initialOption;
  final bool disabled;
  final String? hintText;
  final Widget? icon;
  final Color? fillColor;
  final double elevation;
  final double borderWidth;
  final double borderRadius;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final double? width;
  final double height;
  final TextStyle? searchHintTextStyle;
  final TextStyle? searchTextStyle;
  final bool isOverButton;
  final bool isSearchable;
  final double? maxHeight;
  final Color? dropdownColor;
  final List<String>? optionLabels;
  final bool hidesUnderline;
  final bool isMultiSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      width: width,
      height: height,
      padding: margin ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: fillColor ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? colorScheme.outline,
          width: borderWidth,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: controller?.value ?? initialValue,
          hint: hintText != null
              ? Text(
                  hintText!,
                  style: hintTextStyle ??
                      theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                )
              : null,
          icon: icon ??
              Icon(
                Icons.arrow_drop_down,
                color: colorScheme.onSurface,
              ),
          isExpanded: true,
          dropdownColor: dropdownColor ?? colorScheme.surface,
          style: textStyle ?? theme.textTheme.bodyMedium,
          items: options.asMap().entries.map((entry) {
            final index = entry.key;
            final value = entry.value;
            final label = optionLabels != null && index < optionLabels!.length
                ? optionLabels![index]
                : value.toString();
            return DropdownMenuItem<T>(
              value: value,
              child: Text(
                label,
                style: textStyle ?? theme.textTheme.bodyMedium,
              ),
            );
          }).toList(),
          onChanged: disabled
              ? null
              : (T? newValue) {
                  if (controller != null && newValue != null) {
                    controller!.value = newValue;
                  }
                  onChanged?.call(newValue);
                },
        ),
      ),
    );
  }
}
