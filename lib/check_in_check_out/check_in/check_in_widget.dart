import 'package:flutter/material.dart';
import 'check_in_model.dart';

export 'check_in_model.dart';

/// Stub widget for CheckIn
class CheckInWidget extends StatefulWidget {
  const CheckInWidget({super.key});

  @override
  State<CheckInWidget> createState() => _CheckInWidgetState();
}

class _CheckInWidgetState extends State<CheckInWidget> {
  late CheckInModel _model;

  @override
  void initState() {
    super.initState();
    _model = CheckInModel();
    _model.initState(context);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check In')),
      body: const Center(
        child: Text('Check In Page - Stub Implementation'),
      ),
    );
  }
}
