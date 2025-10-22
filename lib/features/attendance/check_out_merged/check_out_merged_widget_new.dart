import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class CheckOutMergedWidgetViewModel extends BaseViewModel {
  
}

class CheckOutMergedWidget extends StatelessWidget {
  const CheckOutMergedWidget({
    super.key,
    this.timeType,
    required this.checkInData,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<CheckOutMergedWidgetViewModel>(
      viewModelBuilder: () => CheckOutMergedWidgetViewModel(),
      builder: (context, model, child) {
        return context.watch<AppState>();

    return FutureBuilder<ApiCallResponse>(
      future: MainGroup.getDayViewOfSTACall.call(
        token: AppState().token,
        companyID: AppState().companyID,
        employeeID: AppState().employeeID,
        todayDate: functions.dateFormatToDay(),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          );;
      },
    );
  }
}
