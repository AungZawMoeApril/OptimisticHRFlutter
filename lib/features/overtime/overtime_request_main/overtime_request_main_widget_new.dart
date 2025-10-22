import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class OvertimeRequestMainWidgetViewModel extends BaseViewModel {
  
}

class OvertimeRequestMainWidget extends StatelessWidget {
  const OvertimeRequestMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OvertimeRequestMainWidgetViewModel>(
      viewModelBuilder: () => OvertimeRequestMainWidgetViewModel(),
      builder: (context, model, child) {
        return context.watch<AppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryBackground,
        automaticallyImplyLeading: false,
        leading: AppIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: FaIcon(
            FontAwesomeIcons.angleLeft,
            color: Theme.of(context).colorScheme.primaryText,
            size: 30.0,
          ),
          onPressed: () async {
            Navigator.of(context).pop();;
      },
    );
  }
}
