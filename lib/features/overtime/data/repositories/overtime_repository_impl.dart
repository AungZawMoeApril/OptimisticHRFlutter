import 'package:flutter/material.dart';
import '../../domain/entities/overtime_entities.dart';
import '../../domain/repositories/overtime_repository.dart';
import '../models/overtime_models.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OvertimeRepositoryImpl implements OvertimeRepository {
  final http.Client client;

  OvertimeRepositoryImpl({required this.client});

  @override
  Future<List<OvertimeRequest>> getOvertimeRequests(String employeeId) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.overtimeByEmployee.replaceAll('{employeeId}', employeeId)}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => OvertimeRequestModel.fromJson(json))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<OvertimeRequest> createOvertimeRequest({
    required String employeeId,
    required DateTime date,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required OvertimeType type,
    required String reason,
  }) async {
    try {
      final requestModel = OvertimeRequestModel(
        id: '', // Will be assigned by the server
        employeeId: employeeId,
        date: date,
        startTime: startTime,
        endTime: endTime,
        type: type,
        reason: reason,
        status: OvertimeStatus.pending,
        hours: _calculateHours(startTime, endTime),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final response = await client.post(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.overtime}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestModel.toJson()),
      );

      if (response.statusCode == 201) {
        return OvertimeRequestModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<OvertimeRequest> updateOvertimeRequest({
    required String requestId,
    required OvertimeStatus status,
    String? approverNote,
  }) async {
    try {
      final response = await client.put(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.overtimeById.replaceAll('{id}', requestId)}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'status': status.toString().split('.').last,
          if (approverNote != null) 'approverNote': approverNote,
        }),
      );

      if (response.statusCode == 200) {
        return OvertimeRequestModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteOvertimeRequest(String requestId) async {
    try {
      final response = await client.delete(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.overtimeById.replaceAll('{id}', requestId)}'),
      );

      if (response.statusCode != 204) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<OvertimeStats> getOvertimeStats({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final queryParams = {
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      };

      final uri = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.overtimeStats.replaceAll('{employeeId}', employeeId)}')
          .replace(queryParameters: queryParams);

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        return OvertimeStatsModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  double _calculateHours(TimeOfDay startTime, TimeOfDay endTime) {
    final start = startTime.hour + startTime.minute / 60;
    final end = endTime.hour + endTime.minute / 60;
    return end > start ? end - start : (24 - start) + end;
  }

  @override
  Future<List<OvertimeRequest>> getPendingOvertimeRequests({
    required String employeeId,
    bool isApprover = false,
  }) async {
    try {
      final queryParams = {
        'status': 'pending',
        'employeeId': employeeId,
        if (isApprover) 'isApprover': 'true',
      };

      final uri = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.overtime}')
          .replace(queryParameters: queryParams);

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => OvertimeRequestModel.fromJson(json))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<OvertimeRequest> cancelOvertimeRequest(String requestId) async {
    try {
      final response = await client.put(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.overtimeById.replaceAll('{id}', requestId)}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'status': OvertimeStatus.cancelled.toString().split('.').last,
        }),
      );

      if (response.statusCode == 200) {
        return OvertimeRequestModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}