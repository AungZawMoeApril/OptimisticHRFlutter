import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '../core/utils/app_utils.dart';;
import 'package:hr_app/core/utils/form_field_controller.dart';
import '/index.dart';
import 'leave_request_widget.dart' show LeaveRequestWidget;
import 'package:flutter/material.dart';

class LeaveRequestModel extends FlutterFlowModel<LeaveRequestWidget> {
  ///  Local state fields for this page.

  bool isAllDay = true;

  List<String> attachmentModel = [];
  void addToAttachmentModel(String item) => attachmentModel.add(item);
  void removeFromAttachmentModel(String item) => attachmentModel.remove(item);
  void removeAtIndexFromAttachmentModel(int index) =>
      attachmentModel.removeAt(index);
  void insertAtIndexInAttachmentModel(int index, String item) =>
      attachmentModel.insert(index, item);
  void updateAttachmentModelAtIndex(int index, Function(String) updateFn) =>
      attachmentModel[index] = updateFn(attachmentModel[index]);

  List<BalanceDaysStruct> remainingDays = [];
  void addToRemainingDays(BalanceDaysStruct item) => remainingDays.add(item);
  void removeFromRemainingDays(BalanceDaysStruct item) =>
      remainingDays.remove(item);
  void removeAtIndexFromRemainingDays(int index) =>
      remainingDays.removeAt(index);
  void insertAtIndexInRemainingDays(int index, BalanceDaysStruct item) =>
      remainingDays.insert(index, item);
  void updateRemainingDaysAtIndex(
          int index, Function(BalanceDaysStruct) updateFn) =>
      remainingDays[index] = updateFn(remainingDays[index]);

  int? balance;

  int? availableDay = 0;

  int? wfID;

  int? senderID;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetLeaveWithRemainingDays)] action in LeaveRequest widget.
  ApiCallResponse? apiResultRemainingDays;
  // State field(s) for ddlLeaveType widget.
  int? ddlLeaveTypeValue;
  FormFieldController<int>? ddlLeaveTypeValueController;
  DateTime? datePicked1;
  DateTime? datePicked2;
  DateTime? datePicked3;
  DateTime? datePicked4;
  DateTime? datePicked5;
  // State field(s) for txtDescription widget.
  FocusNode? txtDescriptionFocusNode;
  TextEditingController? txtDescriptionTextController;
  String? Function(BuildContext, String?)?
      txtDescriptionTextControllerValidator;
  bool isDataUploading_uploadDataleave = false;
  FFUploadedFile uploadedLocalFile_uploadDataleave =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (GetCheckInImageURL)] action in Column widget.
  ApiCallResponse? apiResultGetCheckinImageURL;
  // Stores action output result for [Backend Call - API (AddTimeOffRequestForEMPWholeDay)] action in Button widget.
  ApiCallResponse? apiResultAddTimeOffRequestForEMPWholeDay;
  // Stores action output result for [Backend Call - API (GetworkFlowOfOTRequest)] action in Button widget.
  ApiCallResponse? getworkFlowOfOTRequestAPI;
  // Stores action output result for [Backend Call - API (AddNotificationInfoMob)] action in Button widget.
  ApiCallResponse? addNotificationInfoMobResult;
  // Stores action output result for [Backend Call - API (AddTimeOffRequestForEMPHalfDay)] action in Button widget.
  ApiCallResponse? apiResultAddTimeOffRequestForEMPHalfDay;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    txtDescriptionFocusNode?.dispose();
    txtDescriptionTextController?.dispose();
  }
}
