import '../entities/leave_entities.dart';
import '../repositories/leave_repository.dart';

class GetLeaveRequestsUseCase {
  final LeaveRepository _repository;

  GetLeaveRequestsUseCase(this._repository);

  Future<List<LeaveRequest>> execute(String employeeId) {
    return _repository.getLeaveRequests(employeeId);
  }
}

class CreateLeaveRequestUseCase {
  final LeaveRepository _repository;

  CreateLeaveRequestUseCase(this._repository);

  Future<LeaveRequest> execute({
    required String employeeId,
    required LeaveType type,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
    String? attachmentUrl,
  }) {
    return _repository.createLeaveRequest(
      employeeId: employeeId,
      type: type,
      startDate: startDate,
      endDate: endDate,
      reason: reason,
      attachmentUrl: attachmentUrl,
    );
  }
}

class UpdateLeaveRequestUseCase {
  final LeaveRepository _repository;

  UpdateLeaveRequestUseCase(this._repository);

  Future<LeaveRequest> execute({
    required String requestId,
    required LeaveStatus status,
    String? approverNote,
  }) {
    return _repository.updateLeaveRequest(
      requestId: requestId,
      status: status,
      approverNote: approverNote,
    );
  }
}

class CancelLeaveRequestUseCase {
  final LeaveRepository _repository;

  CancelLeaveRequestUseCase(this._repository);

  Future<void> execute(String requestId) {
    return _repository.cancelLeaveRequest(requestId);
  }
}

class GetLeaveBalanceUseCase {
  final LeaveRepository _repository;

  GetLeaveBalanceUseCase(this._repository);

  Future<LeaveBalance> execute(String employeeId) {
    return _repository.getLeaveBalance(employeeId);
  }
}

class GetLeavePoliciesUseCase {
  final LeaveRepository _repository;

  GetLeavePoliciesUseCase(this._repository);

  Future<List<LeavePolicy>> execute() {
    return _repository.getLeavePolicies();
  }
}

class GetPendingLeaveRequestsUseCase {
  final LeaveRepository _repository;

  GetPendingLeaveRequestsUseCase(this._repository);

  Future<List<LeaveRequest>> execute({
    required String employeeId,
    bool isApprover = false,
  }) {
    return _repository.getPendingLeaveRequests(
      employeeId: employeeId,
      isApprover: isApprover,
    );
  }
}