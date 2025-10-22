import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/check_in_record.dart';
import '../../domain/repositories/check_in_out_repository.dart';
import '../models/check_in_record_model.dart';

class CheckInOutRepositoryImpl implements CheckInOutRepository {
  final String baseUrl;
  final http.Client _client;

  CheckInOutRepositoryImpl({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  @override
  Future<CheckInRecord> checkIn({
    required String employeeId,
    required String location,
    required double latitude,
    required double longitude,
    String? notes,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/attendance/check-in'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'employeeId': employeeId,
          'location': location,
          'latitude': latitude,
          'longitude': longitude,
          if (notes != null) 'notes': notes,
        }),
      );

      if (response.statusCode == 201) {
        return CheckInRecordModel.fromJson(
          jsonDecode(response.body),
        );
      } else {
        throw Exception('Check-in failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Check-in failed: $e');
    }
  }

  @override
  Future<CheckInRecord> checkOut({
    required String recordId,
    required String location,
    required double latitude,
    required double longitude,
    String? notes,
  }) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl/attendance/check-out/$recordId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'location': location,
          'latitude': latitude,
          'longitude': longitude,
          if (notes != null) 'notes': notes,
        }),
      );

      if (response.statusCode == 200) {
        return CheckInRecordModel.fromJson(
          jsonDecode(response.body),
        );
      } else {
        throw Exception('Check-out failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Check-out failed: $e');
    }
  }

  @override
  Future<List<CheckInRecord>> getAttendanceHistory({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$baseUrl/attendance/history?employeeId=$employeeId&startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((json) => CheckInRecordModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to get attendance history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get attendance history: $e');
    }
  }

  @override
  Future<CheckInRecord?> getCurrentDayRecord(String employeeId) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/attendance/current-day/$employeeId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data != null ? CheckInRecordModel.fromJson(data) : null;
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Failed to get current day record: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get current day record: $e');
    }
  }

  @override
  Future<AttendanceStats> getAttendanceStats({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$baseUrl/attendance/stats?employeeId=$employeeId&startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AttendanceStats(
          totalDays: data['totalDays'],
          presentDays: data['presentDays'],
          lateDays: data['lateDays'],
          earlyCheckouts: data['earlyCheckouts'],
          absentDays: data['absentDays'],
          leaveDays: data['leaveDays'],
          holidays: data['holidays'],
        );
      } else {
        throw Exception('Failed to get attendance stats: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get attendance stats: $e');
    }
  }
}