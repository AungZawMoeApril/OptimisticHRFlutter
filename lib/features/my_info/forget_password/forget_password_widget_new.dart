import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class ForgetPasswordWidgetViewModel extends BaseViewModel {
  
}

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    super.key,
    required this.emailAddress,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgetPasswordWidgetViewModel>(
      viewModelBuilder: () => ForgetPasswordWidgetViewModel(),
      builder: (context, model, child) {
        return return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryBackground,
          automaticallyImplyLeading: false,
          actions: [],
          flexibleSpace: FlexibleSpaceBar(
            title: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: AppIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          borderWidth: 1.0,
                          buttonSize: 50.0,
                          icon: FaIcon(
                            FontAwesomeIcons.angleLeft,
                            color: Theme.of(context).colorScheme.secondaryText,
                            size: 24.0,
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();

                            Navigator.of(context).pushNamed(LoginPageWidget.routeName);;
      },
    );
  }
}
