import 'package:flutter/material.dart';

class FFButtonOptions {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? iconPadding;
  final Color? color;
  final TextStyle? textStyle;
  final double? elevation;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final IconAlignment? iconAlignment;

  const FFButtonOptions({
    this.width,
    this.height,
    this.padding,
    this.iconPadding,
    this.color,
    this.textStyle,
    this.elevation,
    this.borderRadius,
    this.borderSide,
    this.iconAlignment,
  });
}

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final FFButtonOptions options;
  final Widget? icon;

  const AppButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.options,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buttonContent = Text(
      text,
      style: options.textStyle,
    );

    if (icon != null) {
      buttonContent = Row(
        mainAxisSize: MainAxisSize.min,
        children: options.iconAlignment == IconAlignment.end
            ? [
                buttonContent,
                if (options.iconPadding != null)
                  Padding(
                    padding: options.iconPadding!,
                    child: icon,
                  )
                else
                  icon!,
              ]
            : [
                if (options.iconPadding != null)
                  Padding(
                    padding: options.iconPadding!,
                    child: icon,
                  )
                else
                  icon!,
                buttonContent,
              ],
      );
    }

    return SizedBox(
      width: options.width,
      height: options.height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: options.color,
          padding: options.padding,
          elevation: options.elevation,
          shape: RoundedRectangleBorder(
            borderRadius: options.borderRadius ?? BorderRadius.circular(8.0),
            side: options.borderSide ?? BorderSide.none,
          ),
        ),
        child: buttonContent,
      ),
    );
  }
}
