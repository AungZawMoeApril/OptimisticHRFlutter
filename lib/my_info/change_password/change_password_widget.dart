import '../../core/theme/app_theme_extension.dart';
import '../../core/widgets/app_widgets.dart';
import '/backend/api_requests/api_calls.dart';
import '../../core/widgets/app_icon_button.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_utils.dart';
import '../../core/widgets/app_button.dart';
import '/index.dart';
import '../../core/utils/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/web_view_aware.dart';
import 'change_password_model.dart';
export 'change_password_model.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({super.key});

  static String routeName = 'ChangePassword';
  static String routePath = '/changePassword';

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  late ChangePasswordModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChangePasswordModel());

    _model.currentPasswordFieldTextController ??= TextEditingController();
    _model.currentPasswordFieldFocusNode ??= FocusNode();

    _model.newPasswordFieldTextController ??= TextEditingController();
    _model.newPasswordFieldFocusNode ??= FocusNode();

    _model.confirmNewPasswordFieldTextController ??= TextEditingController();
    _model.confirmNewPasswordFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // context.watch<AppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.primaryBackground,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryBackground,
          automaticallyImplyLeading: false,
          leading: AppIconButton(
            borderColor: Theme.of(context).colorScheme.primary,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            fillColor: Theme.of(context).colorScheme.primary,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).colorScheme.primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              Navigator.of(context).pushNamed(MyInfoWidget.routeName);
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'hhi9oa99' /* Change Password */,
            ),
            style: GoogleFonts.outfit(
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                  color: Theme.of(context).colorScheme.primaryText,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      context.headlineMedium?.fontWeight,
                  fontStyle:
                      context.headlineMedium?.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: MediaQuery.sizeOf(context).height * 1.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryBackground,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'rzjm0nsq' /* Current Password */,
                                      ),
                                      style: Theme.of(context).textTheme.bodyMedium!
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight:
                                                  Theme.of(context).textTheme.bodyMedium!
                                                      .fontWeight,
                                              fontStyle:
                                                  Theme.of(context).textTheme.bodyMedium!
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                Theme.of(context).textTheme.bodyMedium!
                                                    .fontWeight,
                                            fontStyle:
                                                Theme.of(context).textTheme.bodyMedium!
                                                    .fontStyle,
                                          ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _model
                                            .currentPasswordFieldTextController,
                                        focusNode: _model
                                            .currentPasswordFieldFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.currentPasswordFieldTextController',
                                          Duration(milliseconds: 0),
                                          () => safeSetState(() {}),
                                        ),
                                        obscureText: !_model
                                            .currentPasswordFieldVisibility,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelText: FFLocalizations.of(context)
                                              .getText(
                                            'vdbe5arp' /* Current password */,
                                          ),
                                          alignLabelWithHint: false,
                                          hintStyle: Theme.of(context).textTheme.bodyMedium!
                                              .override(
                                                font: GoogleFonts.readexPro(
                                                  fontWeight:
                                                      Theme.of(context).textTheme.bodyMedium!
                                                          .fontWeight,
                                                  fontStyle:
                                                      Theme.of(context).textTheme.bodyMedium!
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF0F1113),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    Theme.of(context).textTheme.bodyMedium!
                                                        .fontWeight,
                                                fontStyle:
                                                    Theme.of(context).textTheme.bodyMedium!
                                                        .fontStyle,
                                              ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  Theme.of(context).colorScheme.surface,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  Theme.of(context).colorScheme.primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          focusedErrorBorder:
                                              UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () => safeSetState(
                                              () => _model
                                                      .currentPasswordFieldVisibility =
                                                  !_model
                                                      .currentPasswordFieldVisibility,
                                            ),
                                            focusNode:
                                                FocusNode(skipTraversal: true),
                                            child: Icon(
                                              _model.currentPasswordFieldVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color:
                                                  Theme.of(context).textTheme.bodyMedium?.color,
                                              size: 20.0,
                                            ),
                                          ),
                                        ),
                                        style: Theme.of(context).textTheme.bodyMedium!
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    Theme.of(context).textTheme.bodyMedium!
                                                        .fontWeight,
                                                fontStyle:
                                                    Theme.of(context).textTheme.bodyMedium!
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF0F1113),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  Theme.of(context).textTheme.bodyMedium!
                                                      .fontWeight,
                                              fontStyle:
                                                  Theme.of(context).textTheme.bodyMedium!
                                                      .fontStyle,
                                            ),
                                        validator: _model
                                            .currentPasswordFieldTextControllerValidator
                                            ?.asValidator(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'xkpp5mbr' /* New Password */,
                                      ),
                                      style: Theme.of(context).textTheme.bodyMedium!
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight:
                                                  Theme.of(context).textTheme.bodyMedium!
                                                      .fontWeight,
                                              fontStyle:
                                                  Theme.of(context).textTheme.bodyMedium!
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                Theme.of(context).textTheme.bodyMedium!
                                                    .fontWeight,
                                            fontStyle:
                                                Theme.of(context).textTheme.bodyMedium!
                                                    .fontStyle,
                                          ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _model
                                            .newPasswordFieldTextController,
                                        focusNode:
                                            _model.newPasswordFieldFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.newPasswordFieldTextController',
                                          Duration(milliseconds: 0),
                                          () => safeSetState(() {}),
                                        ),
                                        obscureText:
                                            !_model.newPasswordFieldVisibility,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          alignLabelWithHint: false,
                                          hintStyle: Theme.of(context).textTheme.bodyMedium!
                                              .override(
                                                font: GoogleFonts.readexPro(
                                                  fontWeight:
                                                      Theme.of(context).textTheme.bodyMedium!
                                                          .fontWeight,
                                                  fontStyle:
                                                      Theme.of(context).textTheme.bodyMedium!
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF0F1113),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    Theme.of(context).textTheme.bodyMedium!
                                                        .fontWeight,
                                                fontStyle:
                                                    Theme.of(context).textTheme.bodyMedium!
                                                        .fontStyle,
                                              ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  Theme.of(context).colorScheme.surface,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  Theme.of(context).colorScheme.primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          focusedErrorBorder:
                                              UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () => safeSetState(
                                              () => _model
                                                      .newPasswordFieldVisibility =
                                                  !_model
                                                      .newPasswordFieldVisibility,
                                            ),
                                            focusNode:
                                                FocusNode(skipTraversal: true),
                                            child: Icon(
                                              _model.newPasswordFieldVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color:
                                                  Theme.of(context).textTheme.bodyMedium?.color,
                                              size: 20.0,
                                            ),
                                          ),
                                        ),
                                        style: Theme.of(context).textTheme.bodyMedium!
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    Theme.of(context).textTheme.bodyMedium!
                                                        .fontWeight,
                                                fontStyle:
                                                    Theme.of(context).textTheme.bodyMedium!
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF0F1113),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  Theme.of(context).textTheme.bodyMedium!
                                                      .fontWeight,
                                              fontStyle:
                                                  Theme.of(context).textTheme.bodyMedium!
                                                      .fontStyle,
                                            ),
                                        validator: _model
                                            .newPasswordFieldTextControllerValidator
                                            ?.asValidator(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '87sd7rdc' /* Confirm Password */,
                                      ),
                                      style: Theme.of(context).textTheme.bodyMedium!
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight:
                                                  Theme.of(context).textTheme.bodyMedium!
                                                      .fontWeight,
                                              fontStyle:
                                                  Theme.of(context).textTheme.bodyMedium!
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                Theme.of(context).textTheme.bodyMedium!
                                                    .fontWeight,
                                            fontStyle:
                                                Theme.of(context).textTheme.bodyMedium!
                                                    .fontStyle,
                                          ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _model
                                            .confirmNewPasswordFieldTextController,
                                        focusNode: _model
                                            .confirmNewPasswordFieldFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.confirmNewPasswordFieldTextController',
                                          Duration(milliseconds: 0),
                                          () => safeSetState(() {}),
                                        ),
                                        obscureText: !_model
                                            .confirmNewPasswordFieldVisibility,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          alignLabelWithHint: false,
                                          hintStyle: Theme.of(context).textTheme.bodyMedium!
                                              .override(
                                                font: GoogleFonts.readexPro(
                                                  fontWeight:
                                                      Theme.of(context).textTheme.bodyMedium!
                                                          .fontWeight,
                                                  fontStyle:
                                                      Theme.of(context).textTheme.bodyMedium!
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF0F1113),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    Theme.of(context).textTheme.bodyMedium!
                                                        .fontWeight,
                                                fontStyle:
                                                    Theme.of(context).textTheme.bodyMedium!
                                                        .fontStyle,
                                              ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  Theme.of(context).colorScheme.surface,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  Theme.of(context).colorScheme.primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          focusedErrorBorder:
                                              UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () => safeSetState(
                                              () => _model
                                                      .confirmNewPasswordFieldVisibility =
                                                  !_model
                                                      .confirmNewPasswordFieldVisibility,
                                            ),
                                            focusNode:
                                                FocusNode(skipTraversal: true),
                                            child: Icon(
                                              _model.confirmNewPasswordFieldVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color:
                                                  Theme.of(context).textTheme.bodyMedium?.color,
                                              size: 20.0,
                                            ),
                                          ),
                                        ),
                                        style: Theme.of(context).textTheme.bodyMedium!
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    Theme.of(context).textTheme.bodyMedium!
                                                        .fontWeight,
                                                fontStyle:
                                                    Theme.of(context).textTheme.bodyMedium!
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF0F1113),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  Theme.of(context).textTheme.bodyMedium!
                                                      .fontWeight,
                                              fontStyle:
                                                  Theme.of(context).textTheme.bodyMedium!
                                                      .fontStyle,
                                            ),
                                        validator: _model
                                            .confirmNewPasswordFieldTextControllerValidator
                                            ?.asValidator(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ].map((widget) => Padding(padding: EdgeInsets.only(bottom: 20.0), child: widget)).toList(),
                      ),
                    ),
                  ),
                  AppButton(
                    onPressed: (((_model.currentPasswordFieldTextController
                                                ?.text ==
                                            '') ||
                                    (_model.newPasswordFieldTextController
                                                ?.text ==
                                            '') ||
                                    (_model.confirmNewPasswordFieldTextController
                                                ?.text ==
                                            '') ||
                                    (_model.currentPasswordFieldTextController
                                            ?.text !=
                                        FFAppState().password)) ||
                                (_model.currentPasswordFieldTextController?.text ==
                                    _model
                                        .newPasswordFieldTextController?.text) ||
                                (_model.newPasswordFieldTextController?.text !=
                                    _model.confirmNewPasswordFieldTextController
                                        ?.text)
                            ? true
                            : false)
                        ? null
                        : () async {
                            if (_model
                                    .currentPasswordFieldTextController?.text ==
                                FFAppState().password) {
                              if (_model.currentPasswordFieldTextController
                                      ?.text !=
                                  _model.newPasswordFieldTextController?.text) {
                                if (_model
                                        .newPasswordFieldTextController?.text ==
                                    _model.confirmNewPasswordFieldTextController
                                        ?.text) {
                                  _model.apiResultChangePassword =
                                      await MainGroup.changePasswordCall.call(
                                    oldPassword: FFAppState().password,
                                    newPassword: _model
                                        .newPasswordFieldTextController?.text,
                                    userID: FFAppState().userID,
                                    token: FFAppState().token,
                                  );

                                  if ((_model
                                          .apiResultChangePassword?.succeeded ??
                                      true)) {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return WebViewAware(
                                          child: AlertDialog(
                                            title: Text('Message'),
                                            content: Text(
                                                'Password changed successfully.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                    AppState().password = _model
                                        .confirmNewPasswordFieldTextController
                                        .text;
                                    AppState().update(() {});

                                    Navigator.of(context).pushNamed(MyInfoWidget.routeName);
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return WebViewAware(
                                          child: AlertDialog(
                                            title: Text((_model
                                                    .apiResultChangePassword
                                                    ?.bodyText ??
                                                '')),
                                            content: Text(
                                                'Cannot change password !'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return WebViewAware(
                                        child: AlertDialog(
                                          title: Text('Error'),
                                          content: Text(
                                              'New password and Confirm password are not same!'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        title: Text('Error'),
                                        content: Text(
                                            'New password cannot same with current password !'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return WebViewAware(
                                    child: AlertDialog(
                                      title: Text('Error'),
                                      content:
                                          Text('Incorrect current password !'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }

                            safeSetState(() {});
                          },
                    text: FFLocalizations.of(context).getText(
                      'xh2o6ynb' /* Save */,
                    ),
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 50.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Theme.of(context).colorScheme.primary,
                      textStyle:
                          Theme.of(context).textTheme.titleSmall?.copyWith(
                                font: GoogleFonts.readexPro(
                                  fontWeight: Theme.of(context).textTheme.titleSmall!
                                      .fontWeight,
                                  fontStyle: Theme.of(context).textTheme.titleSmall!
                                      .fontStyle,
                                ),
                                color: Theme.of(context).colorScheme.primary,
                                letterSpacing: 0.0,
                                fontWeight: Theme.of(context).textTheme.titleSmall!
                                    .fontWeight,
                                fontStyle: Theme.of(context).textTheme.titleSmall!
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      disabledColor: Theme.of(context).colorScheme.secondaryText,
                      disabledTextColor:
                          Theme.of(context).colorScheme.secondaryBackground,
                    ),
                  ),
                ]
                    .addToStart(SizedBox(height: 30.0))
                    .addToEnd(SizedBox(height: 30.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

