import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import '/index.dart';
import 'check_out_widget.dart' show CheckOutWidget;
import 'package:flutter/material.dart';

class $1Model extends BaseViewModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  bool isDataUploading_uploadDataR9gd = false;
  FFUploadedFile uploadedLocalFile_uploadDataR9gd =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (GetDayViewOfSTA)] action in Button widget.
  ApiCallResponse? apiResultGetDayViewOfSTA;
  // Stores action output result for [Backend Call - API (UpdateClockInOut)] action in Button widget.
  ApiCallResponse? apiUpdateClockInOutResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
