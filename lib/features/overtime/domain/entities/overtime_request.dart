import 'package:freezed_annotation/freezed_annotation.dart';

part 'overtime_request.freezed.dart';
part 'overtime_request.g.dart';

@freezed
class OvertimeRequest with _$OvertimeRequest {
  const factory OvertimeRequest({
    required String id,
    required String userId,
    required String employeeName,
    required DateTime requestDate,
    required DateTime startTime,
    required DateTime endTime,
    required String reason,
    required String status, // 'PENDING', 'APPROVED', 'REJECTED'
    String? approverNote,
    String? approverId,
    DateTime? approvedAt,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _OvertimeRequest;

  factory OvertimeRequest.fromJson(Map<String, dynamic> json) =>
      _$OvertimeRequestFromJson(json);
}