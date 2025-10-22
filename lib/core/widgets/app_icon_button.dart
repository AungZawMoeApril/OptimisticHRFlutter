import '../core/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final Color? fillColor;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;
  final double buttonSize;
  final bool showLoadingIndicator;

  const AppIconButton({
    Key? key,
    this.onPressed,
    required this.icon,
    this.fillColor,
    this.borderColor,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.buttonSize = 40.0,
    this.showLoadingIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: fillColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
                width: borderWidth,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: showLoadingIndicator ? null : onPressed,
          child: Center(
            child: showLoadingIndicator
                ? SizedBox(
                    width: buttonSize * 0.6,
                    height: buttonSize * 0.6,
                    child: CircularProgressIndicator(
                      color: theme.primaryColor,
                      strokeWidth: 2,
                    ),
                  )
                : icon,
          ),
        ),
      ),
    );
  }
}