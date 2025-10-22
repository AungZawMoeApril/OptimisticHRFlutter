import '../core/widgets/app_widgets.dart';
import 'package:flutter/material.dart';;
import '../core/utils/app_utils.dart';;
import '../core/widgets/app_button.dart';;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'wrong_pin_code_component_model.dart';
export 'wrong_pin_code_component_model.dart';

class WrongPinCodeComponentWidget extends StatefulWidget {
  const WrongPinCodeComponentWidget({super.key});

  @override
  State<WrongPinCodeComponentWidget> createState() =>
      _WrongPinCodeComponentWidgetState();
}

class _WrongPinCodeComponentWidgetState
    extends State<WrongPinCodeComponentWidget> {
  late WrongPinCodeComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WrongPinCodeComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 170.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 15.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'oyxx3ryl' /* Alert */,
                ),
                style: Theme.of(context).textTheme.$1?.copyWith(
                      font: GoogleFonts.readexPro(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            context.textTheme.bodyMedium.fontStyle,
                      ),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          context.textTheme.bodyMedium.fontStyle,
                    ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 20.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'a6ovx8mi' /* Pincode and confirm pincode do... */,
                ),
                style: Theme.of(context).textTheme.$1?.copyWith(
                      font: GoogleFonts.readexPro(
                        fontWeight:
                            context.textTheme.bodyMedium.fontWeight,
                        fontStyle:
                            context.textTheme.bodyMedium.fontStyle,
                      ),
                      color: Theme.of(context).colorScheme.secondaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          context.textTheme.bodyMedium.fontWeight,
                      fontStyle:
                          context.textTheme.bodyMedium.fontStyle,
                    ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                text: FFLocalizations.of(context).getText(
                  'mfkr6hzz' /* OK */,
                ),
                options: FFButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Theme.of(context).colorScheme.secondaryBackground,
                  textStyle: Theme.of(context).textTheme.$1?.copyWith(
                        font: GoogleFonts.readexPro(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              Theme.of(context).textTheme.titleSmall.fontStyle,
                        ),
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: 0.0,
                        fontWeight:
                            Theme.of(context).textTheme.titleSmall.fontWeight,
                        fontStyle:
                            Theme.of(context).textTheme.titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
