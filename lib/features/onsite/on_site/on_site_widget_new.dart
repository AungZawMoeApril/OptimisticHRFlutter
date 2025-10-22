import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class OnSiteWidgetViewModel extends BaseViewModel {
  
}

class OnSiteWidget extends StatelessWidget {
  const OnSiteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OnSiteWidgetViewModel>(
      viewModelBuilder: () => OnSiteWidgetViewModel(),
      builder: (context, model, child) {
        return context.watch<AppState>();

    return FutureBuilder<ApiCallResponse>(
      future: MainGroup.getTimeAttendanceListMobileCall.call(
        employeeID: AppState().employeeID,
        companyID: AppState().companyID,
        token: AppState().token,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFFF6F6F6),
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
