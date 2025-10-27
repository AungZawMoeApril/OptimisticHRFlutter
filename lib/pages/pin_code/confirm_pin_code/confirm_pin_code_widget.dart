import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app_state.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmPinCodeWidget extends StatefulWidget {
  const ConfirmPinCodeWidget({super.key});

  static String routeName = 'ConfirmPinCode';
  static String routePath = '/confirmPinCode';

  @override
  State<ConfirmPinCodeWidget> createState() => _ConfirmPinCodeWidgetState();
}

class _ConfirmPinCodeWidgetState extends State<ConfirmPinCodeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final pinLength = 6;
  String currentPin = '';
  bool isLoading = false;

  void _handlePinInput(String value) {
    if (isLoading) return;

    setState(() {
      if (currentPin.length < pinLength) {
        currentPin += value;
        if (currentPin.length == pinLength) {
          _confirmPin();
        }
      }
    });
  }

  void _handleBackspace() {
    if (isLoading) return;

    setState(() {
      if (currentPin.isNotEmpty) {
        currentPin = currentPin.substring(0, currentPin.length - 1);
      }
    });
  }

  Future<void> _confirmPin() async {
    setState(() {
      isLoading = true;
    });

    try {
      // TODO: Implement PIN confirmation logic
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      
      if (!mounted) return;

      // Navigate to home page if confirmation is successful
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PIN confirmation failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );

      setState(() {
        currentPin = '';
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget _buildPinDot(bool filled) {
    return Container(
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surfaceVariant,
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: isLoading ? null : () => _handlePinInput(number),
            style: TextButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            ),
            child: Text(
              number,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: true,
        title: Text(
          'Confirm PIN',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontFamily: GoogleFonts.outfit().fontFamily,
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22.0,
              ),
        ),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Confirm your PIN code',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 32),
                  if (isLoading)
                    const CircularProgressIndicator()
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pinLength,
                        (index) => _buildPinDot(index < currentPin.length),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildNumberButton('1'),
                      _buildNumberButton('2'),
                      _buildNumberButton('3'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildNumberButton('4'),
                      _buildNumberButton('5'),
                      _buildNumberButton('6'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildNumberButton('7'),
                      _buildNumberButton('8'),
                      _buildNumberButton('9'),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      _buildNumberButton('0'),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: isLoading ? null : _handleBackspace,
                              style: TextButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor:
                                    Theme.of(context).colorScheme.surfaceVariant,
                              ),
                              child: const Icon(Icons.backspace),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}