import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/errors/exceptions.dart';
import '../models/personal_info_model.dart';
import '../models/announcement_model.dart';
import '../../domain/entities/attendance_status.dart';
import '/backend/api_requests/api_calls.dart';

abstract class HomeRemoteDataSource {
  Future<PersonalInfoModel> getPersonalInfo(String companyId, String employeeId, String token);
  Future<AttendanceStatus> getAttendanceStatus(
      String companyId, String employeeId, String token, String todayDate);
  Future<int> getNotificationCount(String companyId, String employeeId, String token);
  Future<List<AnnouncementModel>> getAnnouncements(
      String companyId, String employeeId, String token);
  Future<void> updateAttendanceStatus(
      String companyId, String employeeId, String token, String timeType, bool isCheckIn);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<PersonalInfoModel> getPersonalInfo(
    String companyId,
    String employeeId,
    String token,
  ) async {
    try {
      final result = await GetPersonalInfoCall.call(
        companyIDMain: int.parse(companyId),
        employeeIDMain: int.parse(employeeId),
        token: token,
        todayDateMain: DateTime.now().toString(),
      );

      if (result.succeeded) {
        // Parse jsonBody which is a String to Map
        final Map<String, dynamic> jsonData = result.jsonBody is String
            ? json.decode(result.jsonBody!)
            : result.jsonBody as Map<String, dynamic>;

        if (GetPersonalInfoCall.apiStatus(jsonData.toString()) == 0) {
          return PersonalInfoModel.fromJson(jsonData);
        }
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<AttendanceStatus> getAttendanceStatus(
    String companyId,
    String employeeId,
    String token,
    String todayDate,
  ) async {
    try {
      final response = await client.post(
        Uri.parse('YOUR_API_URL/attendance-status'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'company_id': companyId,
          'employee_id': employeeId,
          'date': todayDate,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AttendanceStatus(
          clockInTime: data['clock_in'] ?? '-',
          clockOutTime: data['clock_out'] ?? '-',
          shiftStartTime: data['shift_start'] ?? '09:00',
          shiftEndTime: data['shift_end'] ?? '18:00',
          timeType: data['time_type'] ?? 'regular',
          canCheckIn: data['can_check_in'] ?? true,
          approve: data['approve'] ?? false,
        );
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateAttendanceStatus(
    String companyId,
    String employeeId,
    String token,
    String timeType,
    bool isCheckIn,
  ) async {
    try {
      final response = await client.post(
        Uri.parse('YOUR_API_URL/attendance/update'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'company_id': companyId,
          'employee_id': employeeId,
          'time_type': timeType,
          'is_check_in': isCheckIn,
        }),
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<int> getNotificationCount(
    String companyId,
    String employeeId,
    String token,
  ) async {
    try {
      final response = await client.post(
        Uri.parse('YOUR_API_URL/notifications/count'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'company_id': companyId,
          'employee_id': employeeId,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['count'] ?? 0;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<AnnouncementModel>> getAnnouncements(
    String companyId,
    String employeeId,
    String token,
  ) async {
    try {
      final response = await client.post(
        Uri.parse('YOUR_API_URL/announcements'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'company_id': companyId,
          'employee_id': employeeId,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['announcements'] as List)
            .map((json) => AnnouncementModel.fromJson(json))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
