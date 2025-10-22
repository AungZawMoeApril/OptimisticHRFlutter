import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class OvertimeAttachmentModelWidgetViewModel extends BaseViewModel {
  
}

class OvertimeAttachmentModelWidget extends StatelessWidget {
  const OvertimeAttachmentModelWidget({
    super.key,
    required this.attachmentListJson,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<OvertimeAttachmentModelWidgetViewModel>(
      viewModelBuilder: () => OvertimeAttachmentModelWidgetViewModel(),
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
                'yyuift89' /* Attachments */,
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
                child: Builder(
                  builder: (context) {
                    final attachment = widget.attachmentListJson!.toList();

                    return InkWell(
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
                                content: Text(widget
                                    .attachmentListJson!.firstOrNull!
                                    .toString()),
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
