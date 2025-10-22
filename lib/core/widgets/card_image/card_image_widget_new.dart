import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class CardImageWidgetViewModel extends BaseViewModel {
  
}

class CardImageWidget extends StatelessWidget {
  const CardImageWidget({
    super.key,
    required this.imageByte,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<CardImageWidgetViewModel>(
      viewModelBuilder: () => CardImageWidgetViewModel(),
      builder: (context, model, child) {
        return return Container(
      width: double.infinity,
      height: 400.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryBackground,
      ),
      child: Stack(
        children: [
          Image.network(
            widget.imageByte!,
            width: double.infinity,
            height: 400.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
            child: Container(
              decoration: BoxDecoration(),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(1.02, -1.05),
            child: AppIconButton(
              buttonSize: 48.0,
              icon: Icon(
                Icons.close_rounded,
                color: Theme.of(context).colorScheme.primaryText,
                size: 24.0,
              ),
              onPressed: () async {
                AppState().showPopUpImage = false;
                _model.updatePage(() {;
      },
    );
  }
}
