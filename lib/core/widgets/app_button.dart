import 'package:flutter/material.dart';

enum AppButtonType {
  primary,
  secondary,
  tertiary,
  success,
  warning,
  error,
  info
}

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final AppButtonType type;
  final bool isLoading;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final bool showBorder;
  final bool disabled;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;

  const AppButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.width,
    this.height = 40,
    this.padding,
    this.icon,
    this.showBorder = false,
    this.disabled = false,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor = backgroundColor ?? _getBackgroundColor(theme);
    final effectiveForegroundColor = foregroundColor ?? _getForegroundColor(theme);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: disabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            side: showBorder
                ? BorderSide(
                    color: effectiveBackgroundColor,
                    width: 1,
                  )
                : BorderSide.none,
          ),
          elevation: showBorder ? 0 : 2,
        ),
        child: _buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_getForegroundColor(Theme.of(context))),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(
            text,
            style: textStyle ?? Theme.of(context).textTheme.labelLarge?.copyWith(
              color: _getForegroundColor(Theme.of(context)),
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: textStyle ?? Theme.of(context).textTheme.labelLarge?.copyWith(
        color: _getForegroundColor(Theme.of(context)),
      ),
    );
  }

  Color _getBackgroundColor(ThemeData theme) {
    if (disabled) {
      return theme.colorScheme.surfaceVariant;
    }

    switch (type) {
      case AppButtonType.primary:
        return theme.colorScheme.primary;
      case AppButtonType.secondary:
        return theme.colorScheme.secondary;
      case AppButtonType.tertiary:
        return theme.colorScheme.tertiary;
      case AppButtonType.success:
        return const Color(0xFF04A24C);
      case AppButtonType.warning:
        return const Color(0xFFFCDC0C);
      case AppButtonType.error:
        return theme.colorScheme.error;
      case AppButtonType.info:
        return const Color(0xFF1AD1DB);
    }
  }

  Color _getForegroundColor(ThemeData theme) {
    if (disabled) {
      return theme.colorScheme.onSurfaceVariant;
    }

    if (showBorder) {
      return _getBackgroundColor(theme);
    }

    switch (type) {
      case AppButtonType.primary:
        return theme.colorScheme.onPrimary;
      case AppButtonType.secondary:
        return theme.colorScheme.onSecondary;
      case AppButtonType.tertiary:
        return theme.colorScheme.onTertiary;
      case AppButtonType.success:
      case AppButtonType.warning:
      case AppButtonType.error:
      case AppButtonType.info:
        return Colors.white;
    }
  }
}
