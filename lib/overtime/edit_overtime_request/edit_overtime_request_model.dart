import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import 'package:hr_app/core/utils/form_field_controller.dart';
import '/index.dart';
import 'edit_overtime_request_widget.dart' show EditOvertimeRequestWidget;
import 'package:flutter/material.dart';

class EditOvertimeRequestModel
    extends FlutterFlowModel<EditOvertimeRequestWidget> {
  ///  Local state fields for this page.

  List<String> attachmentModel = [];
  void addToAttachmentModel(String item) => attachmentModel.add(item);
  void removeFromAttachmentModel(String item) => attachmentModel.remove(item);
  void removeAtIndexFromAttachmentModel(int index) =>
      attachmentModel.removeAt(index);
  void insertAtIndexInAttachmentModel(int index, String item) =>
      attachmentModel.insert(index, item);
  void updateAttachmentModelAtIndex(int index, Function(String) updateFn) =>
      attachmentModel[index] = updateFn(attachmentModel[index]);

  String? startDate;

  String? endDate;

  String? startTime;

  String? endTime;

  String? description;

  List<String> imageListDataBind = [];
  void addToImageListDataBind(String item) => imageListDataBind.add(item);
  void removeFromImageListDataBind(String item) =>
      imageListDataBind.remove(item);
  void removeAtIndexFromImageListDataBind(int index) =>
      imageListDataBind.removeAt(index);
  void insertAtIndexInImageListDataBind(int index, String item) =>
      imageListDataBind.insert(index, item);
  void updateImageListDataBindAtIndex(int index, Function(String) updateFn) =>
      imageListDataBind[index] = updateFn(imageListDataBind[index]);

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
  bool isDataUploading_uploadData4m1 = false;
  FFUploadedFile uploadedLocalFile_uploadData4m1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (GetCheckInImageURL)] action in Container widget.
  ApiCallResponse? apiResultGetCheckinImageURL;
  // Stores action output result for [Backend Call - API (UpdateOTRequest)] action in Button widget.
  ApiCallResponse? apiDateOTRequest;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
