import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class AnnouncementCustomWidgetViewModel extends BaseViewModel {
  
}

class AnnouncementCustomWidget extends StatelessWidget {
  const AnnouncementCustomWidget({
    super.key,
    this.width,
    this.height,
    required this.weblink,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<AnnouncementCustomWidgetViewModel>(
      viewModelBuilder: () => AnnouncementCustomWidgetViewModel(),
      builder: (context, model, child) {
        return return Container(
      height: widget.height,
      width: widget.width,
      child: WebViewWidget(controller: _controller),
    );;
      },
    );
  }
}
