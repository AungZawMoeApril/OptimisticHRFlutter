import 'package:flutter/material.dart';
import '../../domain/entities/overtime_entities.dart';

class OvertimeTypeChip extends StatelessWidget {
  final OvertimeType type;

  const OvertimeTypeChip({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    switch (type) {
      case OvertimeType.weekday:
        color = Colors.blue;
        icon = Icons.watch_later_outlined;
        break;
      case OvertimeType.holiday:
        color = Colors.purple;
        icon = Icons.calendar_today_outlined;
        break;
      case OvertimeType.weekend:
        color = Colors.teal;
        icon = Icons.weekend_outlined;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            type.toString().split('.').last.toUpperCase(),
            style: TextStyle(color: color, fontSize: 12),
          ),
        ],
      ),
    );
  }
}