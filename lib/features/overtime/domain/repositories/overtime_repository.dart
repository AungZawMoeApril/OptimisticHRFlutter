import '../entities/overtime_entities.dart';
import 'package:flutter/material.dart';

abstract class OvertimeRepository {
  Future<List<OvertimeRequest>> getOvertimeRequests(String employeeId);

  Future<OvertimeRequest> createOvertimeRequest({
    required String employeeId,
    required DateTime date,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required OvertimeType type,
    required String reason,
  });

  Future<OvertimeRequest> updateOvertimeRequest({
    required String requestId,
    required OvertimeStatus status,
    String? approverNote,
  });

  Future<OvertimeRequest> cancelOvertimeRequest(String requestId);

  Future<void> deleteOvertimeRequest(String requestId);

  Future<List<OvertimeRequest>> getPendingOvertimeRequests({
    required String employeeId,
    bool isApprover = false,
  });

  Future<OvertimeStats> getOvertimeStats({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  });
}