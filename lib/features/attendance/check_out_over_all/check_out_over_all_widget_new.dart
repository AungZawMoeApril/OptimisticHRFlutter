import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class CheckOutOverAllWidgetViewModel extends BaseViewModel {
  
}

class CheckOutOverAllWidget extends StatelessWidget {
  const CheckOutOverAllWidget({
    super.key,
    this.timeType,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<CheckOutOverAllWidgetViewModel>(
      viewModelBuilder: () => CheckOutOverAllWidgetViewModel(),
      builder: (context, model, child) {
        return context.watch<AppState>();

    return FutureBuilder<ApiCallResponse>(
      future: MainGroup.getDayViewOfSTACall.call(
        companyIDMain: AppState().companyID,
        employeeIDMain: AppState().employeeID,
        todayDateMain: functions.dateFormatToDay(),
        token: AppState().token,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primaryBackground,
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
