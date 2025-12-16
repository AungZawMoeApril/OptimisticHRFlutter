import 'package:flutter/material.dart';
import 'delete_o_t_request_dialog_model.dart';

export 'delete_o_t_request_dialog_model.dart';

/// Stub widget for DeleteOTRequestDialog
class DeleteOTRequestDialogWidget extends StatefulWidget {
  const DeleteOTRequestDialogWidget({super.key, this.oTID});

  final String? oTID;

  @override
  State<DeleteOTRequestDialogWidget> createState() => _DeleteOTRequestDialogWidgetState();
}

class _DeleteOTRequestDialogWidgetState extends State<DeleteOTRequestDialogWidget> {
  late DeleteOTRequestDialogModel _model;

  @override
  void initState() {
    super.initState();
    _model = DeleteOTRequestDialogModel();
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
