import 'package:flutter/material.dart';
import 'check_in_over_all_model.dart';

export 'check_in_over_all_model.dart';

/// Stub widget for CheckInOverAll
class CheckInOverAllWidget extends StatefulWidget {
  const CheckInOverAllWidget({super.key});

  @override
  State<CheckInOverAllWidget> createState() => _CheckInOverAllWidgetState();
}

class _CheckInOverAllWidgetState extends State<CheckInOverAllWidget> {
  late CheckInOverAllModel _model;

  @override
  void initState() {
    super.initState();
    _model = CheckInOverAllModel();
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
      appBar: AppBar(title: const Text('Check In Overall')),
      body: const Center(
        child: Text('Check In Overall Page - Stub Implementation'),
      ),
    );
  }
}
