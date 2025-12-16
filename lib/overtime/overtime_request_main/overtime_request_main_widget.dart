import 'package:flutter/material.dart';

import 'overtime_request_main_model.dart';
export 'overtime_request_main_model.dart';

// Simplified stub - needs full implementation
class OvertimeRequestMainWidget extends StatefulWidget {
  const OvertimeRequestMainWidget({super.key});

  static String routeName = 'OvertimeRequestMain';
  static String routePath = '/overtimeRequestMain';

  @override
  State<OvertimeRequestMainWidget> createState() => _OvertimeRequestMainWidgetState();
}

class _OvertimeRequestMainWidgetState extends State<OvertimeRequestMainWidget> {
  late OvertimeRequestMainModel _model;

  @override
  void initState() {
    super.initState();
    _model = OvertimeRequestMainModel();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overtime Request'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Center(
        child: Text(
          'Overtime Request Form\n(Implementation pending)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
