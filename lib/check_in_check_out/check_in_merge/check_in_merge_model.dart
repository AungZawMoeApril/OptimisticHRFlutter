import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '../core/utils/app_utils.dart';;
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'check_in_merge_widget.dart' show CheckInMergeWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckInMergeModel extends FlutterFlowModel<CheckInMergeWidget> {
  ///  Local state fields for this page.

  String otClockInTime = '-';

  String otClockInLocation = '-';

  String otClockInLattitude = '-';

  String otClockInLongitude = '-';

  AddressLatLngDataModelStruct? currentLocationLatLng;
  void updateCurrentLocationLatLngStruct(
      Function(AddressLatLngDataModelStruct) updateFn) {
    updateFn(currentLocationLatLng ??= AddressLatLngDataModelStruct());
  }

  String? checkinaddress;

  bool forgotCheckIn = true;

  bool offSite = true;

  DateTime? checkInDate;

  DateTime? checkInTime;

  double? radius;

  bool? statusAllLocation;

  String? workinLocationName;

  int? locationaccuracy;

  AddressLatLngDataModelStruct? lastKnowLocation;
  void updateLastKnowLocationStruct(
      Function(AddressLatLngDataModelStruct) updateFn) {
    updateFn(lastKnowLocation ??= AddressLatLngDataModelStruct());
  }

  int? checkOutLocation;

  int? checkInOffSite;

  bool? isCheckInPicture;

  bool? isCheckOutPicture;

  int? isRequireCheckIn;

  int? isRequireCheckOut;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetAllLocationsByCompanyID)] action in CheckInMerge widget.
  ApiCallResponse? apiResultAllLocation;
  // Stores action output result for [Backend Call - API (apiGetAddress)] action in CheckInMerge widget.
  ApiCallResponse? apiGetAddressResultCompany;
  // Stores action output result for [Backend Call - API (apiGetAddress)] action in CheckInMerge widget.
  ApiCallResponse? apiGetAddressResult;
  // Stores action output result for [Backend Call - API (GetDefaultSetting)] action in CheckInMerge widget.
  ApiCallResponse? apiResultu4l;
  // State field(s) for forgotCheckIn widget.
  bool? forgotCheckInValue;
  // State field(s) for Off-site widget.
  bool? offSiteValue;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for Details widget.
  FocusNode? detailsFocusNode;
  TextEditingController? detailsTextController;
  String? Function(BuildContext, String?)? detailsTextControllerValidator;
  bool isDataUploading_uploadDataImage = false;
  FFUploadedFile uploadedLocalFile_uploadDataImage =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (GetCheckInImageURL)] action in Container widget.
  ApiCallResponse? apiResultGetCheckInImageURL;
  DateTime? datePicked;
  // Stores action output result for [Backend Call - API (AddClockInOut)] action in Button widget.
  ApiCallResponse? apiResultAddotClockInOut;
  // Stores action output result for [Backend Call - API (GetDayViewOfSTA)] action in Button widget.
  ApiCallResponse? apiResultGetDayViewOfSTA;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController1?.dispose();

    detailsFocusNode?.dispose();
    detailsTextController?.dispose();
  }

  /// Action blocks.
  Future getaddress(BuildContext context) async {
    int? accuracyvalue;
    ApiCallResponse? getaddressresponse;

    accuracyvalue = await actions.calculateAccuracyLocation();
    locationaccuracy = accuracyvalue;
    getaddressresponse = await ApiGetAddressCall.call(
      originalValue:
          '${'${currentLocationLatLng?.latitude.toString()},${currentLocationLatLng?.longitude.toString()}'}',
      userId: ' 501afb52-6d63-481f-4cba-08dcd9195c86',
      companyId: 'bda0f20e-0784-4f90-3701-08dccbc8d8e9',
    );

    if ((getaddressresponse.succeeded ?? true)) {
      checkinaddress = ApiGetAddressCall.location(
        (getaddressresponse.jsonBody ?? ''),
      );
    }
  }
}
