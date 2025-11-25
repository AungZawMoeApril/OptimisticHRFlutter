import 'package:flutter/material.dart';
import 'my_approval_pending_reject_model.dart';

export 'my_approval_pending_reject_model.dart';

/// Stub widget for MyApprovalPendingReject
class MyApprovalPendingRejectWidget extends StatefulWidget {
  const MyApprovalPendingRejectWidget({super.key});

  @override
  State<MyApprovalPendingRejectWidget> createState() =>
      _MyApprovalPendingRejectWidgetState();
}

class _MyApprovalPendingRejectWidgetState
    extends State<MyApprovalPendingRejectWidget> {
  late MyApprovalPendingRejectModel _model;

  @override
  void initState() {
    super.initState();
    _model = MyApprovalPendingRejectModel();
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
