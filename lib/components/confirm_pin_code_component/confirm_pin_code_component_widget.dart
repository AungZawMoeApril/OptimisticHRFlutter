import 'package:flutter/material.dart';
import 'confirm_pin_code_component_model.dart';

export 'confirm_pin_code_component_model.dart';

/// Stub widget for ConfirmPinCodeComponent
class ConfirmPinCodeComponentWidget extends StatefulWidget {
  const ConfirmPinCodeComponentWidget({super.key});

  @override
  State<ConfirmPinCodeComponentWidget> createState() => _ConfirmPinCodeComponentWidgetState();
}

class _ConfirmPinCodeComponentWidgetState extends State<ConfirmPinCodeComponentWidget> {
  late ConfirmPinCodeComponentModel _model;

  @override
  void initState() {
    super.initState();
    _model = ConfirmPinCodeComponentModel();
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
