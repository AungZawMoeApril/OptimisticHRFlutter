import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class MyApprovalHistoryCancelWidgetViewModel extends BaseViewModel {
  
}

class MyApprovalHistoryCancelWidget extends StatelessWidget {
  const MyApprovalHistoryCancelWidget({
    super.key,
    required this.myApprovalHistoryIndex,
    required this.workflowName,
    required this.wFID,
    required this.reason,
    required this.status,
    required this.requeststatus,
    required this.userID,
    required this.approverOrder,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<MyApprovalHistoryCancelWidgetViewModel>(
      viewModelBuilder: () => MyApprovalHistoryCancelWidgetViewModel(),
      builder: (context, model, child) {
        return context.watch<AppState>();

    return Container(
      width: double.infinity,
      height: 150.0,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
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
