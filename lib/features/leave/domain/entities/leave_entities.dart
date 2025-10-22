import 'package:equatable/equatable.dart';

enum LeaveType {
  annual,
  sick,
  personal,
  maternity,
  paternity,
  bereavement,
  unpaid,
  other
}

enum LeaveStatus {
  pending,
  approved,
  rejected,
  cancelled
}

class LeaveRequest extends Equatable {
  final String id;
  final String employeeId;
  final LeaveType type;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final LeaveStatus status;
  final String? approverNote;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? attachmentUrl;

  const LeaveRequest({
    required this.id,
    required this.employeeId,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    this.approverNote,
    required this.createdAt,
    required this.updatedAt,
    this.attachmentUrl,
  });

  int get numberOfDays {
    return endDate.difference(startDate).inDays + 1;
  }

  bool get isPending => status == LeaveStatus.pending;
  bool get isApproved => status == LeaveStatus.approved;
  bool get isRejected => status == LeaveStatus.rejected;
  bool get isCancelled => status == LeaveStatus.cancelled;

  @override
  List<Object?> get props => [
        id,
        employeeId,
        type,
        startDate,
        endDate,
        reason,
        status,
        approverNote,
        createdAt,
        updatedAt,
        attachmentUrl,
      ];
}

class LeaveBalance extends Equatable {
  final String employeeId;
  final Map<LeaveType, double> balances;
  final DateTime lastUpdated;

  const LeaveBalance({
    required this.employeeId,
    required this.balances,
    required this.lastUpdated,
  });

  double getBalance(LeaveType type) => balances[type] ?? 0;

  @override
  List<Object?> get props => [employeeId, balances, lastUpdated];
}

class LeavePolicy {
  final LeaveType type;
  final double annualAllowance;
  final bool allowsNegativeBalance;
  final int maxConsecutiveDays;
  final int minDaysNotice;
  final bool requiresAttachment;
  final String? description;

  const LeavePolicy({
    required this.type,
    required this.annualAllowance,
    required this.allowsNegativeBalance,
    required this.maxConsecutiveDays,
    required this.minDaysNotice,
    required this.requiresAttachment,
    this.description,
  });
}