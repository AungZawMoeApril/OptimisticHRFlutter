import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class MyApprovalAttachmentModelWidgetViewModel extends BaseViewModel {
  
}

class MyApprovalAttachmentModelWidget extends StatelessWidget {
  const MyApprovalAttachmentModelWidget({
    super.key,
    required this.attachment,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<MyApprovalAttachmentModelWidgetViewModel>(
      viewModelBuilder: () => MyApprovalAttachmentModelWidgetViewModel(),
      builder: (context, model, child) {
        return return Container(
      width: 270.0,
      height: 300.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
            child: Text(
              FFLocalizations.of(context).getText(
                '6tsi0rnf' /* Attachments */,
              ),
              style: Theme.of(context).textTheme.$1?.copyWith(
                    font: GoogleFonts.readexPro(
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          context.textTheme.bodyMedium.fontStyle,
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        context.textTheme.bodyMedium.fontStyle,
                  ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 15.0, 10.0),
              child: Container(
                width: double.infinity,
                height: 220.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryBackground,
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (alertDialogContext) {
                        return WebViewAware(
                          child: AlertDialog(
                            title: Text('Alert'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext),
                                child: Text('Ok'),
                              ),
                            ],
                          ),
                        );;
      },
    );
  }
}
