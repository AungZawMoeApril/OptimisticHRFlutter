import 'package:flutter/material.dart';
import '../../domain/entities/overtime_entities.dart';

class OvertimeRequestForm {
  DateTime? date;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  OvertimeType? type;
  String reason = '';
  String? approverNote;

  bool get isValid {
    return date != null &&
        startTime != null &&
        endTime != null &&
        type != null &&
        reason.trim().isNotEmpty;
  }

  Map<String, String?> validate() {
    final errors = <String, String?>{};

    if (date == null) {
      errors['date'] = 'Please select a date';
    } else if (date!.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      errors['date'] = 'Date cannot be in the past';
    }

    if (startTime == null) {
      errors['startTime'] = 'Please select a start time';
    }

    if (endTime == null) {
      errors['endTime'] = 'Please select an end time';
    }

    if (startTime != null && endTime != null) {
      final start = startTime!.hour + startTime!.minute / 60;
      final end = endTime!.hour + endTime!.minute / 60;
      if (end <= start) {
        errors['endTime'] = 'End time must be after start time';
      }
    }

    if (type == null) {
      errors['type'] = 'Please select overtime type';
    }

    if (reason.trim().isEmpty) {
      errors['reason'] = 'Please provide a reason';
    } else if (reason.trim().length < 10) {
      errors['reason'] = 'Reason must be at least 10 characters';
    }

    return errors;
  }

  double calculateHours() {
    if (startTime == null || endTime == null) return 0;

    final start = startTime!.hour + startTime!.minute / 60;
    final end = endTime!.hour + endTime!.minute / 60;
    return end > start ? end - start : (24 - start) + end;
  }

  void clear() {
    date = null;
    startTime = null;
    endTime = null;
    type = null;
    reason = '';
    approverNote = null;
  }
}