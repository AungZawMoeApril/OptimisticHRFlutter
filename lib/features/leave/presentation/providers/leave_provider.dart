import 'package:flutter/foundation.dart';
import '../../domain/entities/leave_entities.dart';
import '../../domain/usecases/leave_usecases.dart';

enum LeaveRequestStatus {
  initial,
  loading,
  success,
  error,
}

class LeaveProvider with ChangeNotifier {
  final GetLeaveRequestsUseCase _getLeaveRequestsUseCase;
  final CreateLeaveRequestUseCase _createLeaveRequestUseCase;
  final UpdateLeaveRequestUseCase _updateLeaveRequestUseCase;
  final CancelLeaveRequestUseCase _cancelLeaveRequestUseCase;
  final GetLeaveBalanceUseCase _getLeaveBalanceUseCase;
  final GetLeavePoliciesUseCase _getLeavePoliciesUseCase;
  final GetPendingLeaveRequestsUseCase _getPendingLeaveRequestsUseCase;

  LeaveRequestStatus _status = LeaveRequestStatus.initial;
  String? _error;
  List<LeaveRequest> _leaveRequests = [];
  LeaveBalance? _leaveBalance;
  List<LeavePolicy> _leavePolicies = [];
  List<LeaveRequest> _pendingRequests = [];

  LeaveProvider({
    required GetLeaveRequestsUseCase getLeaveRequestsUseCase,
    required CreateLeaveRequestUseCase createLeaveRequestUseCase,
    required UpdateLeaveRequestUseCase updateLeaveRequestUseCase,
    required CancelLeaveRequestUseCase cancelLeaveRequestUseCase,
    required GetLeaveBalanceUseCase getLeaveBalanceUseCase,
    required GetLeavePoliciesUseCase getLeavePoliciesUseCase,
    required GetPendingLeaveRequestsUseCase getPendingLeaveRequestsUseCase,
  })  : _getLeaveRequestsUseCase = getLeaveRequestsUseCase,
        _createLeaveRequestUseCase = createLeaveRequestUseCase,
        _updateLeaveRequestUseCase = updateLeaveRequestUseCase,
        _cancelLeaveRequestUseCase = cancelLeaveRequestUseCase,
        _getLeaveBalanceUseCase = getLeaveBalanceUseCase,
        _getLeavePoliciesUseCase = getLeavePoliciesUseCase,
        _getPendingLeaveRequestsUseCase = getPendingLeaveRequestsUseCase;

  LeaveRequestStatus get status => _status;
  String? get error => _error;
  List<LeaveRequest> get leaveRequests => _leaveRequests;
  LeaveBalance? get leaveBalance => _leaveBalance;
  List<LeavePolicy> get leavePolicies => _leavePolicies;
  List<LeaveRequest> get pendingRequests => _pendingRequests;

  Future<void> getLeaveRequests(String employeeId) async {
    try {
      _status = LeaveRequestStatus.loading;
      _error = null;
      notifyListeners();

      _leaveRequests = await _getLeaveRequestsUseCase.execute(employeeId);
      _status = LeaveRequestStatus.success;
    } catch (e) {
      _error = e.toString();
      _status = LeaveRequestStatus.error;
    }
    notifyListeners();
  }

  Future<bool> createLeaveRequest({
    required String employeeId,
    required LeaveType type,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
    String? attachmentUrl,
  }) async {
    try {
      _status = LeaveRequestStatus.loading;
      _error = null;
      notifyListeners();

      final request = await _createLeaveRequestUseCase.execute(
        employeeId: employeeId,
        type: type,
        startDate: startDate,
        endDate: endDate,
        reason: reason,
        attachmentUrl: attachmentUrl,
      );

      _leaveRequests = [..._leaveRequests, request];
      _status = LeaveRequestStatus.success;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _status = LeaveRequestStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateLeaveRequest({
    required String requestId,
    required LeaveStatus status,
    String? approverNote,
  }) async {
    try {
      _status = LeaveRequestStatus.loading;
      _error = null;
      notifyListeners();

      final updatedRequest = await _updateLeaveRequestUseCase.execute(
        requestId: requestId,
        status: status,
        approverNote: approverNote,
      );

      _leaveRequests = _leaveRequests.map((request) {
        return request.id == requestId ? updatedRequest : request;
      }).toList();

      _status = LeaveRequestStatus.success;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _status = LeaveRequestStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> cancelLeaveRequest(String requestId) async {
    try {
      _status = LeaveRequestStatus.loading;
      _error = null;
      notifyListeners();

      await _cancelLeaveRequestUseCase.execute(requestId);

      _leaveRequests = _leaveRequests.where((request) => request.id != requestId).toList();
      _status = LeaveRequestStatus.success;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _status = LeaveRequestStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> getLeaveBalance(String employeeId) async {
    try {
      _status = LeaveRequestStatus.loading;
      _error = null;
      notifyListeners();

      _leaveBalance = await _getLeaveBalanceUseCase.execute(employeeId);
      _status = LeaveRequestStatus.success;
    } catch (e) {
      _error = e.toString();
      _status = LeaveRequestStatus.error;
    }
    notifyListeners();
  }

  Future<void> getLeavePolicies() async {
    try {
      _status = LeaveRequestStatus.loading;
      _error = null;
      notifyListeners();

      _leavePolicies = await _getLeavePoliciesUseCase.execute();
      _status = LeaveRequestStatus.success;
    } catch (e) {
      _error = e.toString();
      _status = LeaveRequestStatus.error;
    }
    notifyListeners();
  }

  Future<void> getPendingLeaveRequests({
    required String employeeId,
    bool isApprover = false,
  }) async {
    try {
      _status = LeaveRequestStatus.loading;
      _error = null;
      notifyListeners();

      _pendingRequests = await _getPendingLeaveRequestsUseCase.execute(
        employeeId: employeeId,
        isApprover: isApprover,
      );
      _status = LeaveRequestStatus.success;
    } catch (e) {
      _error = e.toString();
      _status = LeaveRequestStatus.error;
    }
    notifyListeners();
  }
}