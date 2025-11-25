import 'package:flutter/material.dart';
import 'check_out_over_all_model.dart';

export 'check_out_over_all_model.dart';

/// Stub widget for CheckOutOverAll
class CheckOutOverAllWidget extends StatefulWidget {
  const CheckOutOverAllWidget({super.key});

  @override
  State<CheckOutOverAllWidget> createState() => _CheckOutOverAllWidgetState();
}

class _CheckOutOverAllWidgetState extends State<CheckOutOverAllWidget> {
  late CheckOutOverAllModel _model;

  @override
  void initState() {
    super.initState();
    _model = CheckOutOverAllModel();
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
      appBar: AppBar(title: const Text('Check Out Over All')),
      body: const Center(
        child: Text('Check Out Over All Page - Stub Implementation'),
      ),
    );
  }
}
