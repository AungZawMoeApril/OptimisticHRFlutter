import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class LeaveRequestWidgetViewModel extends BaseViewModel {
  
}

class LeaveRequestWidget extends StatelessWidget {
  const LeaveRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LeaveRequestWidgetViewModel>(
      viewModelBuilder: () => LeaveRequestWidgetViewModel(),
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
