import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class ConfirmPinCodeComponentWidgetViewModel extends BaseViewModel {
  
}

class ConfirmPinCodeComponentWidget extends StatelessWidget {
  const ConfirmPinCodeComponentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ConfirmPinCodeComponentWidgetViewModel>(
      viewModelBuilder: () => ConfirmPinCodeComponentWidgetViewModel(),
      builder: (context, model, child) {
        return return Container(
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
                    Navigator.of(context).pushNamed(HomeWidget.routeName);;
      },
    );
  }
}
