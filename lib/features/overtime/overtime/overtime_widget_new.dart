import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class OvertimeWidgetViewModel extends BaseViewModel {
  
}

class OvertimeWidget extends StatelessWidget {
  const OvertimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OvertimeWidgetViewModel>(
      viewModelBuilder: () => OvertimeWidgetViewModel(),
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
