import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_request.freezed.dart';
part 'leave_request.g.dart';

@freezed
class LeaveRequest with _$LeaveRequest {
  const factory LeaveRequest({
    required String id,
    required String userId,
    required String employeeName,
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    required double duration,
    required String reason,
    required String status, // 'PENDING', 'APPROVED', 'REJECTED'
    String? approverNote,
    String? approverId,
    DateTime? approvedAt,
    String? attachmentUrl,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _LeaveRequest;

  factory LeaveRequest.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestFromJson(json);
}