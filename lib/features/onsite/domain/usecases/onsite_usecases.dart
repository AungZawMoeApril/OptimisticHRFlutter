import 'package:flutter/material.dart';
import '../entities/onsite_entities.dart';
import '../repositories/onsite_repository.dart';

class GetOnsiteRequests {
  final OnsiteRepository repository;

  GetOnsiteRequests(this.repository);

  Future<List<OnsiteRequest>> call(String employeeId) async {
    return await repository.getOnsiteRequests(employeeId);
  }
}

class CreateOnsiteRequest {
  final OnsiteRepository repository;

  CreateOnsiteRequest(this.repository);

  Future<OnsiteRequest> call({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required OnsiteType type,
    required String location,
    required String reason,
  }) async {
    return await repository.createOnsiteRequest(
      employeeId: employeeId,
      startDate: startDate,
      endDate: endDate,
      startTime: startTime,
      endTime: endTime,
      type: type,
      location: location,
      reason: reason,
    );
  }
}

class UpdateOnsiteRequest {
  final OnsiteRepository repository;

  UpdateOnsiteRequest(this.repository);

  Future<OnsiteRequest> call({
    required String requestId,
    required OnsiteStatus status,
    String? approverNote,
  }) async {
    return await repository.updateOnsiteRequest(
      requestId: requestId,
      status: status,
      approverNote: approverNote,
    );
  }
}

class DeleteOnsiteRequest {
  final OnsiteRepository repository;

  DeleteOnsiteRequest(this.repository);

  Future<void> call(String requestId) async {
    await repository.deleteOnsiteRequest(requestId);
  }
}

class GetOnsiteStats {
  final OnsiteRepository repository;

  GetOnsiteStats(this.repository);

  Future<OnsiteStats> call({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return await repository.getOnsiteStats(
      employeeId: employeeId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

class GetPendingOnsiteRequests {
  final OnsiteRepository repository;

  GetPendingOnsiteRequests(this.repository);

  Future<List<OnsiteRequest>> call({
    required String employeeId,
    bool isApprover = false,
  }) async {
    return await repository.getPendingOnsiteRequests(
      employeeId: employeeId,
      isApprover: isApprover,
    );
  }
}

class CancelOnsiteRequest {
  final OnsiteRepository repository;

  CancelOnsiteRequest(this.repository);

  Future<OnsiteRequest> call(String requestId) async {
    return await repository.cancelOnsiteRequest(requestId);
  }
}