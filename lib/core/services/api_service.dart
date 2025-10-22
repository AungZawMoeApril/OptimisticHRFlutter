import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/leave_balance.dart';

class ApiService {
  static const String baseUrl = 'YOUR_API_BASE_URL';

  static Future<LeaveBalanceResponse> getLeaveBalance({
    required String? companyId,
    required String? employeeId,
    required String? token,
  }) async {
    if (companyId == null || employeeId == null || token == null) {
      throw Exception('Required parameters are missing');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/leave/balance'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return LeaveBalanceResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load leave balance');
    }
  }

  static Future<void> updateLeaveRequest({
    required String timeOffRequestId,
    required String timeoffId,
    required bool wholeDay,
    required String startDate,
    required String? endDate,
    required String? startTime,
    required String? endTime,
    required String message,
    required String balance,
    required bool saveDraft,
    required String companyId,
    required List<Map<String, dynamic>> attachments,
    required String token,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/leave/update'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'timeOffRequestId': timeOffRequestId,
        'timeoffId': timeoffId,
        'wholeDay': wholeDay,
        'startDate': startDate,
        'endDate': endDate,
        'startTime': startTime,
        'endTime': endTime,
        'message': message,
        'balance': balance,
        'saveDraft': saveDraft,
        'companyId': companyId,
        'attachments': attachments,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update leave request');
    }
  }
}