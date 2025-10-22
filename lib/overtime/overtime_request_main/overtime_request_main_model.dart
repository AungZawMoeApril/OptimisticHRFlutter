import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '../core/utils/app_utils.dart';;
import 'package:hr_app/core/utils/form_field_controller.dart';
import '/index.dart';
import 'overtime_request_main_widget.dart' show OvertimeRequestMainWidget;
import 'package:flutter/material.dart';

class OvertimeRequestMainModel
    extends FlutterFlowModel<OvertimeRequestMainWidget> {
  ///  Local state fields for this page.

  ReqStaffOTRequestStruct? reqstaffotrequest;
  void updateReqstaffotrequestStruct(
      Function(ReqStaffOTRequestStruct) updateFn) {
    updateFn(reqstaffotrequest ??= ReqStaffOTRequestStruct());
  }

  List<String> attachmentModel = [];
  void addToAttachmentModel(String item) => attachmentModel.add(item);
  void removeFromAttachmentModel(String item) => attachmentModel.remove(item);
  void removeAtIndexFromAttachmentModel(int index) =>
      attachmentModel.removeAt(index);
  void insertAtIndexInAttachmentModel(int index, String item) =>
      attachmentModel.insert(index, item);
  void updateAttachmentModelAtIndex(int index, Function(String) updateFn) =>
      attachmentModel[index] = updateFn(attachmentModel[index]);

  int? wFID;

  int? senderID;

  ///  State fields for stateful widgets in this page.

  DateTime? datePicked1;
  DateTime? datePicked2;
  DateTime? datePicked3;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  bool isDataUploading_uploadDataEditOTRequest = false;
  FFUploadedFile uploadedLocalFile_uploadDataEditOTRequest =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (GetCheckInImageURL)] action in Container widget.
  ApiCallResponse? apiResultGetCheckinImageURL;
  // Stores action output result for [Backend Call - API (OTRequest)] action in Button widget.
  ApiCallResponse? apiResultuOT;
  // Stores action output result for [Backend Call - API (GetworkFlowOfOTRequest)] action in Button widget.
  ApiCallResponse? getworkFlowOfOTRequestResult;
  // Stores action output result for [Backend Call - API (AddNotificationInfoMob)] action in Button widget.
  ApiCallResponse? addNotiResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
