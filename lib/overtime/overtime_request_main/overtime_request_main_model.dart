import 'package:flutter/material.dart';
import '/core/utils/app_utils.dart';
import '/core/utils/form_field_controller.dart';
import '/backend/api_requests/api_calls.dart';
import 'overtime_request_main_widget.dart' show OvertimeRequestMainWidget;

// FFUploadedFile class for file uploads
class FFUploadedFile {
  final String? name;
  final String? path;
  final List<int>? bytes;

  FFUploadedFile({this.name, this.path, this.bytes});
}

class OvertimeRequestMainModel extends FlutterFlowModel<OvertimeRequestMainWidget> {
  /// State fields for text input
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  
  /// State fields for dates
  DateTime? datePicked1;
  DateTime? datePicked2;
  DateTime? datePicked3;
  DateTime? datePicked4;
  
  /// State fields for times
  DateTime? oTStartDate;
  DateTime? oTEndDate;
  String? oTStartTime;
  String? oTEndTime;
  
  /// State fields for dropdowns
  int? dropDownValue1;
  FormFieldController<int>? dropDownValueController1;
  
  /// State fields for file uploads
  List<FFUploadedFile> uploadedFilesList = [];
  bool isDataUploading = false;
  FFUploadedFile? uploadedLocalFile;
  ApiCallResponse? apiResultGetImageURL;
  List<String> attachmentModel = [];
  
  /// API call results
  ApiCallResponse? getworkFlowOfOTRequestAPI;
  ApiCallResponse? addNotificationInfoMobResult;
  int? wfID;
  int? senderID;
  
  /// Methods for managing attachments
  void addToAttachmentModel(String item) => attachmentModel.add(item);
  void removeFromAttachmentModel(String item) => attachmentModel.remove(item);
  void removeAtIndexFromAttachmentModel(int index) => attachmentModel.removeAt(index);
  void updateAttachmentModelAtIndex(int index, String Function(String) updateFn) {
    attachmentModel[index] = updateFn(attachmentModel[index]);
  }
  void insertAtIndexInAttachmentModel(int index, String item) {
    attachmentModel.insert(index, item);
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
