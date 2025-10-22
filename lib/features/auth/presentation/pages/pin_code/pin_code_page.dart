import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/local_auth.dart';
import 'package:hr_app/core/theme/app_theme.dart';
import 'package:hr_app/core/widgets/app_icon_button.dart';
import '../../../../../core/routes/app_router.dart';
import '../../providers/auth_provider.dart';

class PinCodePage extends StatefulWidget {
  const PinCodePage({Key? key}) : super(key: key);

  static String routeName = 'PinCode';
  static String routePath = '/pinCode';

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  final List<String> _pinDigits = List.generate(4, (_) => '');
  int _currentDigitIndex = 0;
  bool _isSetupMode = false;
  String _firstPinInput = '';
  bool _isConfirmation = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    if (_isSetupMode) return;

    final localAuth = LocalAuthentication();
    final isBiometricSupported = await localAuth.isDeviceSupported();

    if (isBiometricSupported) {
      try {
        final isAuthenticated = await localAuth.authenticate(
          localizedReason: 'Please authenticate to continue',
        );

        if (isAuthenticated && mounted) {
          AppRouter.router.go('/home');
        }
      } on PlatformException {
        // Biometric authentication failed
      }
    }
  }

  void _onDigitPress(String digit) {
    if (_currentDigitIndex >= 4) return;

    setState(() {
      _pinDigits[_currentDigitIndex] = digit;
      _currentDigitIndex++;
    });

    if (_currentDigitIndex == 4) {
      _verifyPin();
    }
  }

  void _onBackspace() {
    if (_currentDigitIndex <= 0) return;

    setState(() {
      _currentDigitIndex--;
      _pinDigits[_currentDigitIndex] = '';
    });
  }

  Future<void> _verifyPin() async {
    final pin = _pinDigits.join();
    final authProvider = context.read<AuthProvider>();

    if (_isSetupMode) {
      if (!_isConfirmation) {
        _firstPinInput = pin;
        setState(() {
          _isConfirmation = true;
          _currentDigitIndex = 0;
          _pinDigits.fillRange(0, 4, '');
        });
        return;
      }

      if (pin == _firstPinInput) {
        await authProvider.createPinCode(pin);
        if (mounted) {
          AppRouter.router.go('/home');
        }
      } else {
        _resetPinInput('PINs do not match. Please try again.');
      }
    } else {
      await authProvider.verifyPinCode(pin);

      if (authProvider.error != null) {
        _resetPinInput('Invalid PIN. Please try again.');
      } else if (authProvider.status.isPinCodeVerified) {
        if (mounted) {
          AppRouter.router.go('/home');
        }
      }
    }
  }

  void _resetPinInput(String message) {
    setState(() {
      _currentDigitIndex = 0;
      _pinDigits.fillRange(0, 4, '');
      if (_isConfirmation) {
        _isConfirmation = false;
        _firstPinInput = '';
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryBackground,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isSetupMode
                  ? _isConfirmation
                      ? 'Confirm your PIN'
                      : 'Create your PIN'
                  : 'Enter your PIN',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final digit = _pinDigits[index];
                return Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: digit.isNotEmpty
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondaryText.withOpacity(0.3),
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.5,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index == 9) {
                    return const SizedBox.shrink();
                  }

                  if (index == 10) {
                    return InkWell(
                      onTap: () => _onDigitPress('0'),
                      child: Center(
                        child: Text(
                          '0',
                          style: context.textTheme.displaySmall,
                        ),
                      ),
                    );
                  }

                  if (index == 11) {
                    return InkWell(
                      onTap: _onBackspace,
                      child: Center(
                        child: Icon(
                          Icons.backspace,
                          color: Theme.of(context).colorScheme.primaryText,
                        ),
                      ),
                    );
                  }

                  final number = (index + 1).toString();
                  return InkWell(
                    onTap: () => _onDigitPress(number),
                    child: Center(
                      child: Text(
                        number,
                        style: context.textTheme.displaySmall,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}