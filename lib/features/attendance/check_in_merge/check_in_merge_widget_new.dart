import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class CheckInMergeWidgetViewModel extends BaseViewModel {
  
}

class CheckInMergeWidget extends StatelessWidget {
  const CheckInMergeWidget({
    super.key,
    required this.timeType,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<CheckInMergeWidgetViewModel>(
      viewModelBuilder: () => CheckInMergeWidgetViewModel(),
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
