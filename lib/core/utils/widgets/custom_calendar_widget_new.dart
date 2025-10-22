import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class CustomCalendarWidgetViewModel extends BaseViewModel {
  bool _isLoading = true;
}

class CustomCalendarWidget extends StatelessWidget {
  const CustomCalendarWidget({
    super.key,
    this.width,
    this.height,
    this.calendarList,
    this.onSelectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<CustomCalendarWidgetViewModel>(
      viewModelBuilder: () => CustomCalendarWidgetViewModel(),
      builder: (context, model, child) {
        return if (_isLoading) {
      return const Center(child: CircularProgressIndicator());;
      },
    );
  }
}
