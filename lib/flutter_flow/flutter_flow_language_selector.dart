import 'package:flutter/material.dart';

/// FlutterFlow language selector stub
class FlutterFlowLanguageSelector extends StatelessWidget {
  const FlutterFlowLanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: 'en',
      items: const [
        DropdownMenuItem(value: 'en', child: Text('English')),
        DropdownMenuItem(value: 'th', child: Text('ไทย')),
      ],
      onChanged: (value) {
        // TODO: Implement language change
      },
    );
  }
}
