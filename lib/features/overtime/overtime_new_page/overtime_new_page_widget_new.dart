import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class OvertimeNewPageWidgetViewModel extends BaseViewModel {
  
}

class OvertimeNewPageWidget extends StatelessWidget {
  const OvertimeNewPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OvertimeNewPageWidgetViewModel>(
      viewModelBuilder: () => OvertimeNewPageWidgetViewModel(),
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
