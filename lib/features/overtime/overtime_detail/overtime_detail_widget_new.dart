import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class OvertimeDetailWidgetViewModel extends BaseViewModel {
  
}

class OvertimeDetailWidget extends StatelessWidget {
  const OvertimeDetailWidget({
    super.key,
    required this.overtimedetails,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<OvertimeDetailWidgetViewModel>(
      viewModelBuilder: () => OvertimeDetailWidgetViewModel(),
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
