import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/check_in_provider.dart';

class CheckInPage extends StatelessWidget {
  const CheckInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckInProvider(),
      child: const CheckInView(),
    );
  }
}

class CheckInView extends StatelessWidget {
  const CheckInView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CheckInProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Check In'),
      ),
      body: Center(
        child: provider.isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (provider.error != null)
                    Text(
                      provider.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: provider.performCheckIn,
                    child: const Text('Check In'),
                  ),
                ],
              ),
      ),
    );
  }
}