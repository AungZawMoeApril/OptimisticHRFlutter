import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pin_code_provider.dart';
import '../widgets/pin_code_display.dart';
import '../widgets/pin_code_keyboard.dart';

class PinCodeSetupScreen extends StatelessWidget {
  const PinCodeSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PinCodeProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Set PIN Code',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                PinCodeDisplay(
                  pinCode: provider.pinCode,
                  isError: provider.error != null,
                ),
                const SizedBox(height: 32),
                if (provider.error != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      provider.error!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                const Spacer(),
                PinCodeKeyboard(
                  onDigitPressed: (digit) => provider.addDigit(digit),
                  onBackspacePressed: () => provider.removeDigit(),
                  onBiometricPressed: () => provider.startBiometricAuth(),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => provider.setupPinCode(),
                  child: const Text('Set PIN Code'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}