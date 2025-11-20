import 'package:flutter/material.dart';
import '/core/utils/app_utils.dart';
import 'leave_request_edit_main_widget.dart' show LeaveRequestEditMainWidget;

class LeaveRequestEditMainModel extends FlutterFlowModel<LeaveRequestEditMainWidget> {
  /// State fields for text input
  FocusNode? txtDescriptionFocusNode;
  TextEditingController? txtDescriptionTextController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    txtDescriptionFocusNode?.dispose();
    txtDescriptionTextController?.dispose();
  }
}
