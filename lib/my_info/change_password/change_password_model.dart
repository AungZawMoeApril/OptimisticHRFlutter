import '/backend/api_requests/api_calls.dart';
import '../core/utils/app_utils.dart';;
import '/index.dart';
import 'change_password_widget.dart' show ChangePasswordWidget;
import 'package:flutter/material.dart';

class $1Model extends BaseViewModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for CurrentPasswordField widget.
  FocusNode? currentPasswordFieldFocusNode;
  TextEditingController? currentPasswordFieldTextController;
  late bool currentPasswordFieldVisibility;
  String? Function(BuildContext, String?)?
      currentPasswordFieldTextControllerValidator;
  // State field(s) for NewPasswordField widget.
  FocusNode? newPasswordFieldFocusNode;
  TextEditingController? newPasswordFieldTextController;
  late bool newPasswordFieldVisibility;
  String? Function(BuildContext, String?)?
      newPasswordFieldTextControllerValidator;
  // State field(s) for ConfirmNewPasswordField widget.
  FocusNode? confirmNewPasswordFieldFocusNode;
  TextEditingController? confirmNewPasswordFieldTextController;
  late bool confirmNewPasswordFieldVisibility;
  String? Function(BuildContext, String?)?
      confirmNewPasswordFieldTextControllerValidator;
  // Stores action output result for [Backend Call - API (ChangePassword)] action in Button-Login widget.
  ApiCallResponse? apiResultChangePassword;

  @override
  void initState(BuildContext context) {
    currentPasswordFieldVisibility = false;
    newPasswordFieldVisibility = false;
    confirmNewPasswordFieldVisibility = false;
  }

  @override
  void dispose() {
    currentPasswordFieldFocusNode?.dispose();
    currentPasswordFieldTextController?.dispose();

    newPasswordFieldFocusNode?.dispose();
    newPasswordFieldTextController?.dispose();

    confirmNewPasswordFieldFocusNode?.dispose();
    confirmNewPasswordFieldTextController?.dispose();
  }
}
