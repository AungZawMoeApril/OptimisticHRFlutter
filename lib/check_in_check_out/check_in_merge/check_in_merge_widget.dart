import 'package:flutter/material.dart';
import 'check_in_merge_model.dart';

export 'check_in_merge_model.dart';

/// Stub widget for CheckInMerge
class CheckInMergeWidget extends StatefulWidget {
  const CheckInMergeWidget({super.key});

  @override
  State<CheckInMergeWidget> createState() => _CheckInMergeWidgetState();
}

class _CheckInMergeWidgetState extends State<CheckInMergeWidget> {
  late CheckInMergeModel _model;

  @override
  void initState() {
    super.initState();
    _model = CheckInMergeModel();
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
      appBar: AppBar(title: const Text('Check In Merge')),
      body: const Center(
        child: Text('Check In Merge Page - Stub Implementation'),
      ),
    );
  }
}
