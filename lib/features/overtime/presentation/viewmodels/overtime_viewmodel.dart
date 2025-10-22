import 'package:flutter/material.dart';
import 'package:h_r_optimistic_mobile/core/presentation/base/base_view.dart';
import '../entities/overtime_request.dart';
import '../repositories/overtime_repository.dart';

class OvertimeViewModel extends BaseViewModel {
  final OvertimeRepository _repository;

  OvertimeViewModel(this._repository);

  List<OvertimeRequest> _overtimeRequests = [];
  List<OvertimeRequest> get overtimeRequests => _overtimeRequests;

  DateTime _selectedStartDate = DateTime.now();
  DateTime get selectedStartDate => _selectedStartDate;

  DateTime _selectedEndDate = DateTime.now().add(const Duration(days: 30));
  DateTime get selectedEndDate => _selectedEndDate;

  String? _selectedStatus;
  String? get selectedStatus => _selectedStatus;

  Future<void> loadOvertimeRequests(String userId) async {
    setBusy(true);
    final result = await _repository.getOvertimeRequests(
      userId: userId,
      startDate: _selectedStartDate,
      endDate: _selectedEndDate,
      status: _selectedStatus,
    );

    result.fold(
      (failure) => setError(failure.message),
      (requests) {
        _overtimeRequests = requests;
        notifyListeners();
      },
    );
    setBusy(false);
  }

  Future<void> createOvertimeRequest({
    required String userId,
    required DateTime startTime,
    required DateTime endTime,
    required String reason,
  }) async {
    setBusy(true);
    final result = await _repository.createOvertimeRequest(
      userId: userId,
      startTime: startTime,
      endTime: endTime,
      reason: reason,
    );

    result.fold(
      (failure) => setError(failure.message),
      (request) {
        _overtimeRequests = [request, ..._overtimeRequests];
        notifyListeners();
      },
    );
    setBusy(false);
  }

  Future<void> updateOvertimeRequest({
    required String id,
    required DateTime startTime,
    required DateTime endTime,
    required String reason,
  }) async {
    setBusy(true);
    final result = await _repository.updateOvertimeRequest(
      id: id,
      startTime: startTime,
      endTime: endTime,
      reason: reason,
    );

    result.fold(
      (failure) => setError(failure.message),
      (updatedRequest) {
        final index = _overtimeRequests.indexWhere((r) => r.id == id);
        if (index != -1) {
          _overtimeRequests[index] = updatedRequest;
          notifyListeners();
        }
      },
    );
    setBusy(false);
  }

  Future<void> deleteOvertimeRequest(String id) async {
    setBusy(true);
    final result = await _repository.deleteOvertimeRequest(id);

    result.fold(
      (failure) => setError(failure.message),
      (success) {
        if (success) {
          _overtimeRequests.removeWhere((r) => r.id == id);
          notifyListeners();
        }
      },
    );
    setBusy(false);
  }

  void updateDateRange(DateTime start, DateTime end) {
    _selectedStartDate = start;
    _selectedEndDate = end;
    notifyListeners();
  }

  void updateStatus(String? status) {
    _selectedStatus = status;
    notifyListeners();
  }
}