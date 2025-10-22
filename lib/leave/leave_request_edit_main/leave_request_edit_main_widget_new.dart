import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class LeaveRequestEditMainWidgetViewModel extends BaseViewModel {
  final _formKey = GlobalKey<FormState>();
}

class LeaveRequestEditMainWidget extends StatelessWidget {
  const LeaveRequestEditMainWidget({
    super.key,
    required this.editLeaveRequest,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<LeaveRequestEditMainWidgetViewModel>(
      viewModelBuilder: () => LeaveRequestEditMainWidgetViewModel(),
      builder: (context, model, child) {
        return final leaveState = context.watch<LeaveEditState>();
    final appState = context.watch<AppState>();
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 2,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
            onPressed: () async {
              Navigator.of(context).pushNamed(LeavePageWidget.routeName);;
      },
    );
  }
}
