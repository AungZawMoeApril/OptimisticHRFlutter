class ApiEndpoints {
  static const String baseUrl = 'https://api.optimistichr.com/v1'; // Replace with your actual API base URL
  
  // Auth endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  
  // Employee endpoints
  static const String employees = '/employees';
  static const String employee = '/employees/{id}';
  
  // Leave endpoints
  static const String leaves = '/leaves';
  static const String leave = '/leaves/{id}';
  static const String leaveBalance = '/leaves/balance/{employeeId}';
  
  // Overtime endpoints
  static const String overtime = '/overtime';
  static const String overtimeById = '/overtime/{id}';
  static const String overtimeByEmployee = '/overtime/employee/{employeeId}';
  static const String overtimeStats = '/overtime/stats/{employeeId}';
  
  // Attendance endpoints
  static const String attendance = '/attendance';
  static const String attendanceById = '/attendance/{id}';
  static const String attendanceByEmployee = '/attendance/employee/{employeeId}';
  
  // On-site endpoints
  static const String onsite = '/onsite';
  static const String onsiteById = '/onsite/{id}';
  static const String onsiteByEmployee = '/onsite/employee/{employeeId}';
  static const String pendingOnsiteByEmployee = '/onsite/employee/{employeeId}/pending';
  static const String onsiteStats = '/onsite/employee/{employeeId}/stats';
  
  static String replacePathParams(String endpoint, Map<String, String> params) {
    String result = endpoint;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value);
    });
    return result;
  }
}