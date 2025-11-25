import 'package:flutter/material.dart';
import 'delete_leave_request_model.dart';

export 'delete_leave_request_model.dart';

/// Stub widget for DeleteLeaveRequest
class DeleteLeaveRequestWidget extends StatefulWidget {
  const DeleteLeaveRequestWidget({super.key});

  @override
  State<DeleteLeaveRequestWidget> createState() =>
      _DeleteLeaveRequestWidgetState();
}

class _DeleteLeaveRequestWidgetState extends State<DeleteLeaveRequestWidget> {
  late DeleteLeaveRequestModel _model;

  @override
  void initState() {
    super.initState();
    _model = DeleteLeaveRequestModel();
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
