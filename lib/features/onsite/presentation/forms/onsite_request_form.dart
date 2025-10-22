import 'package:flutter/material.dart';
import '../../domain/entities/onsite_entities.dart';

class OnsiteRequestForm {
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  OnsiteType? type;
  String location = '';
  String reason = '';
  String? approverNote;

  bool get isValid {
    return startDate != null &&
        endDate != null &&
        startTime != null &&
        endTime != null &&
        type != null &&
        location.trim().isNotEmpty &&
        reason.trim().isNotEmpty;
  }

  Map<String, String?> validate() {
    final errors = <String, String?>{};

    if (startDate == null) {
      errors['startDate'] = 'Please select start date';
    } else if (startDate!.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      errors['startDate'] = 'Start date cannot be in the past';
    }

    if (endDate == null) {
      errors['endDate'] = 'Please select end date';
    } else if (startDate != null && endDate!.isBefore(startDate!)) {
      errors['endDate'] = 'End date must be after start date';
    }

    if (startTime == null) {
      errors['startTime'] = 'Please select start time';
    }

    if (endTime == null) {
      errors['endTime'] = 'Please select end time';
    }

    if (startTime != null && endTime != null) {
      if (startDate != null &&
          endDate != null &&
          startDate!.year == endDate!.year &&
          startDate!.month == endDate!.month &&
          startDate!.day == endDate!.day) {
        final start = startTime!.hour + startTime!.minute / 60;
        final end = endTime!.hour + endTime!.minute / 60;
        if (end <= start) {
          errors['endTime'] = 'End time must be after start time';
        }
      }
    }

    if (type == null) {
      errors['type'] = 'Please select onsite type';
    }

    if (location.trim().isEmpty) {
      errors['location'] = 'Please enter location';
    }

    if (reason.trim().isEmpty) {
      errors['reason'] = 'Please provide a reason';
    } else if (reason.trim().length < 10) {
      errors['reason'] = 'Reason must be at least 10 characters';
    }

    return errors;
  }

  void clear() {
    startDate = null;
    endDate = null;
    startTime = null;
    endTime = null;
    type = null;
    location = '';
    reason = '';
    approverNote = null;
  }
}