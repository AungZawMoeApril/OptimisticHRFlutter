import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import '/index.dart';
import 'check_in_widget.dart' show CheckInWidget;
import 'package:flutter/material.dart';

class $1Model extends BaseViewModel {
  ///  Local state fields for this page.

  String clockInTime = '-';

  String clockInLocation = '-';

  String clockInLattitude = '-';

  String clockInLongitude = '-';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (apiGetAddress)] action in CheckIn widget.
  ApiCallResponse? apiResultr13;
  // State field(s) for forgotCheckIn widget.
  bool? forgotCheckInValue;
  // State field(s) for Off-site widget.
  bool? offSiteValue;
  // State field(s) for Details widget.
  FocusNode? detailsFocusNode;
  TextEditingController? detailsTextController;
  String? Function(BuildContext, String?)? detailsTextControllerValidator;
  bool isDataUploading_clockinImage = false;
  FFUploadedFile uploadedLocalFile_clockinImage =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (GetCheckInImageURL)] action in Column widget.
  ApiCallResponse? apiResultGetCheckInImageURL;
  // Stores action output result for [Backend Call - API (AddClockInOut)] action in Button widget.
  ApiCallResponse? apiResultAddClockInOut;
  // Stores action output result for [Backend Call - API (GetDayViewOfSTA)] action in Button widget.
  ApiCallResponse? apiResultGetDayViewOfSTA;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    detailsFocusNode?.dispose();
    detailsTextController?.dispose();
  }
}
