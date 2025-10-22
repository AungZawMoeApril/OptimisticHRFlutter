import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class MyApprovalPendingRejectWidgetViewModel extends BaseViewModel {
  
}

class MyApprovalPendingRejectWidget extends StatelessWidget {
  const MyApprovalPendingRejectWidget({
    super.key,
    required this.workFlowName,
    required this.workFlowID,
    required this.approverPrder,
    required this.taskType,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<MyApprovalPendingRejectWidgetViewModel>(
      viewModelBuilder: () => MyApprovalPendingRejectWidgetViewModel(),
      builder: (context, model, child) {
        return context.watch<AppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: 330.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 7.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                -2.0,
              ),
            )
          ],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      '2ov5tgs7' /* Please fill in the reason for ... */,
                    ),
                    style: Theme.of(context).textTheme.$1?.copyWith(
                          font: GoogleFonts.outfit(
                            fontWeight: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .fontStyle,
                          ),
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .fontStyle,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                child: Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _model.textController,
                    focusNode: _model.textFieldFocusNode,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.textController',
                      Duration(milliseconds: 0),
                      () => safeSetState(() {;
      },
    );
  }
}
