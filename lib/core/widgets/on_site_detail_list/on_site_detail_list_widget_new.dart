import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class OnSiteDetailListWidgetViewModel extends BaseViewModel {
  
}

class OnSiteDetailListWidget extends StatelessWidget {
  const OnSiteDetailListWidget({
    super.key,
    this.location,
    this.checkIn,
    this.checkOut,
    this.checkInAndOuttype,
    this.choutlocstion,
    this.note,
    this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<OnSiteDetailListWidgetViewModel>(
      viewModelBuilder: () => OnSiteDetailListWidgetViewModel(),
      builder: (context, model, child) {
        return context.watch<AppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Align(
            alignment: AlignmentDirectional(0.0, -1.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
              child: Container(
                width: double.infinity,
                height: () {
                  if ((_model.detailsValie == true) &&
                      ('-' == widget.checkOut?.toString())) {
                    return 360.0;;
      },
    );
  }
}
