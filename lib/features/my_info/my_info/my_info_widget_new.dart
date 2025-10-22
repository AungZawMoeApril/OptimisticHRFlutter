import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class MyInfoWidgetViewModel extends BaseViewModel {
  
}

class MyInfoWidget extends StatelessWidget {
  const MyInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MyInfoWidgetViewModel>(
      viewModelBuilder: () => MyInfoWidgetViewModel(),
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
