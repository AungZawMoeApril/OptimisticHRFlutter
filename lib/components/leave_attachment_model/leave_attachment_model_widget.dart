import 'package:flutter/material.dart';
import 'leave_attachment_model_model.dart';

export 'leave_attachment_model_model.dart';

/// Stub widget for LeaveAttachmentModel
class LeaveAttachmentModelWidget extends StatefulWidget {
  const LeaveAttachmentModelWidget({
    super.key,
    this.attachmentListJson,
    this.timeOffRequestID,
    this.reason,
  });

  final dynamic attachmentListJson;
  final dynamic timeOffRequestID;
  final dynamic reason;

  @override
  State<LeaveAttachmentModelWidget> createState() =>
      _LeaveAttachmentModelWidgetState();
}

class _LeaveAttachmentModelWidgetState
    extends State<LeaveAttachmentModelWidget> {
  late LeaveAttachmentModelModel _model;

  @override
  void initState() {
    super.initState();
    _model = LeaveAttachmentModelModel();
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
