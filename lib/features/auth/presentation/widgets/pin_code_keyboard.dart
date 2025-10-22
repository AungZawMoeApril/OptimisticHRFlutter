import 'package:flutter/material.dart';

class PinCodeKeyboard extends StatelessWidget {
  final Function(String) onDigitPressed;
  final VoidCallback onBackspacePressed;
  final VoidCallback onBiometricPressed;

  const PinCodeKeyboard({
    super.key,
    required this.onDigitPressed,
    required this.onBackspacePressed,
    required this.onBiometricPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1.5,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildDigitButton('1'),
        _buildDigitButton('2'),
        _buildDigitButton('3'),
        _buildDigitButton('4'),
        _buildDigitButton('5'),
        _buildDigitButton('6'),
        _buildDigitButton('7'),
        _buildDigitButton('8'),
        _buildDigitButton('9'),
        _buildBiometricButton(),
        _buildDigitButton('0'),
        _buildBackspaceButton(),
      ],
    );
  }

  Widget _buildDigitButton(String digit) {
    return TextButton(
      onPressed: () => onDigitPressed(digit),
      child: Text(
        digit,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return IconButton(
      onPressed: onBackspacePressed,
      icon: const Icon(Icons.backspace_outlined),
    );
  }

  Widget _buildBiometricButton() {
    return IconButton(
      onPressed: onBiometricPressed,
      icon: const Icon(Icons.fingerprint),
    );
  }
}