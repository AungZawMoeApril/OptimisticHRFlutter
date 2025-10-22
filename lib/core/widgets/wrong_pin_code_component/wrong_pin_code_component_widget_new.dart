import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class WrongPinCodeComponentWidgetViewModel extends BaseViewModel {
  
}

class WrongPinCodeComponentWidget extends StatelessWidget {
  const WrongPinCodeComponentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<WrongPinCodeComponentWidgetViewModel>(
      viewModelBuilder: () => WrongPinCodeComponentWidgetViewModel(),
      builder: (context, model, child) {
        return return Container(
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
                  Navigator.pop(context);;
      },
    );
  }
}
