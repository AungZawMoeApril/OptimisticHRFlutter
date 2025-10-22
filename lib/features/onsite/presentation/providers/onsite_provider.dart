import 'package:flutter/material.dart';
import '../../domain/entities/onsite_entities.dart';
import '../../domain/usecases/onsite_usecases.dart';

class OnsiteProvider with ChangeNotifier {
  final GetOnsiteRequests _getOnsiteRequests;
  final CreateOnsiteRequest _createOnsiteRequest;
  final UpdateOnsiteRequest _updateOnsiteRequest;
  final DeleteOnsiteRequest _deleteOnsiteRequest;
  final GetOnsiteStats _getOnsiteStats;
  final GetPendingOnsiteRequests _getPendingOnsiteRequests;
  final CancelOnsiteRequest _cancelOnsiteRequest;

  OnsiteProvider({
    required GetOnsiteRequests getOnsiteRequests,
    required CreateOnsiteRequest createOnsiteRequest,
    required UpdateOnsiteRequest updateOnsiteRequest,
    required DeleteOnsiteRequest deleteOnsiteRequest,
    required GetOnsiteStats getOnsiteStats,
    required GetPendingOnsiteRequests getPendingOnsiteRequests,
    required CancelOnsiteRequest cancelOnsiteRequest,
  })  : _getOnsiteRequests = getOnsiteRequests,
        _createOnsiteRequest = createOnsiteRequest,
        _updateOnsiteRequest = updateOnsiteRequest,
        _deleteOnsiteRequest = deleteOnsiteRequest,
        _getOnsiteStats = getOnsiteStats,
        _getPendingOnsiteRequests = getPendingOnsiteRequests,
        _cancelOnsiteRequest = cancelOnsiteRequest;

  List<OnsiteRequest> _onsiteRequests = [];
  List<OnsiteRequest> get onsiteRequests => _onsiteRequests;

  List<OnsiteRequest> _pendingRequests = [];
  List<OnsiteRequest> get pendingRequests => _pendingRequests;

  OnsiteStats? _stats;
  OnsiteStats? get stats => _stats;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _error;
  String? get error => _error;

  Future<void> loadOnsiteRequests(String employeeId) async {
    _setLoading(true);
    _clearError();

    try {
      _onsiteRequests = await _getOnsiteRequests(employeeId);
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
      _pendingRequests = await _getPendingOnsiteRequests(
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
    required DateTime startDate,
    required DateTime endDate,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required OnsiteType type,
    required String location,
    required String reason,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final newRequest = await _createOnsiteRequest(
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
        startTime: startTime,
        endTime: endTime,
        type: type,
        location: location,
        reason: reason,
      );

      _onsiteRequests = [newRequest, ..._onsiteRequests];
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
    required OnsiteStatus status,
    String? approverNote,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final updatedRequest = await _updateOnsiteRequest(
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
      await _deleteOnsiteRequest(requestId);
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
      final cancelledRequest = await _cancelOnsiteRequest(requestId);
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
      _stats = await _getOnsiteStats(
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

  void _updateRequestInLists(OnsiteRequest updatedRequest) {
    _onsiteRequests = _onsiteRequests.map((request) {
      return request.id == updatedRequest.id ? updatedRequest : request;
    }).toList();

    if (updatedRequest.status == OnsiteStatus.pending) {
      _pendingRequests = _pendingRequests.map((request) {
        return request.id == updatedRequest.id ? updatedRequest : request;
      }).toList();
    } else {
      _pendingRequests.removeWhere((request) => request.id == updatedRequest.id);
    }
  }

  void _removeRequestFromLists(String requestId) {
    _onsiteRequests.removeWhere((request) => request.id == requestId);
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