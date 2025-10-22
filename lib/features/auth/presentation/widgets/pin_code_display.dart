import 'package:flutter/material.dart';

class PinCodeDisplay extends StatelessWidget {
  final List<String> pinCode;
  final bool isError;

  const PinCodeDisplay({
    super.key,
    required this.pinCode,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isError
                ? Colors.red
                : index < pinCode.length
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
          ),
        ),
      ),
    );
  }
}