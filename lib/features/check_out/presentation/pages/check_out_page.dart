import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/check_out_provider.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckOutProvider(),
      child: const CheckOutView(),
    );
  }
}

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CheckOutProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Out'),
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
                    onPressed: provider.performCheckOut,
                    child: const Text('Check Out'),
                  ),
                ],
              ),
      ),
    );
  }
}