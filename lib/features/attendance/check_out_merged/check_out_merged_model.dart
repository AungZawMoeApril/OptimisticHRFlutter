import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '../core/utils/app_utils.dart';;
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'check_out_merged_widget.dart' show CheckOutMergedWidget;
import 'package:flutter/material.dart';

class $1Model extends BaseViewModel {
  ///  Local state fields for this page.

  AddressLatLngDataModelStruct? currentLocationLatLng;
  void updateCurrentLocationLatLngStruct(
      Function(AddressLatLngDataModelStruct) updateFn) {
    updateFn(currentLocationLatLng ??= AddressLatLngDataModelStruct());
  }

  String? checkOutAddress;

  double? radius;

  bool? statusAllLocation;

  int? locationaccuracy;

  AddressLatLngDataModelStruct? lastKnowLocation;
  void updateLastKnowLocationStruct(
      Function(AddressLatLngDataModelStruct) updateFn) {
    updateFn(lastKnowLocation ??= AddressLatLngDataModelStruct());
  }

  String? worklocationName;

  AddressLatLngDataModelStruct? currentLocationLatLngCheckOut;
  void updateCurrentLocationLatLngCheckOutStruct(
      Function(AddressLatLngDataModelStruct) updateFn) {
    updateFn(currentLocationLatLngCheckOut ??= AddressLatLngDataModelStruct());
  }

  int? checkOutLocationStatus;

  bool? checkoutstatus;

  double? checkOutradius;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetAllLocationsByCompanyID)] action in CheckOutMerged widget.
  ApiCallResponse? apiResultLocation;
  // Stores action output result for [Backend Call - API (apiGetAddress)] action in CheckOutMerged widget.
  ApiCallResponse? apiGetAddressCheckOut;
  // Stores action output result for [Backend Call - API (apiGetAddress)] action in CheckOutMerged widget.
  ApiCallResponse? apiGetAddressResult;
  // Stores action output result for [Backend Call - API (GetDefaultSetting)] action in CheckOutMerged widget.
  ApiCallResponse? apiGetDefaultSettingResult;
  bool isDataUploading_uploadDataCheckOutImage = false;
  FFUploadedFile uploadedLocalFile_uploadDataCheckOutImage =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (GetCheckInImageURL)] action in Container widget.
  ApiCallResponse? apiResultCheckOutImage;
  // Stores action output result for [Backend Call - API (GetDayViewOfSTA)] action in Button widget.
  ApiCallResponse? apiResultGetDayViewOfSTA;
  // Stores action output result for [Backend Call - API (UpdateClockInOut)] action in Button widget.
  ApiCallResponse? apiResultUpdateClockInOut;
  // Stores action output result for [Backend Call - API (UpdateClockInOut)] action in Button widget.
  ApiCallResponse? apiResultUpdateOTClockInOut;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
  Future getaddress(BuildContext context) async {
    int? accuracyvalue;
    ApiCallResponse? getaddressresponse;

    accuracyvalue = await actions.calculateAccuracyLocation();
    locationaccuracy = accuracyvalue;
    getaddressresponse = await ApiGetAddressCall.call(
      originalValue:
          '${'${currentLocationLatLngCheckOut?.latitude.toString()},${currentLocationLatLngCheckOut?.longitude.toString()}'}',
      userId: ' 501afb52-6d63-481f-4cba-08dcd9195c86',
      companyId: 'bda0f20e-0784-4f90-3701-08dccbc8d8e9',
    );

    if ((getaddressresponse.succeeded ?? true)) {
      checkOutAddress = ApiGetAddressCall.location(
        (getaddressresponse.jsonBody ?? ''),
      );
    }
  }
}
