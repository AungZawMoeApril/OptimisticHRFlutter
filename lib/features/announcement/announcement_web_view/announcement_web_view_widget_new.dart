import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class AnnouncementWebViewWidgetViewModel extends BaseViewModel {
  
}

class AnnouncementWebViewWidget extends StatelessWidget {
  const AnnouncementWebViewWidget({
    super.key,
    required this.announcementMobileViewURL,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<AnnouncementWebViewWidgetViewModel>(
      viewModelBuilder: () => AnnouncementWebViewWidgetViewModel(),
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
