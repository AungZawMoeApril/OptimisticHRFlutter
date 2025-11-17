import 'package:flutter/material.dart';
import '/core/utils/app_utils.dart';
import '/core/utils/form_field_controller.dart';
import '/backend/api_requests/api_calls.dart';
import 'leave_request_widget.dart' show LeaveRequestWidget, FFUploadedFile;

class LeaveRequestModel extends FlutterFlowModel<LeaveRequestWidget> {
  /// State fields for API calls
  ApiCallResponse? apiResultRemainingDays;
  ApiCallResponse? apiResultAddTimeOffRequestForEMPWholeDay;
  ApiCallResponse? apiResultAddTimeOffRequestForEMPHalfDay;
  ApiCallResponse? getworkFlowOfOTRequestAPI;
  ApiCallResponse? addNotificationInfoMobResult;
  int? wfID;
  int? senderID;
  
  /// State fields for form values
  int? ddlLeaveTypeValue;
  FormFieldController<int>? ddlLeaveTypeValueController;
  double? balance;
  double? availableDay;
  bool isAllDay = true;
  DateTime? datePicked1;
  DateTime? datePicked2;
  DateTime? datePicked3;
  DateTime? datePicked4;
  DateTime? datePicked5;
  DateTime? datePicked6;
  
  /// State fields for TextFields
  FocusNode? txtDescriptionFocusNode;
  TextEditingController? txtDescriptionTextController;
  String? Function(BuildContext, String?)? txtDescriptionTextControllerValidator;
  
  /// State fields for file uploads
  List<FFUploadedFile> uploadedFiles = [];
  bool isDataUploading_uploadDataleave = false;
  FFUploadedFile? uploadedLocalFile_uploadDataleave;
  ApiCallResponse? apiResultGetCheckinImageURL;
  List<String> attachmentModel = [];
  
  /// Methods for managing attachment list
  void addToAttachmentModel(String item) {
    attachmentModel.add(item);
  }
  
  void removeFromAttachmentModel(String item) {
    attachmentModel.remove(item);
  }
  
  @override
  void initState(BuildContext context) {
    super.initState(context);
  }

  @override
  void dispose() {
    txtDescriptionFocusNode?.dispose();
    txtDescriptionTextController?.dispose();
  }
}
