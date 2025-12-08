import 'package:flutter/material.dart';
import 'my_approval_history_cancel_model.dart';

export 'my_approval_history_cancel_model.dart';

/// Stub widget for MyApprovalHistoryCancel
class MyApprovalHistoryCancelWidget extends StatefulWidget {
  const MyApprovalHistoryCancelWidget({super.key});

  @override
  State<MyApprovalHistoryCancelWidget> createState() => _MyApprovalHistoryCancelWidgetState();
}

class _MyApprovalHistoryCancelWidgetState extends State<MyApprovalHistoryCancelWidget> {
  late MyApprovalHistoryCancelModel _model;

  @override
  void initState() {
    super.initState();
    _model = MyApprovalHistoryCancelModel();
    _model.initState(context);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
