import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '../core/utils/app_utils.dart';;
import 'package:hr_app/core/utils/form_field_controller.dart';
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';

class $1Model extends BaseViewModel {
  ///  Local state fields for this page.

  List<PaySlipListJsonStruct> paySlipListJson = [];
  void addToPaySlipListJson(PaySlipListJsonStruct item) =>
      paySlipListJson.add(item);
  void removeFromPaySlipListJson(PaySlipListJsonStruct item) =>
      paySlipListJson.remove(item);
  void removeAtIndexFromPaySlipListJson(int index) =>
      paySlipListJson.removeAt(index);
  void insertAtIndexInPaySlipListJson(int index, PaySlipListJsonStruct item) =>
      paySlipListJson.insert(index, item);
  void updatePaySlipListJsonAtIndex(
          int index, Function(PaySlipListJsonStruct) updateFn) =>
      paySlipListJson[index] = updateFn(paySlipListJson[index]);

  List<PaySlipListJsonStruct> paySlipListJsonUse = [];
  void addToPaySlipListJsonUse(PaySlipListJsonStruct item) =>
      paySlipListJsonUse.add(item);
  void removeFromPaySlipListJsonUse(PaySlipListJsonStruct item) =>
      paySlipListJsonUse.remove(item);
  void removeAtIndexFromPaySlipListJsonUse(int index) =>
      paySlipListJsonUse.removeAt(index);
  void insertAtIndexInPaySlipListJsonUse(
          int index, PaySlipListJsonStruct item) =>
      paySlipListJsonUse.insert(index, item);
  void updatePaySlipListJsonUseAtIndex(
          int index, Function(PaySlipListJsonStruct) updateFn) =>
      paySlipListJsonUse[index] = updateFn(paySlipListJsonUse[index]);

  String pdfURLs = 'url';

  String imageFile = 'profileImage';

  String? nickName;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (PaySlip)] action in Profile widget.
  ApiCallResponse? apiResultPaySlip;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  bool isDataUploading_profileUpload = false;
  FFUploadedFile uploadedLocalFile_profileUpload =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (GetCheckInImageURL)] action in CircleImage widget.
  ApiCallResponse? profileImageURL;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Backend Call - API (UpdatePersonalInfoMob)] action in Button-Login widget.
  ApiCallResponse? apiResultUpdatePersonalInfoMob;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
