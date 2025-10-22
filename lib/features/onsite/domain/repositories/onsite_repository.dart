import 'package:flutter/material.dart';
import '../entities/onsite_entities.dart';

abstract class OnsiteRepository {
  Future<List<OnsiteRequest>> getOnsiteRequests(String employeeId);

  Future<OnsiteRequest> createOnsiteRequest({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required OnsiteType type,
    required String location,
    required String reason,
  });

  Future<OnsiteRequest> updateOnsiteRequest({
    required String requestId,
    required OnsiteStatus status,
    String? approverNote,
  });

  Future<OnsiteRequest> cancelOnsiteRequest(String requestId);

  Future<void> deleteOnsiteRequest(String requestId);

  Future<List<OnsiteRequest>> getPendingOnsiteRequests({
    required String employeeId,
    bool isApprover = false,
  });

  Future<OnsiteStats> getOnsiteStats({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  });
}