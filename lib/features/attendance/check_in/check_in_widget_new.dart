import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class CheckInWidgetViewModel extends BaseViewModel {
  
}

class CheckInWidget extends StatelessWidget {
  const CheckInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CheckInWidgetViewModel>(
      viewModelBuilder: () => CheckInWidgetViewModel(),
      builder: (context, model, child) {
        return context.watch<AppState>();
    if (currentUserLocationValue == null) {
      return Container(
        color: Theme.of(context).colorScheme.primaryBackground,
        child: Center(
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
