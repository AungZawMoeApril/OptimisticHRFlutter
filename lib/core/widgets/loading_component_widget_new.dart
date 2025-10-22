import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class LoadingComponentWidgetViewModel extends BaseViewModel {
  
}

class LoadingComponentWidget extends StatelessWidget {
  const LoadingComponentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoadingComponentWidgetViewModel>(
      viewModelBuilder: () => LoadingComponentWidgetViewModel(),
      builder: (context, model, child) {
        return return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(),
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  child: custom_widgets.LoadingIndicator(
                    width: 50.0,
                    height: 50.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );;
      },
    );
  }
}
