import 'package:flutter/material.dart';
import 'check_out_merged_model.dart';

export 'check_out_merged_model.dart';

/// Stub widget for CheckOutMerged
class CheckOutMergedWidget extends StatefulWidget {
  const CheckOutMergedWidget({super.key});

  @override
  State<CheckOutMergedWidget> createState() => _CheckOutMergedWidgetState();
}

class _CheckOutMergedWidgetState extends State<CheckOutMergedWidget> {
  late CheckOutMergedModel _model;

  @override
  void initState() {
    super.initState();
    _model = CheckOutMergedModel();
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
      appBar: AppBar(title: const Text('Check Out Merged')),
      body: const Center(
        child: Text('Check Out Merged Page - Stub Implementation'),
      ),
    );
  }
}
