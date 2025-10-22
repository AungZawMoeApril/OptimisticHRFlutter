import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  final Dio _dio = Dio();

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _dio.options.baseUrl = 'YOUR_BASE_URL';
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<Response> getTimeAttendanceList({
    required String employeeId,
    required String companyId,
    required String token,
  }) async {
    try {
      final response = await _dio.get(
        '/time-attendance/list',
        queryParameters: {
          'employeeId': employeeId,
          'companyId': companyId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

// API Response model
class ApiResponse<T> {
  final bool succeeded;
  final String? message;
  final T? data;
  final int statusCode;

  ApiResponse({
    required this.succeeded,
    this.message,
    this.data,
    required this.statusCode,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJson) {
    return ApiResponse(
      succeeded: json['succeeded'] ?? false,
      message: json['message'],
      data: json['data'] != null ? fromJson(json['data']) : null,
      statusCode: json['statusCode'] ?? 500,
    );
  }
}

// Time Attendance model
class TimeAttendanceList {
  final String id;
  final String timeEntryDate;
  final String clockInTime;
  final String clockOutTime;
  final String clockInLocation;
  final String checkInStatus;
  final String remark;

  TimeAttendanceList({
    required this.id,
    required this.timeEntryDate,
    required this.clockInTime,
    required this.clockOutTime,
    required this.clockInLocation,
    required this.checkInStatus,
    required this.remark,
  });

  factory TimeAttendanceList.fromJson(Map<String, dynamic> json) {
    return TimeAttendanceList(
      id: json['id'] ?? '',
      timeEntryDate: json['timeEntry_Date'] ?? '',
      clockInTime: json['clock_In_Time'] ?? '',
      clockOutTime: json['clock_Out_Time'] ?? '',
      clockInLocation: json['clock_In_Location'] ?? '',
      checkInStatus: json['checkIn_Status'] ?? '',
      remark: json['remark'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'timeEntry_Date': timeEntryDate,
    'clock_In_Time': clockInTime,
    'clock_Out_Time': clockOutTime,
    'clock_In_Location': clockInLocation,
    'checkIn_Status': checkInStatus,
    'remark': remark,
  };
}