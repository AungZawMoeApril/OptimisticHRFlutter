import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class TimeAttendanceWidgetViewModel extends BaseViewModel {
  
}

class TimeAttendanceWidget extends StatelessWidget {
  const TimeAttendanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<TimeAttendanceWidgetViewModel>(
      viewModelBuilder: () => TimeAttendanceWidgetViewModel(),
      builder: (context, model, child) {
        return context.watch<AppState>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF6F6F6),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: false,
          leading: AppIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.date_range,
              color: Color(0xFFF9B052),
              size: 30.0,
            ),
            onPressed: () {
              print('IconButton pressed ...');;
      },
    );
  }
}
