import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A base view model class to replace FlutterFlowModel
abstract class BaseViewModel extends ChangeNotifier {
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

/// A base widget class to replace FlutterFlow widgets
abstract class BaseView<T extends BaseViewModel> extends StatelessWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final T Function() viewModelBuilder;
  final void Function(T)? onModelReady;

  const BaseView({
    required this.builder,
    required this.viewModelBuilder,
    this.onModelReady,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) {
        final model = viewModelBuilder();
        onModelReady?.call(model);
        return model;
      },
      child: Consumer<T>(builder: builder),
    );
  }
}