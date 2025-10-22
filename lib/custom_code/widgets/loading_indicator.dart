// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';;
import '../core/utils/app_utils.dart';;
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:hr_app/core/utils/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: widget.width ?? 50.0,
      height: widget.height ?? 50.0,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).colorScheme.primary, // Ensure correct theme color
        ),
        strokeWidth: 4,
      ),
    ));
  }
}
