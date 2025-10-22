import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/onsite_entities.dart';
import '../../domain/repositories/onsite_repository.dart';
import '../models/onsite_models.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/onsite_local_data_source.dart';

class OnsiteRepositoryImpl implements OnsiteRepository {
  final http.Client client;
  final NetworkInfo networkInfo;
  final OnsiteLocalDataSource localDataSource;

  OnsiteRepositoryImpl({
    required this.client,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<List<OnsiteRequest>> getOnsiteRequests(String employeeId) async {
    try {
      final response = await client.get(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.onsiteByEmployee.replaceAll('{employeeId}', employeeId)}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => OnsiteRequestModel.fromJson(json))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<OnsiteRequest> createOnsiteRequest({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required OnsiteType type,
    required String location,
    required String reason,
  }) async {
    try {
      final requestModel = OnsiteRequestModel(
        id: '', // Will be assigned by the server
        employeeId: employeeId,
        startDate: startDate,
        endDate: endDate,
        startTime: startTime,
        endTime: endTime,
        type: type,
        location: location,
        reason: reason,
        status: OnsiteStatus.pending,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final response = await client.post(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.onsite}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestModel.toJson()),
      );

      if (response.statusCode == 201) {
        return OnsiteRequestModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<OnsiteRequest> updateOnsiteRequest({
    required String requestId,
    required OnsiteStatus status,
    String? approverNote,
  }) async {
    try {
      final response = await client.put(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.onsiteById.replaceAll('{id}', requestId)}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'status': status.toString().split('.').last,
          if (approverNote != null) 'approverNote': approverNote,
        }),
      );

      if (response.statusCode == 200) {
        return OnsiteRequestModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<OnsiteRequest> cancelOnsiteRequest(String requestId) async {
    try {
      final response = await client.put(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.onsiteById.replaceAll('{id}', requestId)}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'status': OnsiteStatus.cancelled.toString().split('.').last,
        }),
      );

      if (response.statusCode == 200) {
        return OnsiteRequestModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteOnsiteRequest(String requestId) async {
    try {
      final response = await client.delete(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.onsiteById.replaceAll('{id}', requestId)}'),
      );

      if (response.statusCode != 204) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<OnsiteRequest>> getPendingOnsiteRequests({
    required String employeeId,
    bool isApprover = false,
  }) async {
    try {
      final queryParams = {
        'status': 'pending',
        'employeeId': employeeId,
        if (isApprover) 'isApprover': 'true',
      };

      final uri = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.onsite}')
          .replace(queryParameters: queryParams);

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((json) => OnsiteRequestModel.fromJson(json))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<OnsiteStats> getOnsiteStats({
    required String employeeId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final queryParams = {
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      };

      final uri = Uri.parse(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.onsite}/stats/$employeeId',
      ).replace(queryParameters: queryParams);

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        return OnsiteStatsModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}