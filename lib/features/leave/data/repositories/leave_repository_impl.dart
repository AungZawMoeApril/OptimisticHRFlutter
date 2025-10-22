import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/leave_entities.dart';
import '../../domain/repositories/leave_repository.dart';
import '../models/leave_models.dart';

class LeaveRepositoryImpl implements LeaveRepository {
  final String baseUrl;
  final http.Client _client;

  LeaveRepositoryImpl({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  @override
  Future<List<LeaveRequest>> getLeaveRequests(String employeeId) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/leave/requests/$employeeId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => LeaveRequestModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get leave requests: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get leave requests: $e');
    }
  }

  @override
  Future<LeaveRequest> createLeaveRequest({
    required String employeeId,
    required LeaveType type,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
    String? attachmentUrl,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/leave/requests'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'employeeId': employeeId,
          'type': type.toString().split('.').last,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
          'reason': reason,
          if (attachmentUrl != null) 'attachmentUrl': attachmentUrl,
        }),
      );

      if (response.statusCode == 201) {
        return LeaveRequestModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create leave request: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create leave request: $e');
    }
  }

  @override
  Future<LeaveRequest> updateLeaveRequest({
    required String requestId,
    required LeaveStatus status,
    String? approverNote,
  }) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl/leave/requests/$requestId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'status': status.toString().split('.').last,
          if (approverNote != null) 'approverNote': approverNote,
        }),
      );

      if (response.statusCode == 200) {
        return LeaveRequestModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update leave request: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update leave request: $e');
    }
  }

  @override
  Future<void> cancelLeaveRequest(String requestId) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl/leave/requests/$requestId'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to cancel leave request: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to cancel leave request: $e');
    }
  }

  @override
  Future<LeaveBalance> getLeaveBalance(String employeeId) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/leave/balance/$employeeId'),
      );

      if (response.statusCode == 200) {
        return LeaveBalanceModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to get leave balance: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get leave balance: $e');
    }
  }

  @override
  Future<List<LeavePolicy>> getLeavePolicies() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/leave/policies'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => LeavePolicyModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get leave policies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get leave policies: $e');
    }
  }

  @override
  Future<List<LeaveRequest>> getPendingLeaveRequests({
    required String employeeId,
    bool isApprover = false,
  }) async {
    try {
      final endpoint = isApprover
          ? '$baseUrl/leave/requests/pending/approver/$employeeId'
          : '$baseUrl/leave/requests/pending/$employeeId';

      final response = await _client.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => LeaveRequestModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get pending leave requests: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get pending leave requests: $e');
    }
  }
}