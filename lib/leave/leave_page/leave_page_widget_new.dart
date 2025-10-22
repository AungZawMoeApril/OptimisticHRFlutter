import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class LeavePageWidgetViewModel extends BaseViewModel {
  
}

class LeavePageWidget extends StatelessWidget {
  const LeavePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LeavePageWidgetViewModel>(
      viewModelBuilder: () => LeavePageWidgetViewModel(),
      builder: (context, model, child) {
        return context.watch<AppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();;
      },
    );
  }
}
