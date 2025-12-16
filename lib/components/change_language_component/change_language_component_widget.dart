import 'package:flutter/material.dart';
import 'change_language_component_model.dart';

export 'change_language_component_model.dart';

/// Stub widget for ChangeLanguageComponent
class ChangeLanguageComponentWidget extends StatefulWidget {
  const ChangeLanguageComponentWidget({super.key});

  @override
  State<ChangeLanguageComponentWidget> createState() => _ChangeLanguageComponentWidgetState();
}

class _ChangeLanguageComponentWidgetState extends State<ChangeLanguageComponentWidget> {
  late ChangeLanguageComponentModel _model;

  @override
  void initState() {
    super.initState();
    _model = ChangeLanguageComponentModel();
    _model.initState(context);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
