import '../core/widgets/app_widgets.dart';
import 'package:flutter/material.dart';;
import '../core/utils/app_utils.dart';;
import '../core/widgets/app_button.dart';;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'confirm_pin_code_component_model.dart';
export 'confirm_pin_code_component_model.dart';

class ConfirmPinCodeComponentWidget extends StatefulWidget {
  const ConfirmPinCodeComponentWidget({super.key});

  @override
  State<ConfirmPinCodeComponentWidget> createState() =>
      _ConfirmPinCodeComponentWidgetState();
}

class _ConfirmPinCodeComponentWidgetState
    extends State<ConfirmPinCodeComponentWidget> {
  late ConfirmPinCodeComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfirmPinCodeComponentModel());

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
      height: 180.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0),
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 300.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
          ),
          Text(
            FFLocalizations.of(context).getText(
              'yrotnb4l' /* Set a PIN code */,
            ),
            style: Theme.of(context).textTheme.$1?.copyWith(
                  font: GoogleFonts.readexPro(
                    fontWeight: FontWeight.w600,
                    fontStyle: Theme.of(context).textTheme.bodyLarge.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle: Theme.of(context).textTheme.bodyLarge.fontStyle,
                ),
          ),
          Text(
            FFLocalizations.of(context).getText(
              'qc0p32j2' /* A new PIN code has been set. */,
            ),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.$1?.copyWith(
                  font: GoogleFonts.readexPro(
                    fontWeight:
                        context.textTheme.bodyMedium.fontWeight,
                    fontStyle:
                        context.textTheme.bodyMedium.fontStyle,
                  ),
                  color: Theme.of(context).colorScheme.secondaryText,
                  letterSpacing: 0.0,
                  fontWeight:
                      context.textTheme.bodyMedium.fontWeight,
                  fontStyle: context.textTheme.bodyMedium.fontStyle,
                ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: AppButton(
                  onPressed: () async {
                    Navigator.of(context).pushNamed(HomeWidget.routeName);
                  },
                  text: FFLocalizations.of(context).getText(
                    'i9vhkc8t' /* AGREE */,
                  ),
                  style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(50.0),
      padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
      backgroundColor: null,
      textStyle: null,
      elevation: null,
      side: const BorderSide(
        color: Colors.transparent,
        width: 1.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: null,
      ),
    ),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Theme.of(context).colorScheme.secondaryBackground,
                    textStyle: Theme.of(context).textTheme.$1?.copyWith(
                          font: GoogleFonts.readexPro(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: Theme.of(context).colorScheme.primary,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              Theme.of(context).textTheme.titleSmall.fontStyle,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondaryText,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
