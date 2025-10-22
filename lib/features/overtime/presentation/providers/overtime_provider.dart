import 'package:flutter/material.dart';
import '../../domain/entities/overtime_entities.dart';
import '../../domain/usecases/overtime_usecases.dart';

class OvertimeProvider with ChangeNotifier {
  final GetOvertimeRequests _getOvertimeRequests;
  final CreateOvertimeRequest _createOvertimeRequest;
  final UpdateOvertimeRequest _updateOvertimeRequest;
  final DeleteOvertimeRequest _deleteOvertimeRequest;
  final GetOvertimeStats _getOvertimeStats;
  final GetPendingOvertimeRequests _getPendingOvertimeRequests;
  final CancelOvertimeRequest _cancelOvertimeRequest;

  OvertimeProvider({
    required GetOvertimeRequests getOvertimeRequests,
    required CreateOvertimeRequest createOvertimeRequest,
    required UpdateOvertimeRequest updateOvertimeRequest,
    required DeleteOvertimeRequest deleteOvertimeRequest,
    required GetOvertimeStats getOvertimeStats,
    required GetPendingOvertimeRequests getPendingOvertimeRequests,
    required CancelOvertimeRequest cancelOvertimeRequest,
  })  : _getOvertimeRequests = getOvertimeRequests,
        _createOvertimeRequest = createOvertimeRequest,
        _updateOvertimeRequest = updateOvertimeRequest,
        _deleteOvertimeRequest = deleteOvertimeRequest,
        _getOvertimeStats = getOvertimeStats,
        _getPendingOvertimeRequests = getPendingOvertimeRequests,
        _cancelOvertimeRequest = cancelOvertimeRequest;

  List<OvertimeRequest> _overtimeRequests = [];
  List<OvertimeRequest> get overtimeRequests => _overtimeRequests;

  List<OvertimeRequest> _pendingRequests = [];
  List<OvertimeRequest> get pendingRequests => _pendingRequests;

  OvertimeStats? _stats;
  OvertimeStats? get stats => _stats;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> loadOvertimeRequests(String employeeId) async {
    _setLoading(true);
    _clearError();

    try {
      _overtimeRequests = await _getOvertimeRequests(employeeId);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadPendingRequests({
    required String employeeId,
    bool isApprover = false,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      _pendingRequests = await _getPendingOvertimeRequests(
        employeeId: employeeId,
        isApprover: isApprover,
      );
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createRequest({
    required String employeeId,
    required DateTime date,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required OvertimeType type,
    required String reason,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final newRequest = await _createOvertimeRequest(
        employeeId: employeeId,
        date: date,
        startTime: startTime,
        endTime: endTime,
        type: type,
        reason: reason,
      );

      _overtimeRequests = [newRequest, ..._overtimeRequests];
      _pendingRequests = [newRequest, ..._pendingRequests];
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateRequest({
    required String requestId,
    required OvertimeStatus status,
    String? approverNote,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final updatedRequest = await _updateOvertimeRequest(
        requestId: requestId,
        status: status,
        approverNote: approverNote,
      );

      _updateRequestInLists(updatedRequest);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteRequest(String requestId) async {
    _setLoading(true);
    _clearError();

    try {
      await _deleteOvertimeRequest(requestId);
      _removeRequestFromLists(requestId);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> cancelRequest(String requestId) async {
    _setLoading(true);
    _clearError();

    try {
      final cancelledRequest = await _cancelOvertimeRequest(requestId);
      _updateRequestInLists(cancelledRequest);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadStats({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      _stats = await _getOvertimeStats(
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
      );
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _updateRequestInLists(OvertimeRequest updatedRequest) {
    _overtimeRequests = _overtimeRequests.map((request) {
      return request.id == updatedRequest.id ? updatedRequest : request;
    }).toList();

    if (updatedRequest.status == OvertimeStatus.pending) {
      _pendingRequests = _pendingRequests.map((request) {
        return request.id == updatedRequest.id ? updatedRequest : request;
      }).toList();
    } else {
      _pendingRequests.removeWhere((request) => request.id == updatedRequest.id);
    }
  }

  void _removeRequestFromLists(String requestId) {
    _overtimeRequests.removeWhere((request) => request.id == requestId);
    _pendingRequests.removeWhere((request) => request.id == requestId);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }
}