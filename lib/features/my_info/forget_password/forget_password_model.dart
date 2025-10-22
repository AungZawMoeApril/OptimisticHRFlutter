import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import '/index.dart';
import 'forget_password_widget.dart' show ForgetPasswordWidget;
import 'package:flutter/material.dart';

class $1Model extends BaseViewModel {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    companyCodeFocusNode?.dispose();
    companyCodeTextController?.dispose();

    usernameFocusNode?.dispose();
    usernameTextController?.dispose();
  }
}
