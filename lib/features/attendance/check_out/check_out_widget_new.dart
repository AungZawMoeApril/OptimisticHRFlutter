import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class CheckOutWidgetViewModel extends BaseViewModel {
  
}

class CheckOutWidget extends StatelessWidget {
  const CheckOutWidget({
    super.key,
    this.timeType,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<CheckOutWidgetViewModel>(
      viewModelBuilder: () => CheckOutWidgetViewModel(),
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
