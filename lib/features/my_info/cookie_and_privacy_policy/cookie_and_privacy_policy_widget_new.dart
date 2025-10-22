import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class CookieAndPrivacyPolicyWidgetViewModel extends BaseViewModel {
  
}

class CookieAndPrivacyPolicyWidget extends StatelessWidget {
  const CookieAndPrivacyPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CookieAndPrivacyPolicyWidgetViewModel>(
      viewModelBuilder: () => CookieAndPrivacyPolicyWidgetViewModel(),
      builder: (context, model, child) {
        return return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();;
      },
    );
  }
}
