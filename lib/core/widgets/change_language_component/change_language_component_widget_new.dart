import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class ChangeLanguageComponentWidgetViewModel extends BaseViewModel {
  
}

class ChangeLanguageComponentWidget extends StatelessWidget {
  const ChangeLanguageComponentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ChangeLanguageComponentWidgetViewModel>(
      viewModelBuilder: () => ChangeLanguageComponentWidgetViewModel(),
      builder: (context, model, child) {
        return return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: 300.0,
        height: 280.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  AppState().languageStatus = 'ประเทศไทย';
                  safeSetState(() {;
      },
    );
  }
}
