import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class AnnouncementWebViewCopyWidgetViewModel extends BaseViewModel {
  
}

class AnnouncementWebViewCopyWidget extends StatelessWidget {
  const AnnouncementWebViewCopyWidget({
    super.key,
    required this.announcementMobileViewURL,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<AnnouncementWebViewCopyWidgetViewModel>(
      viewModelBuilder: () => AnnouncementWebViewCopyWidgetViewModel(),
      builder: (context, model, child) {
        return return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();;
      },
    );
  }
}
