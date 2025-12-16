import '/backend/api_requests/api_calls.dart';
import '../../core/presentation/base/base_view.dart';
import 'package:flutter/material.dart';

class ForgetPasswordModel extends BaseViewModel {
  ///  Local state fields for this page.

  int? companyID;

  int? userId;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetCompany)] action in ForgetPassword widget.
  ApiCallResponse? apiResultGetCompany;
  // State field(s) for companyCode widget.
  FocusNode? companyCodeFocusNode;
  TextEditingController? companyCodeTextController;
  String? Function(BuildContext, String?)? companyCodeTextControllerValidator;
  // State field(s) for username widget.
  FocusNode? usernameFocusNode;
  TextEditingController? usernameTextController;
  String? Function(BuildContext, String?)? usernameTextControllerValidator;
  // Stores action output result for [Backend Call - API (getUserbyCompanyId)] action in Button-ResetPassword widget.
  ApiCallResponse? apiResultGetuserbyCompanyID;
  // Stores action output result for [Backend Call - API (ForgotPassword)] action in Button-ResetPassword widget.
  ApiCallResponse? apiResultz9c;

  void initState(BuildContext context) {}

  @override
  void dispose() {
    companyCodeFocusNode?.dispose();
    companyCodeTextController?.dispose();

    usernameFocusNode?.dispose();
    usernameTextController?.dispose();

    super.dispose();
  }
}
