import 'package:flutter/material.dart';

class LeaveRequestWidget extends StatefulWidget {
  const LeaveRequestWidget({Key? key}) : super(key: key);

  static const String routeName = 'LeaveRequest';

  @override
  State<LeaveRequestWidget> createState() => _LeaveRequestWidgetState();
}

class _LeaveRequestWidgetState extends State<LeaveRequestWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Request'),
      ),
      body: const Center(
        child: Text(
          'Leave Request Form\n(Implementation pending)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
