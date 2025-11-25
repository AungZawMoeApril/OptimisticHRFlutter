import 'package:flutter/material.dart';
import 'delete_leave_request_dialog_model.dart';

export 'delete_leave_request_dialog_model.dart';

/// Stub widget for DeleteLeaveRequestDialog
class DeleteLeaveRequestDialogWidget extends StatefulWidget {
  const DeleteLeaveRequestDialogWidget({
    super.key,
    this.reqID,
    this.leaveID,
    this.timeOffRequestID,
    this.reason,
  });

  final String? reqID;
  final String? leaveID;
  final dynamic timeOffRequestID;
  final String? reason;

  @override
  State<DeleteLeaveRequestDialogWidget> createState() =>
      _DeleteLeaveRequestDialogWidgetState();
}

class _DeleteLeaveRequestDialogWidgetState
    extends State<DeleteLeaveRequestDialogWidget> {
  late DeleteLeaveRequestDialogModel _model;

  @override
  void initState() {
    super.initState();
    _model = DeleteLeaveRequestDialogModel();
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
