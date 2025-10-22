import '../../domain/entities/leave_entities.dart';

class LeaveRequestModel extends LeaveRequest {
  const LeaveRequestModel({
    required String id,
    required String employeeId,
    required LeaveType type,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
    required LeaveStatus status,
    String? approverNote,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? attachmentUrl,
  }) : super(
          id: id,
          employeeId: employeeId,
          type: type,
          startDate: startDate,
          endDate: endDate,
          reason: reason,
          status: status,
          approverNote: approverNote,
          createdAt: createdAt,
          updatedAt: updatedAt,
          attachmentUrl: attachmentUrl,
        );

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) {
    return LeaveRequestModel(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      type: LeaveType.values.firstWhere(
        (type) => type.toString().split('.').last == json['type'],
      ),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      reason: json['reason'] as String,
      status: LeaveStatus.values.firstWhere(
        (status) => status.toString().split('.').last == json['status'],
      ),
      approverNote: json['approverNote'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      attachmentUrl: json['attachmentUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'type': type.toString().split('.').last,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'reason': reason,
      'status': status.toString().split('.').last,
      if (approverNote != null) 'approverNote': approverNote,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      if (attachmentUrl != null) 'attachmentUrl': attachmentUrl,
    };
  }
}

class LeaveBalanceModel extends LeaveBalance {
  const LeaveBalanceModel({
    required String employeeId,
    required Map<LeaveType, double> balances,
    required DateTime lastUpdated,
  }) : super(
          employeeId: employeeId,
          balances: balances,
          lastUpdated: lastUpdated,
        );

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    final balancesMap = <LeaveType, double>{};
    (json['balances'] as Map<String, dynamic>).forEach((key, value) {
      final leaveType = LeaveType.values.firstWhere(
        (type) => type.toString().split('.').last == key,
      );
      balancesMap[leaveType] = (value as num).toDouble();
    });

    return LeaveBalanceModel(
      employeeId: json['employeeId'] as String,
      balances: balancesMap,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    final balancesJson = <String, double>{};
    balances.forEach((key, value) {
      balancesJson[key.toString().split('.').last] = value;
    });

    return {
      'employeeId': employeeId,
      'balances': balancesJson,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class LeavePolicyModel extends LeavePolicy {
  const LeavePolicyModel({
    required LeaveType type,
    required double annualAllowance,
    required bool allowsNegativeBalance,
    required int maxConsecutiveDays,
    required int minDaysNotice,
    required bool requiresAttachment,
    String? description,
  }) : super(
          type: type,
          annualAllowance: annualAllowance,
          allowsNegativeBalance: allowsNegativeBalance,
          maxConsecutiveDays: maxConsecutiveDays,
          minDaysNotice: minDaysNotice,
          requiresAttachment: requiresAttachment,
          description: description,
        );

  factory LeavePolicyModel.fromJson(Map<String, dynamic> json) {
    return LeavePolicyModel(
      type: LeaveType.values.firstWhere(
        (type) => type.toString().split('.').last == json['type'],
      ),
      annualAllowance: (json['annualAllowance'] as num).toDouble(),
      allowsNegativeBalance: json['allowsNegativeBalance'] as bool,
      maxConsecutiveDays: json['maxConsecutiveDays'] as int,
      minDaysNotice: json['minDaysNotice'] as int,
      requiresAttachment: json['requiresAttachment'] as bool,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString().split('.').last,
      'annualAllowance': annualAllowance,
      'allowsNegativeBalance': allowsNegativeBalance,
      'maxConsecutiveDays': maxConsecutiveDays,
      'minDaysNotice': minDaysNotice,
      'requiresAttachment': requiresAttachment,
      if (description != null) 'description': description,
    };
  }
}