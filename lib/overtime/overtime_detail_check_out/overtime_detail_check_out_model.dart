// import '/backend/api_requests/api_calls.dart';
// import '../../core/presentation/base/base_view.dart';
// import 'package:h_r_optimistic_mobile/core/utils/upload_data.dart';

// class OvertimeDetailCheckOutModel extends BaseViewModel {
//   ///  Local state fields for this page.

//   List<String> oTcheckOutImaage = [];
//   void addToOTcheckOutImaage(String item) => oTcheckOutImaage.add(item);
//   void removeFromOTcheckOutImaage(String item) => oTcheckOutImaage.remove(item);
//   void removeAtIndexFromOTcheckOutImaage(int index) => oTcheckOutImaage.removeAt(index);

//   DateTime? datePicked;
//   DateTime? checkInTime;

//   bool isDataUploading_uploadDataVkb = false;
//   FFUploadedFile uploadedLocalFile_uploadDataVkb = FFUploadedFile(bytes: Uint8List(0));

//   List<dynamic> attachmentModel = [];
//   void addToAttachmentModel(dynamic item) => attachmentModel.add(item);
//   void removeFromAttachmentModel(dynamic item) => attachmentModel.remove(item);
//   void removeAtIndexFromAttachmentModel(int index) => attachmentModel.removeAt(index);

//   ApiCallResponse? checkOuttApi;
//   ApiCallResponse? apiResultGetCheckOutImageURL;
//   ApiCallResponse? apiResultOTCheckOut;

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
