import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class AnnouncementWidgetViewModel extends BaseViewModel {
  
}

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget({
    super.key,
    required this.announcementObject,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<AnnouncementWidgetViewModel>(
      viewModelBuilder: () => AnnouncementWidgetViewModel(),
      builder: (context, model, child) {
        return return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();;
      },
    );
  }
}
