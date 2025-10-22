import 'package:flutter/material.dart';

class AppDropdownButton<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final List<String> labels;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final double? width;
  final double height;
  final bool isSearchable;

  const AppDropdownButton({
    Key? key,
    this.value,
    required this.items,
    required this.labels,
    required this.onChanged,
    this.hint,
    this.width,
    this.height = 50.0,
    this.isSearchable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      height: height,
      child: DropdownButtonFormField<T>(
        value: value,
        items: List.generate(
          items.length,
          (index) => DropdownMenuItem<T>(
            value: items[index],
            child: Text(
              labels[index],
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: theme.colorScheme.outline,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: theme.colorScheme.outline,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: theme.colorScheme.surface,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: theme.colorScheme.onSurface,
          size: 24,
        ),
        dropdownColor: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}