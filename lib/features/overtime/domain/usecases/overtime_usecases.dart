import 'package:flutter/material.dart';
import '../entities/overtime_entities.dart';
import '../repositories/overtime_repository.dart';

class GetOvertimeRequests {
  final OvertimeRepository repository;

  GetOvertimeRequests(this.repository);

  Future<List<OvertimeRequest>> call(String employeeId) async {
    return await repository.getOvertimeRequests(employeeId);
  }
}

class CreateOvertimeRequest {
  final OvertimeRepository repository;

  CreateOvertimeRequest(this.repository);

  Future<OvertimeRequest> call({
    required String employeeId,
    required DateTime date,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required OvertimeType type,
    required String reason,
  }) async {
    return await repository.createOvertimeRequest(
      employeeId: employeeId,
      date: date,
      startTime: startTime,
      endTime: endTime,
      type: type,
      reason: reason,
    );
  }
}

class UpdateOvertimeRequest {
  final OvertimeRepository repository;

  UpdateOvertimeRequest(this.repository);

  Future<OvertimeRequest> call({
    required String requestId,
    required OvertimeStatus status,
    String? approverNote,
  }) async {
    return await repository.updateOvertimeRequest(
      requestId: requestId,
      status: status,
      approverNote: approverNote,
    );
  }
}

class DeleteOvertimeRequest {
  final OvertimeRepository repository;

  DeleteOvertimeRequest(this.repository);

  Future<void> call(String requestId) async {
    await repository.deleteOvertimeRequest(requestId);
  }
}

class GetOvertimeStats {
  final OvertimeRepository repository;

  GetOvertimeStats(this.repository);

  Future<OvertimeStats> call({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return await repository.getOvertimeStats(
      employeeId: employeeId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

class GetPendingOvertimeRequests {
  final OvertimeRepository repository;

  GetPendingOvertimeRequests(this.repository);

  Future<List<OvertimeRequest>> call({
    required String employeeId,
    bool isApprover = false,
  }) async {
    return await repository.getPendingOvertimeRequests(
      employeeId: employeeId,
      isApprover: isApprover,
    );
  }
}

class CancelOvertimeRequest {
  final OvertimeRepository repository;

  CancelOvertimeRequest(this.repository);

  Future<OvertimeRequest> call(String requestId) async {
    return await repository.cancelOvertimeRequest(requestId);
  }
}