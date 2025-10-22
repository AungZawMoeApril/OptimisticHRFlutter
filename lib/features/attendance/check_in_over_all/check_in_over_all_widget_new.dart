import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class CheckInOverAllWidgetViewModel extends BaseViewModel {
  
}

class CheckInOverAllWidget extends StatelessWidget {
  const CheckInOverAllWidget({
    super.key,
    required this.timeType,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<CheckInOverAllWidgetViewModel>(
      viewModelBuilder: () => CheckInOverAllWidgetViewModel(),
      builder: (context, model, child) {
        return context.watch<AppState>();

    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();;
      },
    );
  }
}
