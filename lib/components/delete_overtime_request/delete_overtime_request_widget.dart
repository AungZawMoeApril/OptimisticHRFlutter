import 'package:flutter/material.dart';
import 'delete_overtime_request_model.dart';

export 'delete_overtime_request_model.dart';

/// Stub widget for DeleteOvertimeRequest
class DeleteOvertimeRequestWidget extends StatefulWidget {
  const DeleteOvertimeRequestWidget({super.key});

  @override
  State<DeleteOvertimeRequestWidget> createState() =>
      _DeleteOvertimeRequestWidgetState();
}

class _DeleteOvertimeRequestWidgetState
    extends State<DeleteOvertimeRequestWidget> {
  late DeleteOvertimeRequestModel _model;

  @override
  void initState() {
    super.initState();
    _model = DeleteOvertimeRequestModel();
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
