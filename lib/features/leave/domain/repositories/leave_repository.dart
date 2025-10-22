import '../entities/leave_entities.dart';

abstract class LeaveRepository {
  Future<List<LeaveRequest>> getLeaveRequests(String employeeId);

  Future<LeaveRequest> createLeaveRequest({
    required String employeeId,
    required LeaveType type,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
    String? attachmentUrl,
  });

  Future<LeaveRequest> updateLeaveRequest({
    required String requestId,
    required LeaveStatus status,
    String? approverNote,
  });

  Future<void> cancelLeaveRequest(String requestId);

  Future<LeaveBalance> getLeaveBalance(String employeeId);

  Future<List<LeavePolicy>> getLeavePolicies();

  Future<List<LeaveRequest>> getPendingLeaveRequests({
    required String employeeId,
    bool isApprover = false,
  });
}