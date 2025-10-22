import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/errors/exceptions.dart';
import '../models/personal_info_model.dart';
import '../models/announcement_model.dart';
import '/backend/api_requests/api_calls.dart';

abstract class HomeRemoteDataSource {
  Future<PersonalInfoModel> getPersonalInfo(String companyId, String employeeId, String token);
  Future<Map<String, String>> getAttendanceStatus(String companyId, String employeeId, String token);
  Future<int> getNotificationCount(String companyId, String employeeId, String token);
  Future<List<AnnouncementModel>> getAnnouncements(String companyId, String employeeId, String token);
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
      final result = await MainGroup.getPersonalInfoCall.call(
        companyIDMain: int.parse(companyId),
        employeeIDMain: int.parse(employeeId),
        token: token,
        todayDateMain: DateTime.now().toString(),
      );

      if (result.succeeded && MainGroup.getPersonalInfoCall.apiStatus(result.jsonBody) == 0) {
        return PersonalInfoModel.fromJson(result.jsonBody);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Map<String, String>> getAttendanceStatus(
    String companyId,
    String employeeId,
    String token,
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
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'clockIn': data['clock_in'] ?? '-',
          'clockOut': data['clock_out'] ?? '-',
        };
      } else {
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