import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '../../core/presentation/base/base_view.dart';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OvertimeDetailModel extends BaseViewModel {
  ///  Local state fields for this page.

  OTCheckInReqStruct? otCheckInReq;
  void updateOtCheckInReqStruct(Function(OTCheckInReqStruct) updateFn) {
    updateFn(otCheckInReq ??= OTCheckInReqStruct());
  }

  List<String> attachmentModel = [];
  void addToAttachmentModel(String item) => attachmentModel.add(item);
  void removeFromAttachmentModel(String item) => attachmentModel.remove(item);
  void removeAtIndexFromAttachmentModel(int index) => attachmentModel.removeAt(index);
  void insertAtIndexInAttachmentModel(int index, String item) =>
      attachmentModel.insert(index, item);
  void updateAttachmentModelAtIndex(int index, Function(String) updateFn) =>
      attachmentModel[index] = updateFn(attachmentModel[index]);

  int? checkInClockID;

  OTCheckOutRequestStruct? otCheckOutReq;
  void updateOtCheckOutReqStruct(Function(OTCheckOutRequestStruct) updateFn) {
    updateFn(otCheckOutReq ??= OTCheckOutRequestStruct());
  }

  String? checkInTime;

  String? checkOutTime;

  dynamic overtimeDetails;

  ///  State fields for stateful widgets in this page.

  DateTime? datePicked;
  bool isDataUploading_uploadDataF93 = false;
  Uint8List? uploadedLocalFile_uploadDataF93;

  // Stores action output result for [Backend Call - API (GetCheckInImageURL)] action in Column widget.
  ApiCallResponse? apiResultGetCheckInImageURL;
  // Stores action output result for [Backend Call - API (OTCheckInMobile)] action in Button widget.
  ApiCallResponse? apiResultOtCheckIn;

  void initState(BuildContext context) {}

  @override
  void dispose() {
    super.dispose();
  }
}
