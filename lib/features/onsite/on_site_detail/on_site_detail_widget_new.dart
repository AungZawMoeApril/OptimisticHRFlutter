import 'package:flutter/material.dart';
import 'package:hr_app/core/presentation/base/base_view.dart';
import 'package:provider/provider.dart';

class OnSiteDetailWidgetViewModel extends BaseViewModel {
  
}

class OnSiteDetailWidget extends StatelessWidget {
  const OnSiteDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OnSiteDetailWidgetViewModel>(
      viewModelBuilder: () => OnSiteDetailWidgetViewModel(),
      builder: (context, model, child) {
        return return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              FontAwesomeIcons.angleLeft,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            FFLocalizations.of(context).getText('h0glojcf'),
            style: Theme.of(context).textTheme.titleLarge.copyWith(
              fontSize: 22.0,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: AppButton(
                  text: FFLocalizations.of(context).getText('n8lrwjmq'),
                  onPressed: () {
                    print('Button pressed ...');;
      },
    );
  }
}
